import os
import sys
import timeit
import numpy
import theano
import theano.tensor as T
from theano.sandbox.rng_mrg import MRG_RandomStreams as RandomStreams
from loadmat import loadmat
from logistic import LogisticRegression

# start-snippet-1
class HiddenLayer(object):
    def __init__(self, rng, input, n_in, n_out, W=None, b=None,
                 activation=T.tanh):
        """
        Typical hidden layer of a MLP: units are fully-connected and have
        sigmoidal activation function. Weight matrix W is of shape (n_in,n_out)
        and the bias vector b is of shape (n_out,).

        NOTE : The nonlinearity used here is tanh

        Hidden unit activation is given by: tanh(dot(input,W) + b)

        :type rng: numpy.random.RandomState
        :param rng: a random number generator used to initialize weights

        :type input: theano.tensor.dmatrix
        :param input: a symbolic tensor of shape (n_examples, n_in)

        :type n_in: int
        :param n_in: dimensionality of input

        :type n_out: int
        :param n_out: number of hidden units

        :type activation: theano.Op or function
        :param activation: Non linearity to be applied in the hidden
                           layer
        """
        self.input = input
        # end-snippet-1

        # `W` is initialized with `W_values` which is uniformely sampled
        # from sqrt(-6./(n_in+n_hidden)) and sqrt(6./(n_in+n_hidden))
        # for tanh activation function
        # the output of uniform if converted using asarray to dtype
        # theano.config.floatX so that the code is runable on GPU
        # Note : optimal initialization of weights is dependent on the
        #        activation function used (among other things).
        #        For example, results presented in [Xavier10] suggest that you
        #        should use 4 times larger initial weights for sigmoid
        #        compared to tanh
        #        We have no info for other function, so we use the same as
        #        tanh.
        if W is None:
            W_values = numpy.asarray(
                rng.uniform(
                    low=-numpy.sqrt(6. / (n_in + n_out)),
                    high=numpy.sqrt(6. / (n_in + n_out)),
                    size=(n_in, n_out)
                ),
                dtype=theano.config.floatX
            )
            if activation == T.nnet.sigmoid:
                W_values *= 4

            W = theano.shared(value=W_values, name='W', borrow=True)

        if b is None:
            b_values = numpy.zeros((n_out,), dtype=theano.config.floatX)
            b = theano.shared(value=b_values, name='b', borrow=True)

        self.W = W
        self.b = b

        lin_output = T.dot(input, self.W) + self.b
        self.output = (
            lin_output if activation is None
            else activation(lin_output)
        )
        # parameters of the model
        self.params = [self.W, self.b]


