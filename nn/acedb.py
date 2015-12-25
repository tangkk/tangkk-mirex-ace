import numpy
import theano
import scipy.io as sio
import theano.tensor as T
from sklearn import preprocessing
from loadmat import standardize

def prepare_data(seqs, labels, maxlen=None, dim_proj=None, fC='repeat'):
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
    
    # if feature control is 'reshape', dim_proj is used to control x_mask's length
    # otherwise, dim_proj is not used
    if fC == 'reshape':
        dim_proj = dim_proj
    elif fC == 'repeat':
        dim_proj = 1

    # x = numpy.zeros((maxlen, n_samples)).astype('int64')
    x = numpy.zeros((maxlen, n_samples)).astype(theano.config.floatX)
    # the length of each submask should be maxlen/dim_proj (assuming x is a 1-dim vector where maxlen already contains
    # the dim_proj dimension, which means maxlen is dividable by dim_proj)
    x_mask = numpy.zeros((maxlen/dim_proj, n_samples)).astype(theano.config.floatX)
    for idx, s in enumerate(seqs):
        x[:lengths[idx], idx] = s
        x_mask[:lengths[idx]/dim_proj, idx] = 1.

    return x, x_mask, labels


def load_data(dataset="../testnn.mat", valid_portion=0.1, maxlen=None,
              sort_by_len=False, scaling=1, robust=0):
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
    mat = sio.loadmat(dataset)
    X = mat['X']
    y = mat['y']
    # transpose the y so that it is a row array instead of a column array, which avoids the error:
    # "cannot convert type tensortype(int32, matrix) into type tensortype(int32,vector)"
    y = y.T[0]
    y[y==max(y)]=0

    train_set = (X,y)
    test_set = (X,y)
    
    if maxlen:
        new_train_set_x = []
        new_train_set_y = []
        for x, y in zip(train_set[0], train_set[1]):
            if len(x) < maxlen:
                new_train_set_x.append(x)
                new_train_set_y.append(y)
        train_set = (new_train_set_x, new_train_set_y)
        del new_train_set_x, new_train_set_y
    
    # split training set into validation set
    # and randomly shuffle the set
    train_set_x, train_set_y = train_set
    n_samples = len(train_set_x)
    sidx = numpy.random.permutation(n_samples)
    n_train = int(numpy.round(n_samples * (1. - valid_portion)))
    valid_set_x = [train_set_x[s] for s in sidx[n_train:]]
    valid_set_y = [train_set_y[s] for s in sidx[n_train:]]
    train_set_x = [train_set_x[s] for s in sidx[:n_train]]
    train_set_y = [train_set_y[s] for s in sidx[:n_train]]

    train_set = (train_set_x, train_set_y)
    valid_set = (valid_set_x, valid_set_y)

    test_set_x, test_set_y = test_set
    valid_set_x, valid_set_y = valid_set
    train_set_x, train_set_y = train_set
    
    train_set_x, valid_set_x, test_set_x = standardize(train_set_x, valid_set_x, test_set_x, scaling, robust)

    def len_argsort(seq):
        return sorted(range(len(seq)), key=lambda x: len(seq[x]))

    if sort_by_len:
        sorted_index = len_argsort(test_set_x)
        test_set_x = [test_set_x[i] for i in sorted_index]
        test_set_y = [test_set_y[i] for i in sorted_index]

        sorted_index = len_argsort(valid_set_x)
        valid_set_x = [valid_set_x[i] for i in sorted_index]
        valid_set_y = [valid_set_y[i] for i in sorted_index]

        sorted_index = len_argsort(train_set_x)
        train_set_x = [train_set_x[i] for i in sorted_index]
        train_set_y = [train_set_y[i] for i in sorted_index]

    train = (train_set_x, train_set_y)
    valid = (valid_set_x, valid_set_y)
    test = (test_set_x, test_set_y)

    return train, valid, test
