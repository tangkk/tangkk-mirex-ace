import os
import sys
import timeit
import cPickle
import numpy
import theano
import theano.tensor as T
from theano.sandbox.rng_mrg import MRG_RandomStreams
from loadmat import loadmat
from logistic import LogisticRegression
from mlp import HiddenLayer
from rbm import RBM
from grbm import GRBM
from utils import tile_raster_images
import sys


shuffle = 1
scaling = 1
datasel = 1
robust = 0

batch_size = 100
pretraining_epochs=100
pretrain_lr=0.001
cdk=20
usepersistent=False

training_epochs=500
finetune_lr=0.01
L1_reg=0.0000
L2_reg=0.0000
earlystop=True
dropout=True
pretrain_dropout=False

output_folder = 'dbn_train_plots'

# start-snippet-1
class DBN(object):
    """Deep Belief Network

    A deep belief network is obtained by stacking several RBMs on top of each
    other. The hidden layer of the RBM at layer `i` becomes the input of the
    RBM at layer `i+1`. The first layer RBM gets as input the input of the
    network, and the hidden layer of the last RBM represents the output. When
    used for classification, the DBN is treated as a MLP, by adding a logistic
    regression layer on top.
    """

    def __init__(self, numpy_rng, theano_rng=None, n_ins=784,
                 hidden_layers_sizes=[500, 500], n_outs=10, L1_reg=0, L2_reg=0, first_layer='grbm',model=None):
        """This class is made to support a variable number of layers.

        :type numpy_rng: numpy.random.RandomState
        :param numpy_rng: numpy random number generator used to draw initial
                    weights

        :type theano_rng: theano.tensor.shared_randomstreams.RandomStreams
        :param theano_rng: Theano random generator; if None is given one is
                           generated based on a seed drawn from `rng`

        :type n_ins: int
        :param n_ins: dimension of the input to the DBN

        :type hidden_layers_sizes: list of ints
        :param hidden_layers_sizes: intermediate layers size, must contain
                               at least one value

        :type n_outs: int
        :param n_outs: dimension of the output of the network
        """

        self.sigmoid_layers = []
        self.rbm_layers = []
        self.params = []
        self.n_layers = len(hidden_layers_sizes)
        self.L1 = 0
        self.L2_sqr = 0

        assert self.n_layers > 0

        if not theano_rng:
            theano_rng = MRG_RandomStreams(numpy_rng.randint(2 ** 30))

        # allocate symbolic variables for the data
        self.x = T.matrix('x')  # the data is presented as rasterized images
        self.y = T.ivector('y')  # the labels are presented as 1D vector
                                 # of [int] labels
        # end-snippet-1
        # The DBN is an MLP, for which all weights of intermediate
        # layers are shared with a different RBM.  We will first
        # construct the DBN as a deep multilayer perceptron, and when
        # constructing each sigmoidal layer we also construct an RBM
        # that shares weights with that layer. During pretraining we
        # will train these RBMs (which will lead to chainging the
        # weights of the MLP as well) During finetuning we will finish
        # training the DBN by doing stochastic gradient descent on the
        # MLP.

        for i in xrange(self.n_layers):
            # construct the sigmoidal layer

            # the size of the input is either the number of hidden
            # units of the layer below or the input size if we are on
            # the first layer
            if i == 0:
                input_size = n_ins
            else:
                input_size = hidden_layers_sizes[i - 1]

            # the input to this layer is either the activation of the
            # hidden layer below or the input of the DBN if you are on
            # the first layer
            if i == 0:
                layer_input = self.x
            else:
                layer_input = self.sigmoid_layers[i - 1].output
            
            if model is None:
                W = None
                b = None
            else:
                W = model[i*2]
                b = model[i*2 + 1]
                
            sigmoid_layer = HiddenLayer(rng=numpy_rng,
                                        input=layer_input,
                                        n_in=input_size,
                                        n_out=hidden_layers_sizes[i],
                                        W = W,
                                        b = b,
                                        activation=T.nnet.sigmoid)

            # add the layer to our list of layers
            self.sigmoid_layers.append(sigmoid_layer)
            self.L1 += (abs(sigmoid_layer.W).sum())
            self.L2_sqr += ((sigmoid_layer.W ** 2).sum())

            # its arguably a philosophical question...  but we are
            # going to only declare that the parameters of the
            # sigmoid_layers are parameters of the DBN. The visible
            # biases in the RBM are parameters of those RBMs, but not
            # of the DBN.
            self.params.extend(sigmoid_layer.params)

            # Construct an RBM that shared weights with this layer
            if i == 0: # first layer GBRBM - dealing with continous value
                if first_layer == 'grbm':
                    rbm_layer = GRBM(numpy_rng=numpy_rng,
                                    theano_rng=theano_rng,
                                    input=layer_input,
                                    n_visible=input_size,
                                    n_hidden=hidden_layers_sizes[i],
                                    W=sigmoid_layer.W,
                                    hbias=sigmoid_layer.b)
                if first_layer == 'rbm':
                    rbm_layer = RBM(numpy_rng=numpy_rng,
                                    theano_rng=theano_rng,
                                    input=layer_input,
                                    n_visible=input_size,
                                    n_hidden=hidden_layers_sizes[i],
                                    W=sigmoid_layer.W,
                                    hbias=sigmoid_layer.b)
            # elif i == self.n_layers-1: # last layer GGRBM
                # rbm_layer = GRBM(numpy_rng=numpy_rng,
                                # theano_rng=theano_rng,
                                # input=layer_input,
                                # n_visible=input_size,
                                # n_hidden=hidden_layers_sizes[i],
                                # W=sigmoid_layer.W,
                                # hbias=sigmoid_layer.b)
            else: # subsequence layers BBRBM - binary RBM to cope with regularization
                rbm_layer = RBM(numpy_rng=numpy_rng,
                            theano_rng=theano_rng,
                            input=layer_input,
                            n_visible=input_size,
                            n_hidden=hidden_layers_sizes[i],
                            W=sigmoid_layer.W,
                            hbias=sigmoid_layer.b)
            self.rbm_layers.append(rbm_layer)

        # We now need to add a logistic layer on top of the MLP
        if model is None:
            W = None
            b = None
        else:
            W = model[-2]
            b = model[-1]
        self.logLayer = LogisticRegression(
            input=self.sigmoid_layers[-1].output,
            n_in=hidden_layers_sizes[-1],
            W = W,
            b = b,
            n_out=n_outs)
        self.params.extend(self.logLayer.params)
        
        self.L1 += (abs(self.logLayer.W).sum())

        self.L2_sqr += ((self.logLayer.W ** 2).sum())

        # compute the cost for second phase of training, defined as the
        # negative log likelihood of the logistic regression (output) layer
        self.finetune_cost = (self.logLayer.negative_log_likelihood(self.y) +
            + L1_reg * self.L1
            + L2_reg * self.L2_sqr
        )
            

        # compute the gradients with respect to the model parameters
        # symbolic variable that points to the number of errors made on the
        # minibatch given by self.x and self.y
        self.errors = self.logLayer.errors(self.y)
        self.predprobs = self.logLayer.p_y_given_x
        self.preds = self.logLayer.y_pred

    def pretraining_functions(self, train_set_x, batch_size, cdk, usepersistent):
        '''Generates a list of functions, for performing one step of
        gradient descent at a given layer. The function will require
        as input the minibatch index, and to train an RBM you just
        need to iterate, calling the corresponding function on all
        minibatch indexes.

        :type train_set_x: theano.tensor.TensorType
        :param train_set_x: Shared var. that contains all datapoints used
                            for training the RBM
        :type batch_size: int
        :param batch_size: size of a [mini]batch
        :param cdk: number of Gibbs steps to do in CD-k / PCD-k

        '''

        # index to a [mini]batch
        index = T.lscalar('index')  # index to a minibatch
        learning_rate = T.scalar('lr')  # learning rate to use

        # number of batches
        n_batches = train_set_x.get_value(borrow=True).shape[0] / batch_size
        # begining of a batch, given `index`
        batch_begin = index * batch_size
        # ending of a batch given `index`
        batch_end = batch_begin + batch_size

        pretrain_fns = []
        for rbm in self.rbm_layers:
            # get the cost and the updates list
            # using CD-k here (persisent=None) for training each RBM.
            # TODO: change cost function to reconstruction error
            if usepersistent:
                # init persisent chain
                persistent_chain = theano.shared(numpy.zeros((batch_size, rbm.n_hidden),
                                                     dtype=theano.config.floatX),
                                         borrow=True)
                cost, updates = rbm.get_cost_updates(learning_rate,
                             persistent=persistent_chain, k=cdk)
            else:
                cost, updates = rbm.get_cost_updates(learning_rate,
                                                     persistent=None, k=cdk)


            # compile the theano function
            fn = theano.function(
                inputs=[index, theano.Param(learning_rate, default=0.1)],
                outputs=cost,
                updates=updates,
                givens={
                    self.x: train_set_x[batch_begin:batch_end]
                }
            )
            # append `fn` to the list of functions
            pretrain_fns.append(fn)

        return pretrain_fns

    def build_finetune_functions(self, datasets, batch_size, learning_rate):
        '''Generates a function `train` that implements one step of
        finetuning, a function `validate` that computes the error on a
        batch from the validation set, and a function `test` that
        computes the error on a batch from the testing set

        :type datasets: list of pairs of theano.tensor.TensorType
        :param datasets: It is a list that contain all the datasets;
                        the has to contain three pairs, `train`,
                        `valid`, `test` in this order, where each pair
                        is formed of two Theano variables, one for the
                        datapoints, the other for the labels
        :type batch_size: int
        :param batch_size: size of a minibatch
        :type learning_rate: float
        :param learning_rate: learning rate used during finetune stage

        '''

        (train_set_x, train_set_y) = datasets[0]
        (valid_set_x, valid_set_y) = datasets[1]
        (test_set_x, test_set_y) = datasets[2]

        # compute number of minibatches for training, validation and testing
        n_train_batches = train_set_x.get_value(borrow=True).shape[0]
        n_train_batches /= batch_size
        n_valid_batches = valid_set_x.get_value(borrow=True).shape[0]
        n_valid_batches /= batch_size
        n_test_batches = test_set_x.get_value(borrow=True).shape[0]
        n_test_batches /= batch_size

        index = T.lscalar('index')  # index to a [mini]batch

        # compute the gradients with respect to the model parameters
        #gparams = T.grad(self.finetune_cost, self.params)
        gparams = [T.grad(self.finetune_cost, param) for param in self.params]

        # compute list of fine-tuning updates
        #updates = []
        #for param, gparam in zip(self.params, gparams):
        #    updates.append((param, param - gparam * learning_rate))
        updates = [
            (param, param - learning_rate * gparam)
            for param, gparam in zip(self.params, gparams)
        ]

        train_fn = theano.function(
            inputs=[index],
            outputs=self.finetune_cost,
            updates=updates,
            givens={
                self.x: train_set_x[
                    index * batch_size: (index + 1) * batch_size
                ],
                self.y: train_set_y[
                    index * batch_size: (index + 1) * batch_size
                ]
            }
        )
        
        train_score_i = theano.function(
            [index],
            self.errors,
            givens={
                self.x: train_set_x[
                    index * batch_size: (index + 1) * batch_size
                ],
                self.y: train_set_y[
                    index * batch_size: (index + 1) * batch_size
                ]
            }
        )

        test_score_i = theano.function(
            [index],
            self.errors,
            givens={
                self.x: test_set_x[
                    index * batch_size: (index + 1) * batch_size
                ],
                self.y: test_set_y[
                    index * batch_size: (index + 1) * batch_size
                ]
            }
        )

        valid_score_i = theano.function(
            [index],
            self.errors,
            givens={
                self.x: valid_set_x[
                    index * batch_size: (index + 1) * batch_size
                ],
                self.y: valid_set_y[
                    index * batch_size: (index + 1) * batch_size
                ]
            }
        )
        
        # Create a function that scans the entire test set
        def train_score():
            return [train_score_i(i) for i in xrange(n_train_batches)]

        # Create a function that scans the entire validation set
        def valid_score():
            return [valid_score_i(i) for i in xrange(n_valid_batches)]

        # Create a function that scans the entire test set
        def test_score():
            return [test_score_i(i) for i in xrange(n_test_batches)]

        return train_fn, train_score, valid_score, test_score