# start-snippet-2
class MLP(object):
    """Multi-Layer Perceptron Class

    A multilayer perceptron is a feedforward artificial neural network model
    that has one layer or more of hidden units and nonlinear activations.
    Intermediate layers usually have as activation function tanh or the
    sigmoid function (defined here by a ``HiddenLayer`` class)  while the
    top layer is a softmax layer (defined here by a ``LogisticRegression``
    class).
    """

    def __init__(self, rng, input, n_in, hidden_layers_sizes, n_out, model=None):
        """Initialize the parameters for the multilayer perceptron

        :type rng: numpy.random.RandomState
        :param rng: a random number generator used to initialize weights

        :type input: theano.tensor.TensorType
        :param input: symbolic variable that describes the input of the
        architecture (one minibatch)

        :type n_in: int
        :param n_in: number of input units, the dimension of the space in
        which the datapoints lie

        :type hidden_layers_sizes: int list
        :param n_hidden: number of hidden units in each hidden layer

        :type n_out: int
        :param n_out: number of output units, the dimension of the space in
        which the labels lie

        """
        self.n_layers = len(hidden_layers_sizes)
        self.hiddenlayers = []
        self.params = []
        self.L1 = 0
        self.L2_sqr = 0
        # Since we are dealing with a one hidden layer MLP, this will translate
        # into a HiddenLayer with a tanh activation function connected to the
        # LogisticRegression layer; the activation function can be replaced by
        # sigmoid or any other nonlinear function
        for i in xrange(self.n_layers):
            if i == 0:
                input_size = n_in
            else:
                input_size = hidden_layers_sizes[i - 1]

            # the input to this layer is either the activation of the
            # hidden layer below or the input of the DBN if you are on
            # the first layer
            if i == 0:
                layer_input = input
            else:
                layer_input = self.hiddenlayers[i - 1].output
                
            if model is None:
                W = None
                b = None
            else:
                W = model[i*2]
                b = model[i*2 + 1]
            
            hiddenLayer = HiddenLayer(
                rng=rng,
                input=layer_input,
                n_in=input_size,
                n_out=hidden_layers_sizes[i],
                W = W,
                b = b,
                #activation=T.nnet.sigmoid
                activation=T.nnet.relu
            )
            self.hiddenlayers.append(hiddenLayer)
            self.params.extend(hiddenLayer.params)
            self.L1 += (abs(hiddenLayer.W).sum())
            self.L2_sqr += ((hiddenLayer.W ** 2).sum())

        # The logistic regression layer gets as input the hidden units
        # of the hidden layer
        if model is None:
            W = None
            b = None
        else:
            W = model[-2]
            b = model[-1]
        self.logRegressionLayer = LogisticRegression(
            input=self.hiddenlayers[-1].output,
            n_in=hidden_layers_sizes[-1],
            W = W,
            b = b,
            n_out=n_out
        )
        # end-snippet-2 start-snippet-3
        # L1 norm ; one regularization option is to enforce L1 norm to
        # be small

        self.L1 += (abs(self.logRegressionLayer.W).sum())

        self.L2_sqr += ((self.logRegressionLayer.W ** 2).sum())

        # negative log likelihood of the MLP is given by the negative
        # log likelihood of the output of the model, computed in the
        # logistic regression layer
        self.negative_log_likelihood = (
            self.logRegressionLayer.negative_log_likelihood
        )
        # same holds for the function computing the number of errors
        self.errors = self.logRegressionLayer.errors
        self.predprobs = self.logRegressionLayer.p_y_given_x
        self.preds = self.logRegressionLayer.y_pred

        # the parameters of the model are the parameters of the two layer it is
        # made out of
        self.params.extend(self.logRegressionLayer.params)
        # end-snippet-3

        # keep track of model input
        self.input = input

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
    
def predprobs(savez, X):
    model = savez['model']
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
    
    rng = numpy.random.RandomState(1234)
    n_in = W[0].shape[0]
    n_out = W[-1].shape[1]
    print n_in
    print n_out
    print hidden_layers_sizes
    x = T.matrix('x')
    mlp = MLP(
        rng=rng,
        input=x,
        n_in=n_in,
        model=model,
        hidden_layers_sizes=hidden_layers_sizes,
        n_out=n_out
    )
    
    predprobs_ = theano.function(inputs=[x], outputs=mlp.predprobs)
    preds_ = theano.function(inputs=[x], outputs=mlp.preds)
    return predprobs_(X.astype(theano.config.floatX)), preds_(X.astype(theano.config.floatX))
    
    
