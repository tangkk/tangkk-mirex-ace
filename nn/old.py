'''
    # make prediction at each lstm state
    # lstmlr is a n_timesteps*n_samples*dim_proj tensor same as "x"(emb)
    def __step(one_lstmlr):
        one_pred = T.nnet.softmax(T.dot(one_lstmlr, tparams['U']) + tparams['b'])
        return one_pred
    
    
    # output a n_timesteps*n_samples*ydim result - rval
    ydim = options['ydim']
    pred, updates_ = theano.scan(__step,
                                sequences=[lstmlr],
                                # outputs_info=[T.alloc(numpy_floatX(0.),
                                                           # n_samples,
                                                           # ydim),
                                              # T.alloc(numpy_floatX(0.),
                                                           # n_samples,
                                                           # ydim)],
                                name=_p(prefix, '_pred'),
                                n_steps=nsteps)
    
    # pred is a n_timesteps * n_samples * ydim prediction result matrix
    f_pred_prob = theano.function([x], pred, name='f_pred_prob')
    f_pred = theano.function([x], pred.argmax(axis=2), name='f_pred')
    
    def ___step(one_pred, one_y):
        off = 1e-8
        one_cost = -T.log(one_pred[T.arange(one_y.shape[0]), one_y] + off).mean()
        return one_cost
    
    # scan along the n_timesteps and accumulate the cost (using sum via axis=0)
    cost, updates__ = theano.scan(___step,
                                sequences=[pred],
                                # outputs_info=[T.alloc(numpy_floatX(0.),
                                                           # n_samples),
                                              # T.alloc(numpy_floatX(0.),
                                                           # n_samples)],
                                name=_p(prefix, '_cost'),
                                n_steps=nsteps)
    
    sumcost = cost.sum(axis=0)
'''