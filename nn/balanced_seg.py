from collections import OrderedDict
import numpy

def balanced(ydim,y):
    y_ = y.eval()
    od = OrderedDict()
    # initialize the OrderedDict as a dict of emtpy list
    # this dict contains an ordered list of (pos), ordered by chord class number [0,ydim-1]
    for k in range(ydim):
        od[k] = []
    
    # scan the pos and append to the dict correspondently
    for i in range(y_.shape[0]):
        label = y_[i]
        od[label].append(i)
                
    return od
    
def balanced_noeval(ydim,y):
    od = OrderedDict()
    # initialize the OrderedDict as a dict of emtpy list
    # this dict contains an ordered list of (pos), ordered by chord class number [0,ydim-1]
    for k in range(ydim):
        od[k] = []
    
    # scan the pos and append to the dict correspondently
    for i in range(len(y)):
        label = y[i]
        od[label].append(i)
                
    return od
    
def get_bc_idx(od,ydim):
    bc_idx = []
    for i in range(ydim):
        tmp = od[i]
        if tmp:
            randint = numpy.random.randint(len(tmp))
            bc_idx.append(tmp[randint])
            
    # print len(bc_idx) # normally in a ydim = 277 case, only 217 effective chords (some do not have an entry)
    
    return bc_idx