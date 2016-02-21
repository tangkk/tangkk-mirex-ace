# this script deals with data that have variable length
# it will dump the processed .mat data to a .pkl for easy access by python

import numpy
import theano
import scipy.io as sio
import theano.tensor as T
from sklearn import preprocessing
from loadmat import standardize
import cPickle
import h5py

def load_matrix_data_h5py(dataset=None,name=None):
    f = h5py.File(dataset)
    mX = numpy.asarray(f[name]).T
    # this returns X and y equivalent to that of sio's
    return mX
    
def load_cell_data_h5py(dataset=None,name=None):
    cX = []
    with h5py.File(dataset) as f:
        for column in f[name]:
            for row_number in range(len(column)):
                dta = numpy.array(f[column[row_number]]).T
                cX.append(dta)
    return cX
    
def load_cell_data_h5py_0(dataset=None,name=None):
    cX = []
    with h5py.File(dataset) as f:
        for column in f[name]:
            row_data = []
            for row_number in range(len(column)):
                dta = f[column[row_number]][:]
                lta = []
                for idx in range(len(dta)):
                    lta.append(dta[idx][0])
                row_data.append(numpy.asarray(lta))
            cX.append(row_data)
    cX = numpy.asarray(cX).T
    return cX

# only this one deals with pure matrix, all other pkl functions are dealing with cell matrix    
def pkl_data_matrix(dataset=None, dumppath=None):
    mat = sio.loadmat(dataset)
    X = mat['X']
    y = mat['y']
    y = y.T[0]
    y[y==max(y)]=0
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)
        
    print X.shape
    print y.shape 

# FIXME: y should be in 'uint16' type    
def pkl_data_varlen_h5py(dataset=None, dumppath=None, fdim=None, nseg=1):
    X = load_cell_data_h5py_0(dataset,'X')
    X = X.T
    cX = []
    for i in range(len(X)):
        xi = X[i][0]
        # reshape xi and then average every nseg in n_step
        xr = xi.reshape(len(xi)/fdim, fdim) # n_step * n_feature
        xm = []
        for j in range(xr.shape[0])[0::nseg]: # start from index 0 and 
            xtemp = xr[j:numpy.min([j+nseg,xr.shape[0]])]
            xm.append(numpy.mean(xtemp,axis=0))
        xm = numpy.asarray(xm)
        xm = xm.flatten()
        # always standardize every cases when using cell as input
        # since this seems to be a reasonable thing to do
        xm = preprocessing.scale(xm)
        cX.append(xm)
    X = numpy.asarray(cX)
    
    y = load_matrix_data_h5py(dataset,'y')
    y = y.T[0]
    y[y==max(y)]=0
    
    print X.shape
    print y.shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)
        
def pkl_data_varlen(dataset=None, dumppath=None, fdim=None, nseg=1):
    mat = sio.loadmat(dataset)
    X = mat['X']
    cX = []
    for i in range(len(X)):
        xi = X[i][0][0]
        # reshape xi and then average every nseg in n_step
        xr = xi.reshape(len(xi)/fdim, fdim) # n_step * n_feature
        xm = []
        for j in range(xr.shape[0])[0::nseg]: # start from index 0 and 
            xtemp = xr[j:numpy.min([j+nseg,xr.shape[0]])]
            xm.append(numpy.mean(xtemp,axis=0))
        xm = numpy.asarray(xm)
        xm = xm.flatten()
        # always standardize every cases when using cell as input
        # since this seems to be a reasonable thing to do
        xm = preprocessing.scale(xm)
        cX.append(xm)
    X = numpy.asarray(cX)
    
    y = mat['y']
    y = y.T[0]
    y[y==max(y)]=0
    
    print X.shape
    print y.shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)
    
