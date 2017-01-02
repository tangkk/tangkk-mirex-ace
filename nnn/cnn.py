import os
import sys
import timeit

import numpy

import theano
import theano.tensor as T
from theano.tensor.signal import pool
#from theano.tensor.nnet import conv2d

from logistic import LogisticRegression
from loadmat import loadmat
from mlp import HiddenLayer


class ConvPoolLayer(object):
    """Pool Layer of a convolutional network """

    def __init__(self, rng, input, filter_shape, input_shape, poolsize=(2, 2)):
        """
        Allocate a ConvPoolLayer with shared variable internal parameters.

        :type rng: numpy.random.RandomState
        :param rng: a random number generator used to initialize weights

        :type input: theano.tensor.dtensor4
        :param input: symbolic image tensor, of shape input_shape

        :type filter_shape: tuple or list of length 4
        :param filter_shape: (number of filters, num input feature maps,
                              filter height, filter width)

        :type input_shape: tuple or list of length 4
        :param input_shape: (batch size, num input feature maps,
                             image height, image width)

        :type poolsize: tuple or list of length 2
        :param poolsize: the downsampling (pooling) factor (#rows, #cols)
        """

        assert input_shape[1] == filter_shape[1]
        self.input = input

        # there are "num input feature maps * filter height * filter width"
        # inputs to each hidden unit
        fan_in = numpy.prod(filter_shape[1:])
        # each unit in the lower layer receives a gradient from:
        # "num output feature maps * filter height * filter width" /
        #   pooling size
        fan_out = (filter_shape[0] * numpy.prod(filter_shape[2:]) /
                   numpy.prod(poolsize))
        # initialize weights with random weights
        W_bound = numpy.sqrt(6. / (fan_in + fan_out))
        self.W = theano.shared(
            numpy.asarray(
                rng.uniform(low=-W_bound, high=W_bound, size=filter_shape),
                dtype=theano.config.floatX
            ),
            borrow=True
        )

        # the bias is a 1D tensor -- one bias per output feature map
        b_values = numpy.zeros((filter_shape[0],), dtype=theano.config.floatX)
        self.b = theano.shared(value=b_values, borrow=True)

        # convolve input feature maps with filters
        conv_out = T.nnet.conv2d(
            input=input,
            filters=self.W,
            filter_shape=filter_shape,
            input_shape=input_shape
        )

        # downsample each feature map individually, using maxpooling
        pooled_out = pool.pool_2d(
            input=conv_out,
            ds=poolsize,
            ignore_border=True
        )

        # add the bias term. Since the bias is a vector (1D array), we first
        # reshape it to a tensor of shape (1, n_filters, 1, 1). Each bias will
        # thus be broadcasted across mini-batches and feature map
        # width & height
        self.output = T.tanh(pooled_out + self.b.dimshuffle('x', 0, 'x', 'x'))

        # store parameters of this layer
        self.params = [self.W, self.b]

        # keep track of model input
        self.input = input


