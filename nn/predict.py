import numpy
import cPickle
import scipy.io as sio
from sklearn import preprocessing
import theano
import sys

input = sys.argv[1]
modelpath = sys.argv[2]
nntype = sys.argv[3]
invtype = sys.argv[4]

# 1. load input (in .mat format)
# standardize the input (scaling = 1)
mat = sio.loadmat(input)
X = mat['X']
X = preprocessing.scale(X, axis=1)
# X = theano.shared(numpy.asarray(X, dtype=theano.config.floatX), borrow=True)

# 2. load model (in .pkl format or .npz format)
if nntype == 'mlp' or nntype == 'dbn':
    with open(modelpath, 'rb') as f:
        model = cPickle.load(f)
elif nntype == 'knn' or nntype == 'svm':
    with open(modelpath, 'rb') as f:
        model = cPickle.load(f)
elif nntype == 'lstm' or nntype == 'blstm' or nntype == 'ctc' or nntype == 'bctc':
    model = numpy.load(modelpath)
            
# 3. predict output using the model and the input
# 4. save the prediction back to .mat
importCmd = 'from ' + nntype + ' import predprobs'
exec(importCmd)

if invtype == 'inv':
    nclass = 277
elif invtype == 'noinv':
    nclass = 61
    
if nntype == 'svm' or nntype == 'knn':
    y_preds = predprobs(model,X)
    y_preds[y_preds==0] = nclass
    print y_preds
    sio.savemat('./data/temp/y_preds.mat', {'y_preds':y_preds})
else:
    y_probs, y_preds = predprobs(model,X)
    # conform to matlab indexing standard
    y_probs = numpy.roll(y_probs,-1,axis=1)
    y_preds[y_preds==0] = nclass
    print y_preds
    sio.savemat('./data/temp/y_probs.mat', {'y_probs':y_probs})
    sio.savemat('./data/temp/y_preds.mat', {'y_preds':y_preds})