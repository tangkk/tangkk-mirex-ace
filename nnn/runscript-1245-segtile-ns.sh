# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions
# such as: script runlog-12525.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JK-12525-ns-1seg ../data/cv/C-ns-1seg.mat 800,800"

# examples runs:

# THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JK-12525-ns-1seg ../data/cv/C-ns-1seg.mat 800,800

# THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JK-12525-ns-1seg ../data/cv/C-ns-1seg.mat 800,800 grbm

# THEANO_FLAGS="device=cuda1" python cnn.py ../data/cv/ JK-12525-ns-1seg ../data/cv/C-ns-1seg.mat

# THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JK-12525-ns-1seg ../data/cv/C-ns-1seg.mat 252 800

#script log/log-mlp-JKU-12525-ns-1seg.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JKU-12525-ns-1seg ../data/cv/C-ns-1seg.mat 800,800"

#script log/log-dbn-JKU-12525-ns-1seg.txt -c "THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JKU-12525-ns-1seg ../data/cv/C-ns-1seg.mat 800,800 grbm"

script log/log-blstm-JKU-12525-ns-1seg.txt -c "THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JKU-12525-ns-1seg ../data/cv/C-ns-1seg.mat 252 800"


#script log/log-mlp-JKU-12525-ns-2seg.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JKU-12525-ns-2seg ../data/cv/C-ns-2seg.mat 800,800"

#script log/log-dbn-JKU-12525-ns-2seg.txt -c "THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JKU-12525-ns-2seg ../data/cv/C-ns-2seg.mat 800,800 grbm"

script log/log-blstm-JKU-12525-ns-2seg.txt -c "THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JKU-12525-ns-2seg ../data/cv/C-ns-2seg.mat 252 800"


#script log/log-mlp-JKU-12525-ns-3seg.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JKU-12525-ns-3seg ../data/cv/C-ns-3seg.mat 800,800"

#script log/log-dbn-JKU-12525-ns-3seg.txt -c "THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JKU-12525-ns-3seg ../data/cv/C-ns-3seg.mat 800,800 grbm"

script log/log-blstm-JKU-12525-ns-3seg.txt -c "THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JKU-12525-ns-3seg ../data/cv/C-ns-3seg.mat 252 800"


#script log/log-mlp-JKU-12525-ns-9seg.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JKU-12525-ns-9seg ../data/cv/C-ns-9seg.mat 800,800"

#script log/log-dbn-JKU-12525-ns-9seg.txt -c "THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JKU-12525-ns-9seg ../data/cv/C-ns-9seg.mat 800,800 grbm"

script log/log-blstm-JKU-12525-ns-9seg.txt -c "THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JKU-12525-ns-9seg ../data/cv/C-ns-9seg.mat 252 800"


#script log/log-mlp-JKU-12525-ns-12seg.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JKU-12525-ns-12seg ../data/cv/C-ns-12seg.mat 800,800"

#script log/log-dbn-JKU-12525-ns-12seg.txt -c "THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JKU-12525-ns-12seg ../data/cv/C-ns-12seg.mat 800,800 grbm"

script log/log-blstm-JKU-12525-ns-12seg.txt -c "THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JKU-12525-ns-12seg ../data/cv/C-ns-12seg.mat 252 800"