def test_mlp(learning_rate, L1_reg, L2_reg, n_epochs,
             hidden_layers_sizes, trainpath, trainlist, validset, batch_size, datasel,
             shuffle, scaling, dropout, earlystop, dumppath):
    """
    Demonstrate stochastic gradient descent optimization for a multilayer
    perceptron

    :type learning_rate: float
    :param learning_rate: learning rate used (factor for the stochastic
    gradient

    :type L1_reg: float
    :param L1_reg: L1-norm's weight when added to the cost (see
    regularization)

    :type L2_reg: float
    :param L2_reg: L2-norm's weight when added to the cost (see
    regularization)

    :type n_epochs: int
    :param n_epochs: maximal number of epochs to run the optimizer

    :type dataset: string
    :param dataset: the path of the dataset


   """
    print locals()
    
    datasets = loadmat(trainpath=trainpath,trainlist=trainlist,validset=validset,shuffle=shuffle,datasel=datasel,
                       scaling=scaling,robust=robust)

    train_set_x, train_set_y = datasets[0]
    valid_set_x, valid_set_y = datasets[1]

    # compute number of minibatches for training, validation and testing
    n_train_batches = train_set_x.get_value(borrow=True).shape[0] / batch_size
    n_valid_batches = valid_set_x.get_value(borrow=True).shape[0] / batch_size

    ######################
    # BUILD ACTUAL MODEL #
    ######################
    print '... building the model'

    # allocate symbolic variables for the data
    index = T.lscalar()  # index to a [mini]batch
    x = T.matrix('x')  # the data is presented as rasterized images
    y = T.ivector('y')  # the labels are presented as 1D vector of
                        # [int] labels

    rng = numpy.random.RandomState(1234)
    
    nclass = max(train_set_y.eval()) + 1
    print "n_in = %d"%train_set_x.get_value(borrow=True).shape[1]
    print "n_out = %d"%nclass

    # construct the MLP class
    classifier = MLP(
        rng=rng,
        input=x,
        n_in=train_set_x.get_value(borrow=True).shape[1],
        hidden_layers_sizes=hidden_layers_sizes,
        n_out=nclass
    )
    
    # dropout the hidden layers
    trng = RandomStreams(1234)
    use_noise = theano.shared(numpy.asarray(0., dtype=theano.config.floatX))
    if dropout:
        # classifier.input = dropout_layer(use_noise, classifier.input, trng, 0.8)
        for i in range(classifier.n_layers):
            classifier.hiddenlayers[i].output = dropout_layer(use_noise, classifier.hiddenlayers[i].output, trng, 0.5)
            
    # start-snippet-4
    # the cost we minimize during training is the negative log likelihood of
    # the model plus the regularization terms (L1 and L2); cost is expressed
    # here symbolically
    cost = (
        classifier.negative_log_likelihood(y)
        + L1_reg * classifier.L1
        + L2_reg * classifier.L2_sqr
    )
    # end-snippet-4

    validate_model = theano.function(
        inputs=[index],
        outputs=classifier.errors(y),
        givens={
            x: valid_set_x[index * batch_size:(index + 1) * batch_size],
            y: valid_set_y[index * batch_size:(index + 1) * batch_size]
        }
    )
    
    train_score = theano.function(
        inputs=[index],
        outputs=classifier.errors(y),
        givens={
            x: train_set_x[index * batch_size:(index + 1) * batch_size],
            y: train_set_y[index * batch_size:(index + 1) * batch_size]
        }
    )
    
    pred_probs = theano.function(
        inputs=[index],
        outputs=classifier.predprobs,
        givens={
            x: train_set_x[index:1000],
            # y: train_set_y[index * batch_size:(index + 1) * batch_size]
        }
    )

    # start-snippet-5
    # compute the gradient of cost with respect to theta (sotred in params)
    # the resulting gradients will be stored in a list gparams
    gparams = [T.grad(cost, param) for param in classifier.params]

    # specify how to update the parameters of the model as a list of
    # (variable, update expression) pairs

    # given two lists of the same length, A = [a1, a2, a3, a4] and
    # B = [b1, b2, b3, b4], zip generates a list C of same size, where each
    # element is a pair formed from the two lists :
    #    C = [(a1, b1), (a2, b2), (a3, b3), (a4, b4)]
    updates = [
        (param, param - learning_rate * gparam)
        for param, gparam in zip(classifier.params, gparams)
    ]

    # compiling a Theano function `train_model` that returns the cost, but
    # in the same time updates the parameter of the model based on the rules
    # defined in `updates`
    train_model = theano.function(
        inputs=[index],
        outputs=cost,
        updates=updates,
        givens={
            x: train_set_x[index * batch_size: (index + 1) * batch_size],
            y: train_set_y[index * batch_size: (index + 1) * batch_size]
        }
    )
    # end-snippet-5

    ###############
    # TRAIN MODEL #
    ###############
    print '... training'

    # early-stopping parameters
    patience = 10 * n_train_batches  # look as this many examples regardless
    patience_increase = 2  # wait this much longer when a new best is
                           # found
    improvement_threshold = 0.996   # a relative improvement of this much is
                                   # considered significant
    validation_frequency = min(n_train_batches, patience / 2)
                                  # go through this many
                                  # minibatche before checking the network
                                  # on the validation set; in this case we
                                  # check every epoch

    best_validation_loss = numpy.inf
    best_iter = 0
    training_history=[]
    start_time = timeit.default_timer()

    epoch = 0
    done_looping = False

    while (epoch < n_epochs):
        if earlystop and done_looping:
            print 'early-stopping'
            break
        epoch = epoch + 1
        for minibatch_index in xrange(n_train_batches):
            use_noise.set_value(1.) # use dropout
            minibatch_avg_cost = train_model(minibatch_index)
            # iteration number
            iter = (epoch - 1) * n_train_batches + minibatch_index

            if (iter + 1) % validation_frequency == 0:
                # compute zero-one loss on validation set
                use_noise.set_value(0.) # at validation/testing time, no dropout
                validation_losses = [validate_model(i) for i in xrange(n_valid_batches)]
                #training_losses = [train_score(i) for i in xrange(n_train_batches)]
                this_validation_loss = numpy.mean(validation_losses)
                #this_training_loss = numpy.mean(training_losses)
                #training_history.append([iter,this_training_loss,this_validation_loss])
                training_history.append([iter,this_validation_loss])
                
