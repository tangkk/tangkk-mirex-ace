'''
A chord classifier based on bidirectional CTC
'''

from collections import OrderedDict
import cPickle as pkl
import sys
import time

import numpy
import theano
from theano import config
import theano.tensor as T
from theano.sandbox.rng_mrg import MRG_RandomStreams as RandomStreams

from acesongdb import load_data_song

use_dropout=True
max_epochs = 100000 # give it long enough time to train
batch_size = 500 # length of a sample training piece within a song in terms of number of frames

# Set the random number generators' seeds for consistency
SEED = 123
# numpy.random.seed(SEED)

def numpy_floatX(data):
    return numpy.asarray(data, dtype=config.floatX)


def get_minibatches_idx(n, minibatch_size, shuffle=False):
    """
    Used to shuffle the dataset at each iteration.
    """

    idx_list = numpy.arange(n, dtype="int32")

    if shuffle:
        numpy.random.shuffle(idx_list)

    minibatches = []
    minibatch_start = 0
    for i in range(n // minibatch_size):
        minibatches.append(idx_list[minibatch_start:
                                    minibatch_start + minibatch_size])
        minibatch_start += minibatch_size

    if (minibatch_start != n):
        # Make a minibatch out of what is left
        minibatches.append(idx_list[minibatch_start:])

    return zip(range(len(minibatches)), minibatches)


def get_dataset(name):
    return datasets[name][0], datasets[name][1]


def zipp(params, tparams):
    """
    When we reload the model. Needed for the GPU stuff.
    """
    for kk, vv in params.iteritems():
        tparams[kk].set_value(vv)


def unzip(zipped):
    """
    When we pickle the model. Needed for the GPU stuff.
    """
    new_params = OrderedDict()
    for kk, vv in zipped.iteritems():
        new_params[kk] = vv.get_value()
    return new_params


def dropout_layer(state_before, use_noise, trng):
    # at training time, use_noise is set to 1,
    # dropout is applied to proj, each unit of proj is presented at a chance of p
    # at test/validation time, use_noise is set to 0,
    # each unit of proj is always presented, and their activations are multiplied by p
    # by default p=0.5 (can be changed)
    # and different p can be applied to different layers, even the input layer
    proj = T.switch(use_noise,
                         (state_before *
                          trng.binomial(state_before.shape,
                                        p=0.5, n=1,
                                        dtype=state_before.dtype)),
                         state_before * 0.5)
    return proj


def _p(pp, name):
    return '%s_%s' % (pp, name)


def init_params(options):
    """
    Global (not LSTM) parameter. For the embeding and the classifier.
    """
    params = OrderedDict()
    params = get_layer(options['encoder'])[0](options,
                                              params,
                                              prefix=options['encoder'])
    # classifier
    params['U'] = 0.01 * numpy.random.randn(2*options['dim_proj'],
                                            options['ydim']).astype(config.floatX)
    params['b'] = numpy.zeros((options['ydim'],)).astype(config.floatX)

    return params


def load_params(path, params):
    pp = numpy.load(path)
    for kk, vv in params.iteritems():
        if kk not in pp:
            raise Warning('%s is not in the archive' % kk)
        params[kk] = pp[kk]

    return params


def init_tparams(params):
    tparams = OrderedDict()
    for kk, pp in params.iteritems():
        tparams[kk] = theano.shared(params[kk], name=kk)
    return tparams


def get_layer(name):
    fns = layers[name]
    return fns


def random_weight(n_in,n_out=0):
    if n_out == 0:
       n_out = n_in 
    W = numpy.asarray(
                rng.uniform(
                    low=-numpy.sqrt(6. / (n_in + n_out)),
                    high=numpy.sqrt(6. / (n_in + n_out)),
                    size=(n_in, n_out)
                ),
                dtype=theano.config.floatX
            )
    return W
    
def ortho_weight(ndim1, ndim2):
    W = numpy.random.randn(ndim1, ndim2)
    if ndim1 == ndim2:
        u, s, v = numpy.linalg.svd(W)
        return u.astype(config.floatX)
    elif ndim1 < ndim2:
        u, s, v = numpy.linalg.svd(W,full_matrices=0)
        return v.astype(config.floatX)
    elif ndim1 > ndim2:
        u, s, v = numpy.linalg.svd(W,full_matrices=0)
        return u.astype(config.floatX)


def param_init_lstm(options, params, prefix='lstm'):
    """
    Init the LSTM parameter:

    :see: init_params
    """
    # note that this set of 'W','U' and 'b' are for LSTM layer, thus they have prefix in their names
    # W are the input weights
    
    # these are for the forward pass
    W = numpy.concatenate([ortho_weight(options['xdim'],options['dim_proj']),
                           ortho_weight(options['xdim'],options['dim_proj']),
                           ortho_weight(options['xdim'],options['dim_proj']),
                           ortho_weight(options['xdim'],options['dim_proj'])], axis=1)
    params[_p(prefix, 'W')] = W # "lstm_W"
    # U are recurrent weights
    U = numpy.concatenate([ortho_weight(options['dim_proj'],options['dim_proj']),
                           ortho_weight(options['dim_proj'],options['dim_proj']),
                           ortho_weight(options['dim_proj'],options['dim_proj']),
                           ortho_weight(options['dim_proj'],options['dim_proj'])], axis=1)
    params[_p(prefix, 'U')] = U # "lstm_U"
    # b are bias
    b = numpy.zeros((4 * options['dim_proj'],))
    params[_p(prefix, 'b')] = b.astype(config.floatX) # "lstm_b"
    
    # these are for the backward pass
    Wb = numpy.concatenate([ortho_weight(options['xdim'],options['dim_proj']),
                           ortho_weight(options['xdim'],options['dim_proj']),
                           ortho_weight(options['xdim'],options['dim_proj']),
                           ortho_weight(options['xdim'],options['dim_proj'])], axis=1)
    params[_p(prefix, 'Wb')] = Wb # "lstm_Wb"
    # U are recurrent weights
    Ub = numpy.concatenate([ortho_weight(options['dim_proj'],options['dim_proj']),
                           ortho_weight(options['dim_proj'],options['dim_proj']),
                           ortho_weight(options['dim_proj'],options['dim_proj']),
                           ortho_weight(options['dim_proj'],options['dim_proj'])], axis=1)
    params[_p(prefix, 'Ub')] = Ub # "lstm_Ub"
    # b are bias
    bb = numpy.zeros((4 * options['dim_proj'],))
    params[_p(prefix, 'bb')] = bb.astype(config.floatX) # "lstm_bb"
    
    return params #[lstm_W, lstm_U, lstm_b]


def lstm_layer(tparams, x, y, use_noise, options, prefix='lstm'):
    n_timesteps = x.shape[0]
    xb = x[::-1]

    def _slice(_x, n, dim):
        return _x[n * dim:(n + 1) * dim]
    
    def _step(x_, xb_, h_, c_, hb_, cb_):
        preact = T.dot(h_, tparams[_p(prefix, 'U')])
        preact += T.dot(x_, tparams[_p(prefix, 'W')])
        preact += tparams[_p(prefix, 'b')]

        i = T.nnet.sigmoid(_slice(preact, 0, options['dim_proj']))
        f = T.nnet.sigmoid(_slice(preact, 1, options['dim_proj']))
        o = T.nnet.sigmoid(_slice(preact, 2, options['dim_proj']))
        c = T.tanh(_slice(preact, 3, options['dim_proj']))

        c = f * c_ + i * c
        h = o * T.tanh(c)
        
        preactb = T.dot(hb_, tparams[_p(prefix, 'Ub')])
        preactb += T.dot(xb_, tparams[_p(prefix, 'Wb')])
        preactb += tparams[_p(prefix, 'bb')]

        ib = T.nnet.sigmoid(_slice(preactb, 0, options['dim_proj']))
        fb = T.nnet.sigmoid(_slice(preactb, 1, options['dim_proj']))
        ob = T.nnet.sigmoid(_slice(preactb, 2, options['dim_proj']))
        cb = T.tanh(_slice(preactb, 3, options['dim_proj']))

        cb = fb * cb_ + ib * cb
        hb = ob * T.tanh(cb)
        
        # take the reverse of hb and concatenate with h before feeding into logistic regression
        hhb = T.concatenate([h,hb[::-1]])
        # a single frame prediction given h - the posterior probablity
        one_pred = T.nnet.softmax(T.dot(hhb, tparams['U']) + tparams['b'])
        
        return h, c, hb, cb, one_pred
    
    dim_proj = options['dim_proj']
    ydim = options['ydim']
    # the scan function takse one dim_proj vector of x and one target of y at a time
    # the output is:
    # rval[0] -- n_timesteps of h -- n_timesteps * dim_proj
    # rval[1] -- n_timesteps of c -- n_timesteps * dim_proj
    # rval[2] -- n_timesteps of one_pred -- n_timesteps * ydim
    rval, updates = theano.scan(_step,
                                sequences=[x,xb],
                                outputs_info=[T.alloc(numpy_floatX(0.),
                                                           dim_proj),
                                              T.alloc(numpy_floatX(0.),
                                                           dim_proj),
                                              T.alloc(numpy_floatX(0.),
                                                           dim_proj),
                                              T.alloc(numpy_floatX(0.),
                                                           dim_proj),
                                              None],
                                name=_p(prefix, '_layers'),
                                n_steps=n_timesteps)
    
    pred = rval[4]
    pred = T.flatten(pred,2)
    
    trng = RandomStreams(123)
    if options['use_dropout']:
        pred = dropout_layer(pred, use_noise, trng)
    
    # CTC forward-backward pass, adapted from:
    # https://blog.wtf.sg/2014/10/06/connectionist-temporal-classification-ctc-with-theano/
    def recurrence_relation(size):
        big_I = T.eye(size+2)
        return T.eye(size) + big_I[2:,1:-1] + big_I[2:,:-2] * (T.arange(size) % 2)
        
    def recurrence_relation_(y_, blank_symbol):
        y = y_.dimshuffle(0,'x')
        n_y = y.shape[0]
        blanks = T.zeros((2, y.shape[1])) + blank_symbol
        ybb = T.concatenate((y, blanks), axis=0).T
        sec_diag = (T.neq(ybb[:, :-2], ybb[:, 2:]) *
                    T.eq(ybb[:, 1:-1], blank_symbol))

        # r1: LxL
        # r2: LxL
        # r3: LxL
        r2 = T.eye(n_y, k=1)
        r3 = (T.eye(n_y, k=2) * sec_diag)

        return r2, r3
        
    def _epslog(x):
        return T.cast(T.log(T.clip(x, 1E-12, 1E12)),
                           theano.config.floatX)

    def log_add(a, b):
        max_ = T.maximum(a, b)
        return (max_ + T.log1p(T.exp(a + b - 2 * max_)))

    def log_dot_matrix(x, z):
        inf = 1E12
        log_dot = T.dot(x, z)
        zeros_to_minus_inf = (z.max(axis=0) - 1) * inf
        return log_dot + zeros_to_minus_inf

    def log_dot_tensor(x, z):
        inf = 1E12
        log_dot = (x * z).sum(axis=0).T
        zeros_to_minus_inf = (z.max(axis=0) - 1) * inf
        return log_dot + zeros_to_minus_inf.T
    
    def path_probs(predict,y):
        # P = predict[:,y]
        P = predict[T.arange(y.shape[0]), y]
        rr = recurrence_relation(y.shape[0])
        def step(p_curr,p_prev):
            return (p_curr * T.dot(p_prev,rr)).astype(theano.config.floatX)
        probs,_ = theano.scan(
                step,
                sequences = [P],
                outputs_info = [T.eye(y.shape[0])[0]]
            )
        return probs
        
    def log_path_probs(predict,y):
        pred_y = predict[T.arange(y.shape[0]), y]
        blank_symbol = options['ydim']
        r2, r3 = recurrence_relation_(y, blank_symbol)
        # rr = recurrence_relation(y.shape[0])
        # r2 = rr
        # r3 = rr
        def step(log_p_curr, log_p_prev):
            p1 = log_p_prev
            p2 = log_dot_matrix(p1, r2)
            p3 = log_dot_tensor(p1, r3)
            p123 = log_add(p3, log_add(p1, p2))

            return (log_p_curr.T +
                    p123).astype(theano.config.floatX)

        log_probabilities, _ = theano.scan(
            step,
            sequences=[_epslog(pred_y)],
            outputs_info=[_epslog(T.eye(y.shape[0])[0] *
                                      T.ones(y.T.shape))])
        return log_probabilities
        
    def ctc_cost(predict,y):
        forward_probs  = path_probs(predict,y)
        backward_probs = path_probs(predict[::-1],y[::-1])[::-1,::-1]
        probs = forward_probs * backward_probs / predict[:,y]
        total_prob = T.sum(probs)
        return -T.log(total_prob)
        
    def log_ctc_cost(predict,y):
        off = 1e-8
        forward_probs  = log_path_probs(predict,y)
        backward_probs = log_path_probs(predict[::-1],y[::-1])[::-1,::-1]
        probs = log_add(forward_probs,backward_probs)
        total_prob = T.mean(probs)
        return -total_prob
        
    # ctc cost - with DP
    cost = log_ctc_cost(pred, y)
    
    
    # pred will be -- n_timesteps * ydim posterior probs
    f_pred_prob = theano.function([x], pred, name='f_pred_prob')
    # pred.argmax(axis=1) will be -- n_timesteps * 1 one hot prediction
    f_pred = theano.function([x], pred.argmax(axis=1), name='f_pred')
    
    # cost will be a scaler value
    # compile a function for the cost for one frame given one_pred and one_y (or y_)
    # cost is a scaler, where y is a n_timesteps * 1 target vector
    # Each prediction is conditionally independent give x
    # thus the posterior of p(pi|x) should be the product of each posterior
    # off = 1e-8
    # cost = -T.log(pred[T.arange(y.shape[0]), y] + off).mean()
    
    return f_pred_prob, f_pred, cost


# ff: Feed Forward (normal neural net), only useful to put after lstm
#     before the classifier.
layers = {'lstm': (param_init_lstm, lstm_layer)}


def sgd(lr, tparams, grads, x, y, cost):
    """ Stochastic Gradient Descent

    :note: A more complicated version of sgd then needed.  This is
        done like that for adadelta and rmsprop.

    """
    # New set of shared variable that will contain the gradient
    # for a mini-batch.
    gshared = [theano.shared(p.get_value() * 0., name='%s_grad' % k)
               for k, p in tparams.iteritems()]
    gsup = [(gs, g) for gs, g in zip(gshared, grads)]

    # Function that computes gradients for a mini-batch, but do not
    # updates the weights.
    f_grad_shared = theano.function([x, y], cost, updates=gsup,
                                    name='sgd_f_grad_shared')

    pup = [(p, p - lr * g) for p, g in zip(tparams.values(), gshared)]

    # Function that updates the weights from the previously computed
    # gradient.
    f_update = theano.function([lr], [], updates=pup,
                               name='sgd_f_update')

    return f_grad_shared, f_update


def adadelta(lr, tparams, grads, x, y, cost):
    """
    An adaptive learning rate optimizer

    Parameters
    ----------
    lr : Theano SharedVariable
        Initial learning rate
    tpramas: Theano SharedVariable
        Model parameters
    grads: Theano variable
        Gradients of cost w.r.t to parameres
    x: Theano variable
        Model inputs
    y: Theano variable
        Targets
    cost: Theano variable
        Objective fucntion to minimize

    Notes
    -----
    For more information, see [ADADELTA]_.

    .. [ADADELTA] Matthew D. Zeiler, *ADADELTA: An Adaptive Learning
       Rate Method*, arXiv:1212.5701.
    """

    zipped_grads = [theano.shared(p.get_value() * numpy_floatX(0.),
                                  name='%s_grad' % k)
                    for k, p in tparams.iteritems()]
    running_up2 = [theano.shared(p.get_value() * numpy_floatX(0.),
                                 name='%s_rup2' % k)
                   for k, p in tparams.iteritems()]
    running_grads2 = [theano.shared(p.get_value() * numpy_floatX(0.),
                                    name='%s_rgrad2' % k)
                      for k, p in tparams.iteritems()]

    zgup = [(zg, g) for zg, g in zip(zipped_grads, grads)]
    rg2up = [(rg2, 0.95 * rg2 + 0.05 * (g ** 2))
             for rg2, g in zip(running_grads2, grads)]

    f_grad_shared = theano.function([x, y], cost, updates=zgup + rg2up,
                                    name='adadelta_f_grad_shared')

    updir = [-T.sqrt(ru2 + 1e-6) / T.sqrt(rg2 + 1e-6) * zg
             for zg, ru2, rg2 in zip(zipped_grads,
                                     running_up2,
                                     running_grads2)]
    ru2up = [(ru2, 0.95 * ru2 + 0.05 * (ud ** 2))
             for ru2, ud in zip(running_up2, updir)]
    param_up = [(p, p + ud) for p, ud in zip(tparams.values(), updir)]

    f_update = theano.function([lr], [], updates=ru2up + param_up,
                               on_unused_input='ignore',
                               name='adadelta_f_update')

    return f_grad_shared, f_update


def rmsprop(lr, tparams, grads, x, y, cost):
    """
    A variant of  SGD that scales the step size by running average of the
    recent step norms.

    Parameters
    ----------
    lr : Theano SharedVariable
        Initial learning rate
    tpramas: Theano SharedVariable
        Model parameters
    grads: Theano variable
        Gradients of cost w.r.t to parameres
    x: Theano variable
        Model inputs
    y: Theano variable
        Targets
    cost: Theano variable
        Objective fucntion to minimize

    Notes
    -----
    For more information, see [Hint2014]_.

    .. [Hint2014] Geoff Hinton, *Neural Networks for Machine Learning*,
       lecture 6a,
       http://cs.toronto.edu/~tijmen/csc321/slides/lecture_slides_lec6.pdf
    """

    zipped_grads = [theano.shared(p.get_value() * numpy_floatX(0.),
                                  name='%s_grad' % k)
                    for k, p in tparams.iteritems()]
    running_grads = [theano.shared(p.get_value() * numpy_floatX(0.),
                                   name='%s_rgrad' % k)
                     for k, p in tparams.iteritems()]
    running_grads2 = [theano.shared(p.get_value() * numpy_floatX(0.),
                                    name='%s_rgrad2' % k)
                      for k, p in tparams.iteritems()]

    zgup = [(zg, g) for zg, g in zip(zipped_grads, grads)]
    rgup = [(rg, 0.95 * rg + 0.05 * g) for rg, g in zip(running_grads, grads)]
    rg2up = [(rg2, 0.95 * rg2 + 0.05 * (g ** 2))
             for rg2, g in zip(running_grads2, grads)]

    f_grad_shared = theano.function([x, y], cost,
                                    updates=zgup + rgup + rg2up,
                                    name='rmsprop_f_grad_shared')

    updir = [theano.shared(p.get_value() * numpy_floatX(0.),
                           name='%s_updir' % k)
             for k, p in tparams.iteritems()]
    updir_new = [(ud, 0.9 * ud - 1e-4 * zg / T.sqrt(rg2 - rg ** 2 + 1e-4))
                 for ud, zg, rg, rg2 in zip(updir, zipped_grads, running_grads,
                                            running_grads2)]
    param_up = [(p, p + udn[1])
                for p, udn in zip(tparams.values(), updir_new)]
    f_update = theano.function([lr], [], updates=updir_new + param_up,
                               on_unused_input='ignore',
                               name='rmsprop_f_update')

    return f_grad_shared, f_update


def build_model(tparams, options):
    trng = RandomStreams(SEED)

    # Used for dropout.
    use_noise = theano.shared(numpy_floatX(0.))

    x = T.matrix('x', dtype=config.floatX)
    y = T.vector('y', dtype='int64')
    
    f_pred_prob, f_pred, cost = get_layer(options['encoder'])[1](tparams, x, y, use_noise, options,
                                            prefix=options['encoder'])
                                           

    return use_noise, x, y, f_pred_prob, f_pred, cost


def pred_error(f_pred, data, verbose=False):
    """
    Just compute the error
    f_pred: Theano fct computing the prediction
    prepare_data: usual prepare_data for that dataset.
    """
    # idx0 = numpy.random.randint(0,len(data[0]))
    lendata = len(data[0])
    
    sum_valid_err = 0
    # loop over the valid/test set and predict the error for every song
    for idx0 in range(lendata):
        # on one whole random song
        x = data[0][idx0]
        y = data[1][idx0]

        preds = f_pred(x)
        targets = y
        valid_err = (preds == targets).sum()
        valid_err = 1. - numpy_floatX(valid_err) / len(y)
        sum_valid_err += valid_err
        
    sum_valid_err = sum_valid_err / lendata

    return sum_valid_err

def predprobs(model, X):
    model_options = OrderedDict()
    tparams = init_tparams(model)
    model_options['encoder'] = 'lstm'
    model_options['xdim'] = model['lstm_W'].shape[0]
    model_options['dim_proj'] = model['U'].shape[0]/2
    model_options['ydim'] = model['U'].shape[1]
    model_options['use_dropout'] = False
    (use_noise, _, _, f_pred_prob, f_pred, _) = build_model(tparams, model_options)
    use_noise.set_value(0.)
    
    return f_pred_prob(X.astype(theano.config.floatX)), f_pred(X.astype(theano.config.floatX))
    
def train_lstm(
    dim_proj=None,
    xdim=None,
    ydim=None,
    patience=10,  # Number of epoch to wait before early stop if no progress
    max_epochs=500,  # The maximum number of epoch to run
    dispFreq=10,  # Display to stdout the training progress every N updates
    decay_c=0.,  # Weight decay for the classifier applied to the U weights.
    lrate=0.001,  # Learning rate for sgd (not used for adadelta and rmsprop)
    # n_words=10000,  # Vocabulary size
    optimizer=adadelta,  # sgd, adadelta and rmsprop available, sgd very hard to use, not recommanded (probably need momentum and decaying learning rate).
    encoder='lstm',  # TODO: can be removed must be lstm.
    dumppath='bctc_model.npz',  # The best model will be saved there
    validFreq=2000,  # Compute the validation error after this number of update.
    saveFreq=3000,  # Save the parameters after every saveFreq updates
    maxlen=None,  # Sequence longer then this get ignored
    batch_size=100,  # The batch size during training.
    valid_batch_size=100,  # The batch size used for validation/test set.
    dataset=None,

    # Parameter for extra option
    noise_std=0.,
    use_dropout=True,  # if False slightly faster, but worst test error
                       # This frequently need a bigger model.
    reload_model=None,  # Path to a saved model we want to start from.
    test_size=-1,  # If >0, we keep only this number of test example.
    scaling=1,
):

    # Model options
    model_options = locals().copy()
    print "model options", model_options
    
    print 'Loading data'
    # the dateset is organized as:
    # X - n_songs * n_timesteps * dim_proj (dim_proj = 24 for chromagram based dataset)
    # y - n_songs * n_timesteps * 1
    train, valid, test = load_data_song(dataset=dataset, valid_portion=0.1, test_portion=0.1)
                                   
    print 'data loaded'
    
    model_options['xdim'] = xdim
    model_options['dim_proj'] = dim_proj
    model_options['ydim'] = ydim
    
    print 'Building model'
    # This create the initial parameters as numpy ndarrays.
    # Dict name (string) -> numpy ndarray
    params = init_params(model_options)

    if reload_model:
        load_params('lstm_model.npz', params)

    # This create Theano Shared Variable from the parameters.
    # Dict name (string) -> Theano Tensor Shared Variable
    # params and tparams have different copy of the weights.
    tparams = init_tparams(params)

    # use_noise is for dropout
    # the model takes input of:
    # x -- n_timesteps * dim_proj * n_samples (in a simpler case, n_samples = 1 in ctc)
    # y -- n_timesteps * 1 * n_samples (in a simpler case, n_samples = 1 in ctc)
    (use_noise, x,
     y, f_pred_prob, f_pred, cost) = build_model(tparams, model_options)

    if decay_c > 0.:
        decay_c = theano.shared(numpy_floatX(decay_c), name='decay_c')
        weight_decay = 0.
        weight_decay += (tparams['U'] ** 2).sum()
        weight_decay *= decay_c
        cost += weight_decay

    f_cost = theano.function([x, y], cost, name='f_cost')

    grads = T.grad(cost, wrt=tparams.values())
    f_grad = theano.function([x, y], grads, name='f_grad')

    lr = T.scalar(name='lr')
    f_grad_shared, f_update = optimizer(lr, tparams, grads,
                                        x, y, cost)

    print 'Optimization'

    print "%d train examples" % len(train[0])
    print "%d valid examples" % len(valid[0])
    print "%d test examples" % len(test[0])

    history_errs = []
    best_p = None
    bad_count = 0

    uidx = 0  # the number of update done
    estop = False  # early stop
    start_time = time.time()
    try:
        for eidx in xrange(max_epochs):
            n_samples = 0

            # Get random sample a piece of length batch_size from a song
            idx0 = numpy.random.randint(0,len(train[0]))
            
            batch_size_ = batch_size
            while len(train[0][idx0]) <= batch_size_:
                batch_size_ = batch_size_ / 2
                
            idx1 = numpy.random.randint(0,len(train[0][idx0])-batch_size_) # 500 in our case
            
            uidx += 1
            use_noise.set_value(1.)
            
            # Select the random examples for this minibatch
            x = train[0][idx0][idx1:idx1+batch_size_]
            y = train[1][idx0][idx1:idx1+batch_size_]
            
            # Get the data in numpy.ndarray format
            # This swap the axis!
            # Return something of shape (minibatch maxlen, n samples)
            n_samples += 1

            cost = f_grad_shared(x, y)
            f_update(lrate)

            # if numpy.isnan(cost) or numpy.isinf(cost):
                # print 'NaN detected'
                # return 1., 1., 1.

            if numpy.mod(uidx, dispFreq) == 0:
                print 'Epoch ', eidx, 'Update ', uidx, 'Cost ', cost

            if dumppath and numpy.mod(uidx, saveFreq) == 0:
                print 'Saving...',
                
                # save the best param set to date (best_p)
                if best_p is not None:
                    params = best_p
                else:
                    params = unzip(tparams)
                numpy.savez(dumppath, history_errs=history_errs, **params)
                # pkl.dump(model_options, open('%s.pkl' % dumppath, 'wb'), -1)
                print 'Done'

            if numpy.mod(uidx, validFreq) == 0:
                use_noise.set_value(0.)
                # train_err = pred_error(f_pred, train)
                valid_err = pred_error(f_pred, valid)
                # test_err = pred_error(f_pred, test)

                # history_errs.append([valid_err, test_err])
                history_errs.append([valid_err, 1])
                
                # save param only if the validation error is less than the history minimum
                if (uidx == 0 or
                    valid_err <= numpy.array(history_errs)[:,
                                                           0].min()):

                    best_p = unzip(tparams)
                    bad_counter = 0

                # print ('Train ', train_err, 'Valid ', valid_err,
                       # 'Test ', test_err)
                print ('Valid', valid_err)
                
                # early stopping
                if (len(history_errs) > patience and
                    valid_err >= numpy.array(history_errs)[:-patience,
                                                           0].min()):
                    bad_counter += 1
                    if bad_counter > patience:
                        print 'Early Stop!'
                        estop = True
                        break

            # print 'Seen %d samples' % n_samples

            if estop:
                break

    except KeyboardInterrupt:
        print "Training interupted"

    end_time = time.time()
    if best_p is not None:
        zipp(best_p, tparams)
    else:
        best_p = unzip(tparams)

    use_noise.set_value(0.)
    train_err = pred_error(f_pred, train)
    valid_err = pred_error(f_pred, valid)
    test_err = pred_error(f_pred, test)

    print 'Train ', train_err, 'Valid ', valid_err, 'Test ', test_err
    if dumppath:
        numpy.savez(dumppath, train_err=train_err,
                    valid_err=valid_err, test_err=test_err,
                    history_errs=history_errs, **best_p)
    print 'The code run for %d epochs, with %f sec/epochs' % (
        (eidx + 1), (end_time - start_time) / (1. * (eidx + 1)))
    print >> sys.stderr, ('Training took %.1fs' %
                          (end_time - start_time))
    return train_err, valid_err, test_err


if __name__ == '__main__':
    dataset = sys.argv[1] #'../data/ch/Jsong-ch-noinv.pkl'
    dumppath = sys.argv[2] #'bctc.npz'
    xdim = int(sys.argv[3])#24
    ydim = int(sys.argv[4])#61 or 277
    dim_proj = int(sys.argv[5])#500
    
    train_lstm(
        dataset=dataset,
        xdim=xdim,
        ydim=ydim,
        dim_proj=dim_proj,
        dumppath=dumppath,
        max_epochs=max_epochs,
        use_dropout=use_dropout,
        batch_size=batch_size
    )
