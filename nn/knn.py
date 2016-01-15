# this is an supervised knn to classify ACE dataset

from sklearn import neighbors
from sklearn.metrics import accuracy_score
from loadmat import loadmat_noshare
import numpy
import cPickle
import sys

shuffle = 1
scaling = 1
robust = 0
datasel = 1
norm = 0

def predprobs(model, X):
    return model.predict(X)

def test_knn(dataset, dumppath, n_neighbors, weights):
    print locals()
    
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

    # y_pred_test = clf.predict(test_X)
    # test_score = accuracy_score(test_y, y_pred_test)
    # print "testing score %f"%test_score

    # save model
    with open(dumppath, "wb") as f:
            cPickle.dump(clf, f)
        
if __name__ == '__main__':
    dataset = sys.argv[1] #'../data/ch/J6seg-ch-noinv.mat'
    dumppath = sys.argv[2] #'../data/model/knn.pkl'
    n_neighbors = int(sys.argv[3]) #10
    weights = sys.argv[4] # 'distance'
    test_knn(dataset, dumppath, n_neighbors, weights)
