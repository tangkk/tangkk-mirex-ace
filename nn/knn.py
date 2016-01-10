# this is an supervised knn to classify ACE dataset

from sklearn import neighbors
from sklearn.metrics import accuracy_score
from loadmat import loadmat_noshare
import numpy
import cPickle

import sys
dataset = sys.argv[1] #'../data/ch/J6seg-ch-noinv.mat'
dumppath = sys.argv[2] #'../data/ch/knn.pkl'
n_neighbors = int(sys.argv[3]) #10
weights = sys.argv[4] # 'distance'


print 'dataset%s'dataset
print 'dumppath%s'dumppath
print 'n_neighbors%d'n_neighbors
print 'weights%s'weights


shuffle = 1
scaling = 1
robust = 0
datasel = 1
norm = 0

# this is run in cpu
datasets = loadmat_noshare(dataset=dataset,shuffle=shuffle,datasel=datasel,scaling=scaling,robust=robust,norm=norm)
print "dataset %s"%dataset
train_X, train_y = datasets[0]
valid_X, valid_y = datasets[1]
test_X, test_y = datasets[2]

clf = neighbors.KNeighborsClassifier(n_neighbors, weights=weights)

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

# save model
with open(dumppath, "wb") as f:
        cPickle.dump(clf, f)
