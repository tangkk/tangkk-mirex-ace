from sklearn import svm
import scipy.io as sio
from sklearn.metrics import accuracy_score
import numpy

dataset = '../data-B6-ns-12-key-raw.mat'
mat = sio.loadmat(dataset)
shuffle = 1;
datasel = 1;
    
# the data is in 'X' 'y' format, where 'X' contains the input features, and 'y' contains the output labels
X = mat['X']
y = mat['y']
# transpose the y so that it is a row array instead of a column array, which avoids the error:
# "cannot convert type tensortype(int32, matrix) into type tensortype(int32,vector)"
y = y.T[0]

if shuffle:
    ind = range(0,len(X))
    numpy.random.shuffle(ind)
    X = X[ind]
    y = y[ind]
    
X = X[0:len(X)*datasel]
y = y[0:len(y)*datasel]

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
mu = numpy.mean(train_X,axis=0)
sigma = numpy.std(train_X,axis=0)
print "mu %d"%mu.shape
print "sigma %d"%sigma.shape
# python will automatically broadcast the row vector to the whole matrix, no worry
train_X = (train_X - mu) / sigma
valid_X = (valid_X - mu) / sigma
test_X = (test_X - mu) / sigma
###########################################

train_y = numpy.asarray(y[0:trainidx],dtype=numpy.int64)
valid_y = numpy.asarray(y[trainidx:valididx],dtype=numpy.int64)
test_y = numpy.asarray(y[valididx:testidx],dtype=numpy.int64)

print "train_X (%d,%d)"%train_X.shape
print "valid_X (%d,%d)"%valid_X.shape
print "test_X (%d,%d)"%test_X.shape

print "train_y %d"%train_y.shape[0]
print "valid_y %d"%valid_y.shape[0]
print "test_y %d"%test_y.shape[0]

# use svm to fit the training data (train_X,train_y) - use a multiclass SVC
clf = svm.SVC(decision_function_shape = 'ovo')
print "dataset %s"%dataset
print "fitting the training data"
clf.fit(train_X,train_y)

y_pred_train = clf.predict(train_X)
train_score = accuracy_score(train_y, y_pred_train)
print "training score %f"%train_score

y_pred_valid = clf.predict(valid_X)
valid_score = accuracy_score(valid_y, y_pred_valid)
print "validation score %f"%valid_score

y_pred_test = clf.predict(test_X)
test_score = accuracy_score(test_y, y_pred_test)
print "testing score %f"%test_score
