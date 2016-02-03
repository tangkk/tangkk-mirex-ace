# be called in the root dir of ACE
import numpy
import cPickle
import scipy.io as sio
from sklearn import preprocessing
from scipy.stats import mode
import theano
import sys

input = sys.argv[1]
modellist = sys.argv[2]

mat = sio.loadmat(input)
X = mat['X']
X = preprocessing.scale(X, axis=1)

def extractnninv(line):
    if line.find('mlp')>=0:
        nntype = 'mlp'
    elif line.find('dbn')>=0:
        nntype = 'dbn'
    elif line.find('blstm')>=0:
        nntype = 'blstm'
    elif line.find('lstm')>=0:
        nntype = 'lstm'
    elif line.find('knn')>=0:
        nntype = 'knn'
    elif line.find('svm')>=0:
        nntype = 'svm'
    else:
        nntype = 'none'
    
    if line.find('noinv')>=0:
        invtype = 'noinv'
    elif line.find('inv')>=0:
        invtype = 'inv'
    else:
        invtype = 'none'
        
    if line.find('J6seg')>=0:
        datatype = 'J6seg'
    elif line.find('B6seg')>=0:
        datatype = 'B6seg'
    else:
        datatype = 'none'
        
    return nntype, invtype, datatype

y_preds_ens = []
y_probs_ens = []
f = open(modellist,'rb')
modelroot = './data/model/'
for line in f:
    nntype, invtype, datatype = extractnninv(line)
    modelpath = modelroot + line.strip()
    if nntype == 'mlp' or nntype == 'dbn':
        with open(modelpath, 'rb') as f:
            model = cPickle.load(f)
    elif nntype == 'knn' or nntype == 'svm':
        with open(modelpath, 'rb') as f:
            model = cPickle.load(f)
    elif nntype == 'lstm' or nntype == 'blstm' or nntype == 'ctc' or nntype == 'bctc':
        model = numpy.load(modelpath)
            
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
        y_preds_ens.append(y_preds)
    else:
        y_probs, y_preds = predprobs(model,X)
        # conform to matlab indexing standard
        y_probs = numpy.roll(y_probs,-1,axis=1)
        y_preds[y_preds==0] = nclass
        print y_preds
        y_preds_ens.append(y_preds)
        y_probs_ens.append(y_probs)
        
y_preds_ens = numpy.asarray(y_preds_ens)
y_probs_ens = numpy.asarray(y_probs_ens)

# FIXME: is this a good ensembling solution?
y_preds = mode(y_preds_ens)[0][0]
print y_preds
y_probs = numpy.mean(y_probs_ens,axis=0)

sio.savemat('./data/temp/y_preds.mat', {'y_preds':y_preds})
sio.savemat('./data/temp/y_probs.mat', {'y_probs':y_probs})