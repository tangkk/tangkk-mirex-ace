# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions
# such as: script runlog-1345.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JK-1345-ns-1seg ../data/cv/C-ns-1seg.mat 800,800"

# examples runs:

# THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JK-1345-ns-1seg ../data/cv/C-ns-1seg.mat 800,800

# THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JK-1345-ns-1seg ../data/cv/C-ns-1seg.mat 800,800 grbm

# THEANO_FLAGS="device=cuda2" python cnn.py ../data/cv/ JK-1345-ns-1seg ../data/cv/C-ns-1seg.mat

# THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JK-1345-ns-1seg ../data/cv/C-ns-1seg.mat 24 800

script log/log-mlp-JKU-1345-ns-1seg.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JKU-1345-ns-1seg ../data/cv/C-ns-1seg.mat 800,800"

script log/log-dbn-JKU-1345-ns-1seg.txt -c "THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JKU-1345-ns-1seg ../data/cv/C-ns-1seg.mat 800,800 grbm"

script log/log-blstm-JKU-1345-ns-1seg.txt -c "THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JKU-1345-ns-1seg ../data/cv/C-ns-1seg.mat 24 800"


script log/log-mlp-JKU-1345-ns-2seg.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JKU-1345-ns-2seg ../data/cv/C-ns-2seg.mat 800,800"

script log/log-dbn-JKU-1345-ns-2seg.txt -c "THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JKU-1345-ns-2seg ../data/cv/C-ns-2seg.mat 800,800 grbm"

script log/log-blstm-JKU-1345-ns-2seg.txt -c "THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JKU-1345-ns-2seg ../data/cv/C-ns-2seg.mat 24 800"


script log/log-mlp-JKU-1345-ns-3seg.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JKU-1345-ns-3seg ../data/cv/C-ns-3seg.mat 800,800"

script log/log-dbn-JKU-1345-ns-3seg.txt -c "THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JKU-1345-ns-3seg ../data/cv/C-ns-3seg.mat 800,800 grbm"

script log/log-blstm-JKU-1345-ns-3seg.txt -c "THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JKU-1345-ns-3seg ../data/cv/C-ns-3seg.mat 24 800"


script log/log-mlp-JKU-1345-ns-9seg.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JKU-1345-ns-9seg ../data/cv/C-ns-9seg.mat 800,800"

script log/log-dbn-JKU-1345-ns-9seg.txt -c "THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JKU-1345-ns-9seg ../data/cv/C-ns-9seg.mat 800,800 grbm"

script log/log-blstm-JKU-1345-ns-9seg.txt -c "THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JKU-1345-ns-9seg ../data/cv/C-ns-9seg.mat 24 800"


script log/log-mlp-JKU-1345-ns-12seg.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JKU-1345-ns-12seg ../data/cv/C-ns-12seg.mat 800,800"

script log/log-dbn-JKU-1345-ns-12seg.txt -c "THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JKU-1345-ns-12seg ../data/cv/C-ns-12seg.mat 800,800 grbm"

script log/log-blstm-JKU-1345-ns-12seg.txt -c "THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JKU-1345-ns-12seg ../data/cv/C-ns-12seg.mat 24 800"