def pkl_data_nseg_h5py(dataset=None, dumppath=None, nseg=6, ymax=None):
    
    #############
    # LOAD DATA #
    #############
    X = load_cell_data_h5py(dataset,'X') # X is a list instead of a numpy array
    y = load_cell_data_h5py(dataset,'y')
    
    y_ = []
    for k in range(len(y)): # for every song entry
        # y_k is the target for one song "12 * n_timesteps" for all 12 keys transposition
        y_k = y[k]
        for kk in range(12): # iterate over 12 keys
            # y_kk is one song targets for one key
            ym = y_k[kk]
            # target no need to standardize
            # assuming max value of target is ymax
            ym[ym==ymax]=0
            ym = ym.astype('uint16')
            y_.append(ym)
            # y_ stores targets for all songs all keys, the 12 key dim is unrolled
    y = numpy.asarray(y_)
    
    print y.shape
    print y[0].shape
    
    # X dimension is 1 * number of songs
    X_ = []
    for k in range(len(X)): # for every song entry   
        # X_k is the feature for one song "12 * n_timesteps * dim_proj" for all 12 keys transposition
        X_k = X[k]
        for kk in range(12): # iterate over 12 keys
            X__ = []
            # X_kk is the feature for one key "n_timesteps * dim_proj" for the song
            X_kk = X_k[kk]
            lenkk = X_kk.shape[0]
            for i in range(X_kk.shape[0]):
                # xm is one time step of X_k. The size of xi is always dim_proj
                xmm = X_kk[i:numpy.min([i+nseg,lenkk])]
                xm = numpy.mean(xmm,axis=0)
                xm = preprocessing.scale(xm).astype(theano.config.floatX)
                # X__ stores features for one song one key
                X__.append(xm)
            # X_ stores features for all songs all keys, the 12 key dim is unrolled
            X_.append(numpy.asarray(X__))
    X = numpy.asarray(X_)
    
    print X.shape
    print X[0].shape
    print X[0][0].shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)
        
def pkl_data_framewise_h5py(dataset=None, dumppath=None, ymax=None):

    #############
    # LOAD DATA #
    #############
    X = load_cell_data_h5py(dataset,'X') # X is a list instead of a numpy array
    y = load_cell_data_h5py(dataset,'y')

    y_ = []
    for k in range(len(y)): # for every song entry
        # y_k is the target for one song "12 * n_timesteps" for all 12 keys transposition
        y_k = y[k]
        for kk in range(12): # iterate over 12 keys
            # y_kk is one song targets for one key
            ym = y_k[kk]
            # target no need to standardize
            ym[ym==ymax]=0
            ym = ym.astype('uint16')
            y_.append(ym)
            # y_ stores targets for all songs all keys, the 12 key dim is unrolled
    y = numpy.asarray(y_)
    
    print y.shape
    print y[0].shape
    
    # X dimension is 1 * number of songs
    X_ = []
    for k in range(len(X)): # for every song entry
        # X_k is the feature for one song "12 * n_timesteps * dim_proj" for all 12 keys transposition
        X_k = X[k]
        for kk in range(12): # iterate over 12 keys
            X__ = []
            # X_kk is the feature for one key "n_timesteps * dim_proj" for the song
            X_kk = X_k[kk]
            for i in range(X_kk.shape[0]):
                # xm is one time step of X_k. The size of xi is always dim_proj
                xm = X_kk[i]
                xm = preprocessing.scale(xm).astype(theano.config.floatX)
                # X__ stores features for one song one key
                X__.append(xm)
            # X_ stores features for all songs all keys, the 12 key dim is unrolled
            X_.append(numpy.asarray(X__))
    X = numpy.asarray(X_)
    
    print X.shape
    print X[0].shape
    print X[0][0].shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)
        
def pkl_data_nseg(dataset=None, dumppath=None, nseg=6, ymax=None):
    
    #############
    # LOAD DATA #
    #############
    mat = sio.loadmat(dataset)
    X = mat['X']
    
    # X dimension is 1 * number of songs
    X_ = []
    for k in range(X.shape[1]): # for every song entry   
        # X_k is the feature for one song "12 * n_timesteps * dim_proj" for all 12 keys transposition
        X_k = X[0][k]
        for kk in range(12): # iterate over 12 keys
            X__ = []
            # X_kk is the feature for one key "n_timesteps * dim_proj" for the song
            X_kk = X_k[kk]
            lenkk = X_kk.shape[0]
            for i in range(X_kk.shape[0]):
                # xm is one time step of X_k. The size of xi is always dim_proj
                xmm = X_kk[i:numpy.min([i+nseg,lenkk])]
                xm = numpy.mean(xmm,axis=0)
                xm = preprocessing.scale(xm).astype(theano.config.floatX)
                # X__ stores features for one song one key
                X__.append(xm)
            # X_ stores features for all songs all keys, the 12 key dim is unrolled
            X_.append(numpy.asarray(X__))
    X = numpy.asarray(X_)
    
    print X.shape
    print X[0].shape
    print X[0][0].shape
    
    y = mat['y']
    y_ = []
    for k in range(y.shape[1]): # for every song entry
        # y_k is the target for one song "12 * n_timesteps" for all 12 keys transposition
        y_k = y[0][k]
        for kk in range(12): # iterate over 12 keys
            # y_kk is one song targets for one key
            ym = y_k[kk]
            # target no need to standardize
            # assuming max value of target is ymax
            ym[ym==ymax]=0
            y_.append(ym)
            # y_ stores targets for all songs all keys, the 12 key dim is unrolled
    y = numpy.asarray(y_)
    
    print y.shape
    print y[0].shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)

