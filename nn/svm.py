# this is an svm to classify ACE dataset

from sklearn import svm
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

def test_svm(dataset, dumppath):
    print locals()

    datasets = loadmat_noshare(dataset=dataset,shuffle=shuffle,datasel=datasel,scaling=scaling,robust=robust,norm=norm)

    train_X, train_y = datasets[0]
    valid_X, valid_y = datasets[1]
    test_X, test_y = datasets[2]

    # use svm to fit the training data (train_X,train_y) - use a multiclass SVC
    clf = svm.SVC(decision_function_shape = 'ovo')
    print "dataset %s"%dataset
    print "fitting the training data"
    clf.fit(train_X,train_y)
    
    # this svm probably is with default configs:
    '''
    SVC(C=1.0, cache_size=200, class_weight=None, coef0=0.0,
        decision_function_shape='ovo', degree=3, gamma='auto', kernel='rbf',
        max_iter=-1, probability=False, random_state=None, shrinking=True,
        tol=0.001, verbose=False)
    '''

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
    dataset = sys.argv[1] #'../data/ch/B6seg-ch-noinv.mat'
    dumppath = sys.argv[2] #'../data/ch/svm.pkl'
    test_svm(dataset, dumppath)