def dropout_layer(state_before, use_noise, trng, p):
    # at training time, use_noise is set to 1,
    # dropout is applied to layer, each unit of layer is presented at a chance of p
    # at test/validation time, use_noise is set to 0,
    # each unit of layer is always presented, and their activations are multiplied by p
    # by default p=0.5 (can be changed)
    # and different p can be applied to different layers, even the input layer
    layer = T.switch(use_noise,
                         (state_before *
                          trng.binomial(state_before.shape,
                                        p=p, n=1,
                                        dtype=state_before.dtype)),
                         state_before * p)
    return layer

    
def predprobs(model, X):
    W = []
    b = []
    hidden_layers_sizes = []
    # W and b stores the weights and bias of different hidden layers
    # the last element of them stores those of the logistic regression layers
    for i in range(len(model)):
        if i % 2 == 0:
            Wi = model[i].get_value()
            W.append(Wi)
        if i % 2 == 1:
            bi = model[i].get_value()
            b.append(bi)
            if i != len(model)-1:
                hidden_layers_sizes.append(bi.shape[0])       
                
    numpy_rng = numpy.random.RandomState(123)
    n_in = W[0].shape[0]
    n_out = W[-1].shape[1]
    print n_in
    print n_out
    print hidden_layers_sizes
    dbn = DBN(numpy_rng=numpy_rng, n_ins=n_in,
              hidden_layers_sizes=hidden_layers_sizes,
              n_outs=n_out,model=model)
    predprobs_ = theano.function(inputs=[dbn.x], outputs=dbn.predprobs, name='predprobs_')
    preds_ = theano.function(inputs=[dbn.x], outputs=dbn.preds)
    return predprobs_(X.astype(theano.config.floatX)), preds_(X.astype(theano.config.floatX))
    