def pkl_data_framewise(dataset=None, dumppath=None, ymax=None):

    #############
    # LOAD DATA #
    #############
    mat = sio.loadmat(dataset)
    X = mat['X']
    
    # X dimension is 1 * number of songs
    X_ = []
    for k in range(X.shape[1]): # for every song entry   
        # X_k is the feature for one song "12 * n_timesteps * dim_proj" for all 12 keys transposition
        X_k = X[0][k]
        for kk in range(12): # iterate over 12 keys
            X__ = []
            # X_kk is the feature for one key "n_timesteps * dim_proj" for the song
            X_kk = X_k[kk]
            for i in range(X_kk.shape[0]):
                # xm is one time step of X_k. The size of xi is always dim_proj
                xm = X_kk[i]
                xm = preprocessing.scale(xm).astype(theano.config.floatX)
                # X__ stores features for one song one key
                X__.append(xm)
            # X_ stores features for all songs all keys, the 12 key dim is unrolled
            X_.append(numpy.asarray(X__))
    X = numpy.asarray(X_)
    
    print X.shape
    print X[0].shape
    print X[0][0].shape
    
    y = mat['y']
    y_ = []
    for k in range(y.shape[1]): # for every song entry
        # y_k is the target for one song "12 * n_timesteps" for all 12 keys transposition
        y_k = y[0][k]
        for kk in range(12): # iterate over 12 keys
            # y_kk is one song targets for one key
            ym = y_k[kk]
            # target no need to standardize
            # assuming max value of target is ymax
            ym[ym==ymax]=0
            y_.append(ym)
            # y_ stores targets for all songs all keys, the 12 key dim is unrolled
    y = numpy.asarray(y_)
    
    print y.shape
    print y[0].shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)

def prepare_data(seqs, labels, maxlen=None, xdim=None):
    """Create the matrices from the datasets.

    This pad each sequence to the same lenght: the lenght of the
    longuest sequence or maxlen.

    if maxlen is set, we will cut all sequence to this maximum
    lenght.

    This swap the axis!
    """
    # x: a list of sentences
    lengths = [len(s) for s in seqs]

    if maxlen is not None:
        new_seqs = []
        new_labels = []
        new_lengths = []
        for l, s, y in zip(lengths, seqs, labels):
            if l < maxlen:
                new_seqs.append(s)
                new_labels.append(y)
                new_lengths.append(l)
        lengths = new_lengths
        labels = new_labels
        seqs = new_seqs

        if len(lengths) < 1:
            return None, None, None

    n_samples = len(seqs)
    maxlen = numpy.max(lengths)
    # print 'maxlen is %d'%maxlen

    x = numpy.zeros((maxlen, n_samples)).astype(theano.config.floatX)
    # the length of each submask should be maxlen/xdim (assuming x is a 1-dim vector where maxlen already contains
    # the xdim dimension, which means maxlen is dividable by xdim)
    x_mask = numpy.zeros((maxlen/xdim, n_samples)).astype(theano.config.floatX)
    x_oh_mask = numpy.zeros((maxlen/xdim, n_samples)).astype(theano.config.floatX)
    for idx, s in enumerate(seqs): # this enumerate n_samples
        x[:lengths[idx], idx] = s
        x_mask[:lengths[idx]/xdim, idx] = 1. # full hot mask
        # x_oh_mask[lengths[idx]/xdim-1, idx] = 1. # one hot mask
        
    x_oh_mask = x_mask
    return x, x_mask, x_oh_mask, labels