#                print('epoch %i, minibatch %i/%i, training error %f %%' %
#                      (epoch, minibatch_index + 1, n_train_batches,
#                       this_training_loss * 100.))
                print('epoch %i, minibatch %i/%i, validation error %f %%' %
                      (epoch, minibatch_index + 1, n_train_batches,
                       this_validation_loss * 100.))
                print('iter = %d' % iter)
                print('patience = %d' % patience)

                # if we got the best validation score until now
                if this_validation_loss < best_validation_loss:
                    #improve patience if loss improvement is good enough
                    if (
                        this_validation_loss < best_validation_loss *
                        improvement_threshold
                    ):
                        patience = max(patience, iter * patience_increase)
                        
                    numpy.savez(dumppath, model=classifier.params, training_history=training_history,
                                best_validation_loss=best_validation_loss)
                        
                    best_validation_loss = this_validation_loss
                    best_iter = iter
                    print('best_validation_loss %f' % best_validation_loss)

            if patience <= iter:
                done_looping = True
                if earlystop:
                    break

    end_time = timeit.default_timer()
    
    # final save
    numpy.savez(dumppath, model=classifier.params, training_history=training_history,
                                best_validation_loss=best_validation_loss)
    
    print(('Optimization complete. Best validation score of %f %% '
           'obtained at iteration %i') %
          (best_validation_loss * 100., best_iter + 1))
    print >> sys.stderr, ('The code for file ' +
                          os.path.split(__file__)[1] +
                          ' ran for %.2fm' % ((end_time - start_time) / 60.))


if __name__ == '__main__':
    trainpath = sys.argv[1] #'../data/cv/'
    trainlist = sys.argv[2] #'JK-ch-1234' hold one out
    validset = sys.argv[3] #'../data/cv/C-ch.mat'
    hidden_layers_sizes_ = sys.argv[4].split(',') #[800,800]
    hidden_layers_sizes = []
    for hls in range(len(hidden_layers_sizes_)):
        hidden_layers_sizes.append(int(hidden_layers_sizes_[hls]))
        
    # build dumppath
    nntoks = sys.argv[0].split('.')
    nn = nntoks[0]
    dumppath = '../model/' + nn + '-' + trainlist + '-' + sys.argv[4] + '.npz'
        
    scaling = 1
    shuffle = 0 # do NOT shuffle
    datasel = 1 # select all data
    robust = 0
    
    batch_size = 100
    n_epochs=300
    learning_rate=0.01
    L1_reg=0.0000
    L2_reg=0.0000
    earlystop = True
    dropout = True
    
    test_mlp(learning_rate, L1_reg, L2_reg, n_epochs,
             hidden_layers_sizes, trainpath, trainlist, validset,
             batch_size, datasel, shuffle, scaling, dropout, earlystop, dumppath)
