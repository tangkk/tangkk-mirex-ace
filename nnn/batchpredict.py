import glob
import scipy.io as sio
from sklearn import preprocessing
import numpy
import mlp, dbn, blstm
import sys

def predict(x, model, datapath):
    # 1. load input (in .mat format)
    # standardize the input (scaling = 1)
    mat = sio.loadmat(x)
    X = mat['X']
    X = preprocessing.scale(X, axis=1)
    # X = theano.shared(numpy.asarray(X, dtype=theano.config.floatX), borrow=True)
    
    # 2. load savez (in .pkl format or .npz format)
    savez = numpy.load(model)
    
    nntype = ''
    if "mlp" in model:
        nntype = 'mlp'
    elif 'dbn' in model:
        nntype = 'dbn'
    elif 'blstm' in model:
        nntype = 'blstm'
    elif 'cnn' in model:
        nntype = 'cnn'
    else:
        nntype = 'none'
    
    print nntype
                
    # 3. predict output using the model and the input
    # 4. save the prediction back to .mat
    invtype = 'inv'
    
    if invtype == 'inv':
        nclass = 277
    elif invtype == 'no7':
        nclass = 73
    elif invtype == 'noinv':
        nclass = 61
    elif invtype == 'jazz':
        nclass = 421
    elif invtype == 'Mm':
        nclass = 25
    elif invtype == 'full':
        nclass = 121
    
    if "mlp" in model:
        y_probs, y_preds = mlp.predprobs(savez,X)
    elif 'dbn' in model:
        y_probs, y_preds = dbn.predprobs(savez,X)
    elif 'blstm' in model:
        y_probs, y_preds = blstm.predprobs(savez,X)
    else:
        assert 0, "model not supported yet"
    
    
    # conform to matlab indexing standard
    y_probs = numpy.roll(y_probs,-1,axis=1)
    y_preds[y_preds==0] = nclass
    print y_preds
    
    strtoksx = x.split('/');
    strtoksm = model.split('/');
    
    y_probspath = datapath + 'y_probs/' + strtoksm[-1] + "|" + strtoksx[-1]
    y_predspath = datapath + 'y_preds/' + strtoksm[-1] + "|" + strtoksx[-1]
    
    print y_probspath
    print y_predspath
    
    sio.savemat(y_probspath, {'y_probs':y_probs})
    sio.savemat(y_predspath, {'y_preds':y_preds})

def batchpredict(xlist, modellist, datapath):
    for x in xlist:
        for model in modellist:
            print x
            print model
            predict(x,model,datapath)
            
            
    return


if __name__ == '__main__':
    datapath = sys.argv[1]
    modelpath = sys.argv[2]
    fold = sys.argv[3]
    
    xpath = datapath + 'x/'
    
    # ch runs
    # 1seg
    fl = 'ch'
    xlist = glob.glob(xpath + "*" + fl + "-1seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-1seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 2seg
    xlist = glob.glob(xpath + "*" + fl + "-2seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-2seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 3seg
    xlist = glob.glob(xpath + "*" + fl + "-3seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-3seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 6seg
    xlist = glob.glob(xpath + "*" + fl + "-6seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-6seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 9seg
    xlist = glob.glob(xpath + "*" + fl + "-9seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-9seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 12seg
    xlist = glob.glob(xpath + "*" + fl + "-12seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-12seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    
    # ns runs
    # 1seg
    fl = 'ns'
    xlist = glob.glob(xpath + "*" + fl + "-1seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-1seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 2seg
    xlist = glob.glob(xpath + "*" + fl + "-2seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-2seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 3seg
    xlist = glob.glob(xpath + "*" + fl + "-3seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-3seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 6seg
    xlist = glob.glob(xpath + "*" + fl + "-6seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-6seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 9seg
    xlist = glob.glob(xpath + "*" + fl + "-9seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-9seg*.npz")
    batchpredict(xlist, modellist, datapath)
    
    # 12seg
    xlist = glob.glob(xpath + "*" + fl + "-12seg.mat")
    modellist = glob.glob(modelpath + "*" + fold + "*" + fl + "-12seg*.npz")
    batchpredict(xlist, modellist, datapath)
    