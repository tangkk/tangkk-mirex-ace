# load a .mat file as training, validation, test dataset

import scipy.io as sio
import theano
import theano.tensor as T
import numpy
from sklearn import preprocessing

def loadmat(dataset, shuffle=1, datasel=1, scaling=1, normalizing=0):
    ''' Loads the dataset

    :type dataset: string
    :param dataset: the path to the dataset
    '''

    #############
    # LOAD DATA #
    #############

    print '... loading data'

    # Load the dataset
    mat = sio.loadmat(dataset)
    
    # the data is in 'X' 'y' format, where 'X' contains the input features, and 'y' contains the output labels
    X = mat['X']
    y = mat['y']
    # transpose the y so that it is a row array instead of a column array, which avoids the error:
    # "cannot convert type tensortype(int32, matrix) into type tensortype(int32,vector)"
    y = y.T[0]
    
    # put the max of y = 0 (conform with python indexing standard)
    y[y==max(y)]=0
    
    # shuffle the samples
    if shuffle:
        ind = range(0,len(X))
        numpy.random.shuffle(ind)
        X = X[ind]
        y = y[ind]
        
    X = X[0:len(X)*datasel]
    y = y[0:len(y)*datasel]
    
    # normalization
    if normalizing == 1:
        X = preprocessing.normalize(X,norm='l1')
    elif normalizing == 2:
        X = preprocessing.normalize(X,norm='l2')
    elif normalizing == 'max':
        X = preprocessing.normalize(X,norm='max')
    
    #train_set, valid_set, test_set format: tuple(input, target)
    #input is an numpy.ndarray of 2 dimensions (a matrix)
    #witch row's correspond to an example. target is a
    #numpy.ndarray of 1 dimensions (vector)) that have the same length as
    #the number of rows in the input. It should give the target
    #target to the example with the same index in the input.
    
    # train_set 80%, valid_set 10%, test_set 10% - tentatively
    trainidx = len(X)*8/10
    valididx = len(X)*9/10
    testidx = len(X)
    
    train_X = numpy.asarray(X[0:trainidx],dtype=numpy.float32)
    valid_X = numpy.asarray(X[trainidx:valididx],dtype=numpy.float32)
    test_X = numpy.asarray(X[valididx:testidx],dtype=numpy.float32)
    
    ###########################################
    # standardization:
    # for every feature compenent x_i compute the mean(mu) and std(sigma) w.r.t. the whole training X
    # update x_i <= (x_i - mu) / sigma
    # standardize the validation and test set using the same mu and sigma of the training X's
    # mu = numpy.mean(train_X,axis=0)
    # sigma = numpy.std(train_X,axis=0)
    # print "mu %d"%mu.shape
    # print "sigma %d"%sigma.shape
    ## python will automatically broadcast the row vector to the whole matrix, no worry
    # train_X = (train_X - mu) / sigma
    # valid_X = (valid_X - mu) / sigma
    # test_X = (test_X - mu) / sigma
    ##########################################
    
    # standardization 
    if scaling == 1:
        scaler = preprocessing.StandardScaler().fit(train_X)
        train_X = scaler.transform(train_X)
        valid_X = scaler.transform(valid_X)
        test_X = scaler.transform(test_X)
    elif scaling == 2:
    # [0,1] scaling
        min_max_scaler = preprocessing.MinMaxScaler().fit(train_X)
        train_X = min_max_scaler.transform(train_X)
        valid_X = min_max_scaler.transform(valid_X)
        test_X = min_max_scaler.transform(test_X)
    elif scaling == 3:
        # [-1,1] scaling
        max_abs_scaler = preprocessing.MaxAbsScaler().fit(train_X)
        train_X = max_abs_scaler.transform(train_X)
        valid_X = max_abs_scaler.transform(valid_X)
        test_X = max_abs_scaler.transform(test_X)
    
    # collect labels
    train_y = numpy.asarray(y[0:trainidx],dtype=numpy.int64)
    valid_y = numpy.asarray(y[trainidx:valididx],dtype=numpy.int64)
    test_y = numpy.asarray(y[valididx:testidx],dtype=numpy.int64)
    
    # make data set
    train_set = (train_X, train_y)
    valid_set = (valid_X, valid_y)
    test_set = (test_X, test_y)
    
    # normalization and binarization
    
    print "train_X (%d,%d)"%train_X.shape
    print "valid_X (%d,%d)"%valid_X.shape
    print "test_X (%d,%d)"%test_X.shape
    
    print "train_y %d"%train_y.shape[0]
    print "valid_y %d"%valid_y.shape[0]
    print "test_y %d"%test_y.shape[0]
    

    def shared_dataset(data_xy, borrow=True):
        """ Function that loads the dataset into shared variables

        The reason we store our dataset in shared variables is to allow
        Theano to copy it into the GPU memory (when code is run on GPU).
        Since copying data into the GPU is slow, copying a minibatch everytime
        is needed (the default behaviour if the data is not in a shared
        variable) would lead to a large decrease in performance.
        """
        data_x, data_y = data_xy
        shared_x = theano.shared(numpy.asarray(data_x,
                                               dtype=theano.config.floatX),
                                 borrow=borrow)
        shared_y = theano.shared(numpy.asarray(data_y,
                                               dtype=theano.config.floatX),
                                 borrow=borrow)
        # When storing data on the GPU it has to be stored as floats
        # therefore we will store the labels as ``floatX`` as well
        # (``shared_y`` does exactly that). But during our computations
        # we need them as ints (we use labels as index, and if they are
        # floats it doesn't make sense) therefore instead of returning
        # ``shared_y`` we will have to cast it to int. This little hack
        # lets ous get around this issue
        return shared_x, T.cast(shared_y, 'int32')

    test_set_x, test_set_y = shared_dataset(test_set)
    valid_set_x, valid_set_y = shared_dataset(valid_set)
    train_set_x, train_set_y = shared_dataset(train_set)

    rval = [(train_set_x, train_set_y), (valid_set_x, valid_set_y),
            (test_set_x, test_set_y)]
    return rval