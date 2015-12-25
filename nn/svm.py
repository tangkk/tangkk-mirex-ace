# this is an svm to classify ACE dataset

from sklearn import svm
import scipy.io as sio
from sklearn.metrics import accuracy_score
from loadmat import loadmat
import numpy

dataset = '../data-J6-12-key-raw.mat'
mat = sio.loadmat(dataset)
shuffle = 1
datasel = 1
scaling = 0
robust = 0
norm = 0

datasets = loadmat(dataset=dataset,shuffle=shuffle,datasel=datasel,scaling=scaling,robust=robust,norm=norm)

train_X, train_y = datasets[0]
valid_X, valid_y = datasets[1]
test_X, test_y = datasets[2]

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