def load_data_varlen(dataset="../testnn.mat", valid_portion=0.1, test_portion=0.1, maxlen=None,
               scaling=1, robust=0, format = 'matrix'):
    '''Loads the dataset

    :type dataset: String
    :param dataset: The path to the dataset (here ACE dataset)
    :type valid_portion: float
    :param valid_portion: The proportion of the full train set used for
        the validation set.
    :type maxlen: None or positive int
    :param maxlen: the max sequence length we use in the train/valid set.
    :type sort_by_len: bool
    :name sort_by_len: Sort by the sequence lenght for the train,
        valid and test set. This allow faster execution as it cause
        less padding per minibatch. Another mechanism must be used to
        shuffle the train set at each epoch.

    '''

    #############
    # LOAD DATA #
    #############
   
    if format == 'cell':
        f = open(dataset, 'rb')
        X,y = cPickle.load(f)
    elif format == 'matrix':
        mat = sio.loadmat(dataset)
        X = mat['X']
        y = mat['y']
        y = y.T[0]
        y[y==max(y)]=0

    train_set = (X,y)
    
    if maxlen:
        new_train_set_x = []
        new_train_set_y = []
        for x, y in zip(train_set[0], train_set[1]):
            if len(x) < maxlen:
                new_train_set_x.append(x)
                new_train_set_y.append(y)
        train_set = (new_train_set_x, new_train_set_y)
        del new_train_set_x, new_train_set_y
    
    # split training set into validation set and test set
    # and randomly shuffle the set
    train_set_x, train_set_y = train_set
    n_samples = len(train_set_x)
    sidx = numpy.random.permutation(n_samples)
    n_train = int(numpy.round(n_samples * (1. - valid_portion - test_portion)))
    n_valid = int(numpy.round(n_samples * (1. - test_portion)))
    
    # note that these are list objects now (train_set_ , valid_set_, test_set_)
    test_set_x = [train_set_x[s] for s in sidx[n_valid:]]
    test_set_y = [train_set_y[s] for s in sidx[n_valid:]]
    # valid_set_x = [train_set_x[s] for s in sidx[n_train:n_valid]]
    # valid_set_y = [train_set_y[s] for s in sidx[n_train:n_valid]]
    valid_set_x = [train_set_x[s] for s in sidx[n_train:]] # 20% validation
    valid_set_y = [train_set_y[s] for s in sidx[n_train:]] # 20% validation
    train_set_x = [train_set_x[s] for s in sidx[:n_train]]
    train_set_y = [train_set_y[s] for s in sidx[:n_train]]
    
    train_set = (train_set_x, train_set_y)
    valid_set = (valid_set_x, valid_set_y)
    test_set = (test_set_x, test_set_y)
    
    if format == 'matrix':
        train_set_x, valid_set_x, test_set_x = standardize(train_set_x, valid_set_x, test_set_x, scaling, robust)

    train = (train_set_x, train_set_y)
    valid = (valid_set_x, valid_set_y)
    test = (test_set_x, test_set_y)

    return train, valid, test
    
def load_data_song(dataset=None, valid_portion=0.1, test_portion=0.1):
    f = open(dataset, 'rb')
    X,y = cPickle.load(f)
    
    # do not shuffle
    n_samples = X.shape[0]
    sidx = numpy.random.permutation(n_samples)
    n_train = int(numpy.round(n_samples * (1. - valid_portion - test_portion)))
    n_valid = int(numpy.round(n_samples * (1. - test_portion)))
    
    # note that these are list objects now (train_set_ , valid_set_, test_set_) rather than numpy objects
    test_set_x = numpy.asarray([X[s] for s in sidx[n_valid:]])
    test_set_y = numpy.asarray([y[s] for s in sidx[n_valid:]])
    # valid_set_x = numpy.asarray([X[s] for s in sidx[n_train:n_valid]])
    # valid_set_y = numpy.asarray([y[s] for s in sidx[n_train:n_valid]])
    valid_set_x = numpy.asarray([X[s] for s in sidx[n_train:]]) # 20% validation
    valid_set_y = numpy.asarray([y[s] for s in sidx[n_train:]]) # 20% validation
    train_set_x = numpy.asarray([X[s] for s in sidx[:n_train]])
    train_set_y = numpy.asarray([y[s] for s in sidx[:n_train]])

    train = (train_set_x, train_set_y)
    valid = (valid_set_x, valid_set_y)
    test = (test_set_x, test_set_y)
    
    print train_set_x.shape
    print train_set_y.shape
    print valid_set_x.shape
    print valid_set_y.shape
    print test_set_x.shape
    print test_set_y.shape
    

    return train, valid, test
    

if __name__ == '__main__':
    load_data_h5py()