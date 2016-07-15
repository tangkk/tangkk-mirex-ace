from collections import OrderedDict

def balanced(ydim,y):
    od = OrderedDict()
    # initialize the OrderedDict as a dict of emtpy list
    # this dict contains an ordered list of (songidx, pos), ordered by class number
    for k in range(ydim):
        od[k] = []
        
    for i in range(y.shape[0]):
        first_label = y[i][0]
        od[first_label].append([i,0])
        for j in range(1, y[i].shape[0]):
            if y[i][j] != y[i][j-1]:
                label = y[i][j]
                od[label].append([i,j])
                
    return od