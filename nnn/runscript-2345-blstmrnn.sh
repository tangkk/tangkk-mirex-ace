# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions

#script log2/log-blstmrnn-JK-2345-ch-songwise.txt -c "THEANO_FLAGS="device=cuda3" python blstmrnn.py ../data/cvsong/ JK-2345-ch-songwise ../data/cvsong/C-ch-songwise.pkl 24 277 800"
#script log2/log-blstmrnn-JKU-2345-ch-songwise.txt -c "THEANO_FLAGS="device=cuda3" python blstmrnn.py ../data/cvsong/ JKU-2345-ch-songwise ../data/cvsong/C-ch-songwise.pkl 24 277 800"
#script log2/log-blstmrnn-JKUR-2345-ch-songwise.txt -c "THEANO_FLAGS="device=cuda3" python blstmrnn.py ../data/cvsong/ JKUR-2345-ch-songwise ../data/cvsong/C-ch-songwise.pkl 24 277 800"
script log2/log-blstmrnn-JKURB-2345-ch-songwise.txt -c "THEANO_FLAGS="device=cuda3" python blstmrnn.py ../data/cvsong/ JKURB-2345-ch-songwise ../data/cvsong/C-ch-songwise.pkl 24 277 800"


#script log2/log-blstmrnn-JK-2345-ns-songwise.txt -c "THEANO_FLAGS="device=cuda3" python blstmrnn.py ../data/cvsong/ JK-2345-ns-songwise ../data/cvsong/C-ns-songwise.pkl 252 277 800"
#script log2/log-blstmrnn-JKU-2345-ns-songwise.txt -c "THEANO_FLAGS="device=cuda3" python blstmrnn.py ../data/cvsong/ JKU-2345-ns-songwise ../data/cvsong/C-ns-songwise.pkl 252 277 800"
#script log2/log-blstmrnn-JKUR-2345-ns-songwise.txt -c "THEANO_FLAGS="device=cuda3" python blstmrnn.py ../data/cvsong/ JKUR-2345-ns-songwise ../data/cvsong/C-ns-songwise.pkl 252 277 800"
script log2/log-blstmrnn-JKURB-2345-ns-songwise.txt -c "THEANO_FLAGS="device=cuda3" python blstmrnn.py ../data/cvsong/ JKURB-2345-ns-songwise ../data/cvsong/C-ns-songwise.pkl 252 277 800"