def test_cnn(trainpath,trainlist,validset,dumppath,learning_rate=0.01, n_epochs=200,batch_size=100, earlystop=True):
    """

    :type learning_rate: float
    :param learning_rate: learning rate used (factor for the stochastic
                          gradient)

    :type n_epochs: int
    :param n_epochs: maximal number of epochs to run the optimizer

    :type dataset: string
    :param dataset: path to the dataset used for training /testing (MNIST here)

    :type nkerns: list of ints
    :param nkerns: number of kernels on each layer
    """

    rng = numpy.random.RandomState(123)

    # datasets = load_data(dataset)
    datasets = loadmat(trainpath=trainpath,trainlist=trainlist,validset=validset,shuffle=shuffle,datasel=datasel,
                       scaling=scaling,robust=robust)

    train_set_x, train_set_y = datasets[0]
    valid_set_x, valid_set_y = datasets[1]

    # compute number of minibatches for training, validation and testing
    n_train_batches = train_set_x.get_value(borrow=True).shape[0]
    n_valid_batches = valid_set_x.get_value(borrow=True).shape[0]

    n_train_batches /= batch_size
    n_valid_batches /= batch_size

    # allocate symbolic variables for the data
    index = T.lscalar()  # index to a [mini]batch

    # start-snippet-1
    x = T.matrix('x')   # the data is presented as rasterized images
    y = T.ivector('y')  # the labels are presented as 1D vector of
                        # [int] labels

    ######################
    # BUILD ACTUAL MODEL #
    ######################
    print '... building the model'
    
    # H - height; W - width
    # when the input is note salience matrix
    # idim0_H = 42
    # idim0_W = 36
    # fdim0_H = 6
    # fdim0_W = 6
    
    # when the input is chromagram
    idim0_H = 12
    idim0_W = 12
    
    fdim0_H = 2
    fdim0_W = 2
    pdim0_H = 2
    pdim0_W = 2
    
    idim1_H = (idim0_H - fdim0_H + 1) / pdim0_H
    idim1_W = (idim0_W - fdim0_W + 1) / pdim0_W
    
    fdim1_H = 2
    fdim1_W = 2
    pdim1_H = 2
    pdim1_W = 2
    
    idim2_H = (idim1_H - fdim1_H + 1) / pdim1_H
    idim2_W = (idim1_W - fdim1_W + 1) / pdim1_W
    
    fdim2 = 800
    
    nkerns = [20,20]
    
    # the below comments are examples of using this cnn to deal with chromagram with input feature size 144 = 12*12
    # Reshape matrix of rasterized images of shape (batch_size, 12 * 12)
    # to a 4D tensor, compatible with our ConvPoolLayer
    # (12, 12) is the size of MNIST images.
    layer0_input = x.reshape((batch_size, 1, idim0_H, idim0_W))

    # Construct the first convolutional pooling layer:
    # filtering reduces the image size to (12-2+1 , 12-2+1) = (11, 11)
    # maxpooling reduces this further to (11/2, 11/2) = (5, 5)
    # 4D output tensor is thus of shape (batch_size, nkerns[0], 5, 5)
    layer0 = ConvPoolLayer(
        rng,
        input=layer0_input,
        input_shape=(batch_size, 1, idim0_H, idim0_W),
        filter_shape=(nkerns[0], 1, fdim0_H, fdim0_W),
        poolsize=(pdim0_H, pdim0_W)
    )

    # Construct the second convolutional pooling layer
    # filtering reduces the image size to (5-2+1, 5-2+1) = (4, 4)
    # maxpooling reduces this further to (4/2, 4/2) = (2, 2)
    # 4D output tensor is thus of shape (batch_size, nkerns[1], 2, 2)
    
    layer1 = ConvPoolLayer(
        rng,
        input=layer0.output,
        input_shape=(batch_size, nkerns[0], idim1_H, idim1_W),
        filter_shape=(nkerns[1], nkerns[0], fdim1_H, fdim1_W),
        poolsize=(pdim1_H, pdim1_W)
    )

    # the HiddenLayer being fully-connected, it operates on 2D matrices of
    # shape (batch_size, num_pixels) (i.e matrix of rasterized images).
    # This will generate a matrix of shape (batch_size, nkerns[1] * 2 * 2),
    # or (500, 50 * 4 * 4) = (500, 800) with the default values.
    layer2_input = layer1.output.flatten(2)
    
    
    # construct a fully-connected sigmoidal layer
    layer2 = HiddenLayer(
        rng,
        input=layer2_input,
        n_in=nkerns[1] * idim2_H * idim2_W,
        n_out=fdim2,
        activation=T.nnet.relu
    )

    # classify the values of the fully-connected sigmoidal layer
    nclass = max(train_set_y.eval()) + 1
    layer3 = LogisticRegression(input=layer2.output, n_in=fdim2, n_out=nclass)

    # the cost we minimize during training is the NLL of the model
    cost = layer3.negative_log_likelihood(y)

    # create a function to compute the mistakes that are made by the model

    validate_model = theano.function(
        [index],
        layer3.errors(y),
        givens={
            x: valid_set_x[index * batch_size: (index + 1) * batch_size],
            y: valid_set_y[index * batch_size: (index + 1) * batch_size]
        }
    )
    
    train_score = theano.function(
        [index],
        layer3.errors(y),
        givens={
            x: train_set_x[index * batch_size: (index + 1) * batch_size],
            y: train_set_y[index * batch_size: (index + 1) * batch_size]
        }
    )

    # create a list of all model parameters to be fit by gradient descent
    params = layer3.params + layer2.params + layer1.params + layer0.params

    # create a list of gradients for all model parameters
    grads = T.grad(cost, params)

    # train_model is a function that updates the model parameters by
    # SGD Since this model has many parameters, it would be tedious to
    # manually create an update rule for each model parameter. We thus
    # create the updates list by automatically looping over all
    # (params[i], grads[i]) pairs.
    updates = [
        (param_i, param_i - learning_rate * grad_i)
        for param_i, grad_i in zip(params, grads)
    ]

    train_model = theano.function(
        [index],
        cost,
        updates=updates,
        givens={
            x: train_set_x[index * batch_size: (index + 1) * batch_size],
            y: train_set_y[index * batch_size: (index + 1) * batch_size]
        }
    )
    # end-snippet-1

    ###############
    # TRAIN MODEL #
    ###############
    print '... training'
    # early-stopping parameters
    patience = 10 * n_train_batches  # look as this many examples regardless
    patience_increase = 2  # wait this much longer when a new best is
                           # found
    improvement_threshold = 0.996  # a relative improvement of this much is
                                   # considered significant
    validation_frequency = min(n_train_batches, patience / 2)
                                  # go through this many
                                  # minibatche before checking the network
                                  # on the validation set; in this case we
                                  # check every epoch

    best_validation_loss = numpy.inf
    best_iter = 0
    training_history = []
    start_time = timeit.default_timer()

    epoch = 0
    done_looping = False

    while (epoch < n_epochs):
        if earlystop and done_looping:
            print 'early-stopping'
            break
        epoch = epoch + 1
        for minibatch_index in xrange(n_train_batches):

            iter = (epoch - 1) * n_train_batches + minibatch_index

            cost_ij = train_model(minibatch_index)

            if (iter + 1) % validation_frequency == 0:

                # compute zero-one loss on validation set
                validation_losses = [validate_model(i) for i in xrange(n_valid_batches)]
                #training_losses = [train_score(i) for i in xrange(n_valid_batches)]
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
                    if this_validation_loss < best_validation_loss * improvement_threshold:
                        patience = max(patience, iter * patience_increase)
                        
                    numpy.savez(dumppath, model=params, training_history=training_history,
                                best_validation_loss=best_validation_loss)

                    # save best validation score and iteration number
                    best_validation_loss = this_validation_loss
                    best_iter = iter
                    print('best_validation_loss %f' % best_validation_loss)

            if patience <= iter:
                done_looping = True
                if earlystop:
                    break

    end_time = timeit.default_timer()
    # final save
    numpy.savez(dumppath, model=params, training_history=training_history,
                                best_validation_loss=best_validation_loss)
    
    print(
        (
            'Optimization complete with best validation score of %f %%, '
            'obtained at iteration %i, '
        ) % (best_validation_loss * 100., best_iter + 1)
    )
    print >> sys.stderr, ('The fine tuning code for file ' +
                          os.path.split(__file__)[1] +
                          ' ran for %.2fm' % ((end_time - start_time)
                                              / 60.))

if __name__ == '__main__':
    trainpath = sys.argv[1] #'../data/cv/'
    trainlist = sys.argv[2] #'JK-ch-1234' hold one out
    validset = sys.argv[3] #'../data/cv/C-ch.mat'
    
    # build dumppath
    nntoks = sys.argv[0].split('.')
    nn = nntoks[0]
    dumppath = '../model/' + nn + '-' + trainlist + '.npz'

    shuffle = 0
    scaling = 1
    datasel = 1
    robust = 0
    
    learning_rate=0.01
    n_epochs=300
    earlystop=True
    batch_size=100
    
    test_cnn(trainpath=trainpath,trainlist=trainlist,validset=validset,dumppath=dumppath,
                    learning_rate=learning_rate,n_epochs=n_epochs,batch_size=batch_size,earlystop=earlystop)