def test_DBN(finetune_lr, pretraining_epochs,
             pretrain_lr, cdk, usepersistent, training_epochs,
             L1_reg, L2_reg,
             hidden_layers_sizes,
             dataset, batch_size, output_folder, shuffle, scaling, dropout, first_layer, dumppath):
    """
    Demonstrates how to train and test a Deep Belief Network.

    :type finetune_lr: float
    :param finetune_lr: learning rate used in the finetune stage
    :type pretraining_epochs: int
    :param pretraining_epochs: number of epoch to do pretraining
    :type pretrain_lr: float
    :param pretrain_lr: learning rate to be used during pre-training
    :type cdk: int
    :param cdk: number of Gibbs steps in CD/PCD
    :type training_epochs: int
    :param training_epochs: maximal number of iterations ot run the optimizer
    :type dataset: string
    :param dataset: path the the pickled dataset
    :type batch_size: int
    :param batch_size: the size of a minibatch
    """
    print locals()
    
    datasets = loadmat(dataset=dataset, shuffle=shuffle, datasel=datasel, scaling=scaling, robust=robust)
    train_set_x, train_set_y = datasets[0]
    valid_set_x, valid_set_y = datasets[1]
    test_set_x, test_set_y = datasets[2]

    # compute number of minibatches for training, validation and testing
    n_train_batches = train_set_x.get_value(borrow=True).shape[0] / batch_size
    
    print "%d training examples" % train_set_x.get_value(borrow=True).shape[0]
    print "%d feature dimensions" % train_set_x.get_value(borrow=True).shape[1]

    # numpy random generator
    numpy_rng = numpy.random.RandomState(123)
    print '... building the model'
    # construct the Deep Belief Network
    nclass = max(train_set_y.eval())+1
    dbn = DBN(numpy_rng=numpy_rng, n_ins=train_set_x.get_value(borrow=True).shape[1],
              hidden_layers_sizes=hidden_layers_sizes,
              n_outs=nclass, L1_reg=L1_reg, L2_reg=L2_reg, first_layer=first_layer)
    print 'n_ins:%d'% train_set_x.get_value(borrow=True).shape[1]
    print 'n_outs:%d'% nclass
    
    # getting pre-training and fine-tuning functions
    # save images of the weights(receptive fields) in this output folder
    # if not os.path.isdir(output_folder):
        # os.makedirs(output_folder)
    # os.chdir(output_folder)
    
    print '... getting the pretraining functions'
    pretraining_fns = dbn.pretraining_functions(train_set_x=train_set_x,
                                                batch_size=batch_size,
                                                cdk=cdk, usepersistent=usepersistent)
    # get the training, validation and testing function for the model
    print '... getting the finetuning functions'

    train_fn, train_model, validate_model, test_model = dbn.build_finetune_functions(
        datasets=datasets,
        batch_size=batch_size,
        learning_rate=finetune_lr
    )
    
    trng = MRG_RandomStreams(1234)
    use_noise = theano.shared(numpy.asarray(0., dtype=theano.config.floatX))
    if dropout:
        # dbn.x = dropout_layer(use_noise, dbn.x, trng, 0.8)
        for i in range(dbn.n_layers):
            dbn.sigmoid_layers[i].output = dropout_layer(use_noise, dbn.sigmoid_layers[i].output, trng, 0.5)

    # start-snippet-2
    #########################
    # PRETRAINING THE MODEL #
    #########################

    print '... pre-training the model'
    plotting_time = 0.
    start_time = timeit.default_timer()
    ## Pre-train layer-wise
    for i in xrange(dbn.n_layers):
        # go through pretraining epochs
        for epoch in xrange(pretraining_epochs):
            if pretrain_dropout:
                use_noise.set_value(1.) # use dropout at pre-training
            # go through the training set
            c = []
            for batch_index in xrange(n_train_batches):
                c.append(pretraining_fns[i](index=batch_index,
                                            lr=pretrain_lr))
            print 'Pre-training layer %i, epoch %d, cost ' % (i, epoch),
            print numpy.mean(c)
            
            '''
            for j in range(dbn.n_layers):
                if j == 0:
                    # Plot filters after each training epoch
                    plotting_start = timeit.default_timer()
                    # Construct image from the weight matrix
                    this_layer = dbn.rbm_layers[j]
                    this_field = this_layer.W.get_value(borrow=True).T
                    print "field shape (%d,%d)"%this_field.shape
                    image = Image.fromarray(
                        tile_raster_images(
                            X=this_field[0:100], # take only the first 100 fields (100 * n_visible)
                            #the img_shape and tile_shape depends on n_visible and n_hidden of this_layer
                            # if n_visible = 144 (12,12), if n_visible = 1512 (36,42)
                            img_shape=(12, 12),
                            tile_shape=(10, 10),
                            tile_spacing=(1, 1)
                        )
                    )
                    image.save('filters_at_epoch_%i.png' % epoch)
                    plotting_stop = timeit.default_timer()
                    plotting_time += (plotting_stop - plotting_start)
            '''

    end_time = timeit.default_timer()
    # end-snippet-2
    print >> sys.stderr, ('The pretraining code for file ' +
                          os.path.split(__file__)[1] +
                          ' ran for %.2fm' % ((end_time - start_time) / 60.))
    ########################
    # FINETUNING THE MODEL #
    ########################

    print '... finetuning the model'
    # early-stopping parameters
    patience = 10 * n_train_batches  # look as this many examples regardless
    patience_increase = 2.    # wait this much longer when a new best is
                              # found
    improvement_threshold = 0.999  # a relative improvement of this much is
                                   # considered significant
    validation_frequency = min(n_train_batches, patience / 2)
                                  # go through this many
                                  # minibatches before checking the network
                                  # on the validation set; in this case we
                                  # check every epoch

    best_validation_loss = numpy.inf
    test_score = 0.
    start_time = timeit.default_timer()

    done_looping = False
    epoch = 0

    # while (epoch < training_epochs) and (not done_looping):
    while (epoch < training_epochs):
        if earlystop and done_looping:
            print 'early-stopping'
            break
        epoch = epoch + 1
        for minibatch_index in xrange(n_train_batches):
            use_noise.set_value(1.) # use dropout at training time
            minibatch_avg_cost = train_fn(minibatch_index)
            iter = (epoch - 1) * n_train_batches + minibatch_index

            if (iter + 1) % validation_frequency == 0:
                use_noise.set_value(0.) # stop dropout at validation/test time
                validation_losses = validate_model()
                training_losses = train_model()
                this_validation_loss = numpy.mean(validation_losses)
                this_training_loss = numpy.mean(training_losses)
                
                # also monitor the training losses
                print(
                    'epoch %i, minibatch %i/%i, training error %f %%'
                    % (
                        epoch,
                        minibatch_index + 1,
                        n_train_batches,
                        this_training_loss * 100.
                    )
                )
                
                print(
                    'epoch %i, minibatch %i/%i, validation error %f %%'
                    % (
                        epoch,
                        minibatch_index + 1,
                        n_train_batches,
                        this_validation_loss * 100.
                    )
                )

                # if we got the best validation score until now
                if this_validation_loss < best_validation_loss:

                    #improve patience if loss improvement is good enough
                    if (
                        this_validation_loss < best_validation_loss *
                        improvement_threshold
                    ):
                        patience = max(patience, iter * patience_increase)
                        
                    with open(dumppath, "wb") as f:
                        cPickle.dump(dbn.params, f)

                    # save best validation score and iteration number
                    best_validation_loss = this_validation_loss
                    best_iter = iter
                    
                    '''
                    # test it on the test set
                    test_losses = test_model()
                    test_score = numpy.mean(test_losses)
                    print(('     epoch %i, minibatch %i/%i, test error of '
                           'best model %f %%') %
                          (epoch, minibatch_index + 1, n_train_batches,
                           test_score * 100.))
                    '''

            if patience <= iter:
                done_looping = True
                if earlystop:
                    break

    end_time = timeit.default_timer()
    print(
        (
            'Optimization complete with best validation score of %f %%, '
            'obtained at iteration %i, '
            'with test performance %f %%'
        ) % (best_validation_loss * 100., best_iter + 1, test_score * 100.)
    )
    print >> sys.stderr, ('The fine tuning code for file ' +
                          os.path.split(__file__)[1] +
                          ' ran for %.2fm' % ((end_time - start_time)
                                              / 60.))
    

if __name__ == '__main__':
    dataset = sys.argv[1] #'../data/ch/B6seg-ch-noinv.mat'
    dumppath = sys.argv[2] #'../data/ch/dbn.pkl'
    hidden_layers_sizes_ = sys.argv[3].split(',') #[1000]
    hidden_layers_sizes = []
    for hls in range(len(hidden_layers_sizes_)):
        hidden_layers_sizes.append(int(hidden_layers_sizes_[hls]))
    first_layer = sys.argv[4] #'rbm'
    test_DBN(finetune_lr, pretraining_epochs,
             pretrain_lr, cdk, usepersistent, training_epochs,
             L1_reg, L2_reg,
             hidden_layers_sizes,
             dataset, batch_size, output_folder, shuffle, scaling, dropout, first_layer, dumppath)
