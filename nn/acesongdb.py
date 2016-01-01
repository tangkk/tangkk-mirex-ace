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
    
def pkl_data_nseg_h5py(dataset=None, dumppath=None, nseg=6):
    
    #############
    # LOAD DATA #
    #############
    X = load_data_cell_h5py(dataset,'X') # X is a list instead of a numpy array
    y = load_data_cell_h5py(dataset,'y')
    
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
    
    y = mat['y']
    y_ = []
    for k in range(y.shape[1]): # for every song entry
        # y_k is the target for one song "12 * n_timesteps" for all 12 keys transposition
        y_k = y[0][k]
        for kk in range(12): # iterate over 12 keys
            # y_kk is one song targets for one key
            ym = y_k[kk]
            # target no need to standardize
            # assuming max value of target is 277
            ym[ym==277]=0
            y_.append(ym)
            # y_ stores targets for all songs all keys, the 12 key dim is unrolled
    y = numpy.asarray(y_)
    
    print y.shape
    print y[0].shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)
        
    return X,y
    
def pkl_data_framewise_h5py(dataset=None, dumppath=None):

    #############
    # LOAD DATA #
    #############
    X = load_data_cell_h5py(dataset,'X') # X is a list instead of a numpy array
    y = load_data_cell_h5py(dataset,'y')
    
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
    
    y_ = []
    for k in range(y.shape[1]): # for every song entry
        # y_k is the target for one song "12 * n_timesteps" for all 12 keys transposition
        y_k = y[0][k]
        for kk in range(12): # iterate over 12 keys
            # y_kk is one song targets for one key
            ym = y_k[kk]
            # target no need to standardize
            # assuming max value of target is 277
            ym[ym==277]=0
            y_.append(ym)
            # y_ stores targets for all songs all keys, the 12 key dim is unrolled
    y = numpy.asarray(y_)
    
    print y.shape
    print y[0].shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)
        
    return X,y

def pkl_data_nseg(dataset=None, dumppath=None, nseg=6):
    
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
            # assuming max value of target is 277
            ym[ym==277]=0
            y_.append(ym)
            # y_ stores targets for all songs all keys, the 12 key dim is unrolled
    y = numpy.asarray(y_)
    
    print y.shape
    print y[0].shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)
        
    return X,y

def pkl_data_framewise(dataset=None, dumppath=None):

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
            # assuming max value of target is 277
            ym[ym==277]=0
            y_.append(ym)
            # y_ stores targets for all songs all keys, the 12 key dim is unrolled
    y = numpy.asarray(y_)
    
    print y.shape
    print y[0].shape
    
    with open(dumppath, "wb") as f:
        cPickle.dump((X,y), f)
        
    return X,y

def load_data(dataset=None, valid_portion=0.05, test_portion=0.05):
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
    valid_set_x = numpy.asarray([X[s] for s in sidx[n_train:n_valid]])
    valid_set_y = numpy.asarray([y[s] for s in sidx[n_train:n_valid]])
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