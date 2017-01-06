# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions
# such as: script runlog-1345.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JK-1345-ch ../data/cv/C-ch.mat 800,800"

# examples runs:

# THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JK-1345-ch ../data/cv/C-ch.mat 800,800

# THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JK-1345-ch ../data/cv/C-ch.mat 800,800 grbm

# THEANO_FLAGS="device=cuda2" python cnn.py ../data/cv/ JK-1345-ch ../data/cv/C-ch.mat

# THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JK-1345-ch ../data/cv/C-ch.mat 24 800

script log/log-mlp-JK-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JK-1345-ch ../data/cv/C-ch.mat 800,800"
script log/log-mlp-JKU-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JKU-1345-ch ../data/cv/C-ch.mat 800,800"
script log/log-mlp-JKUR-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JKUR-1345-ch ../data/cv/C-ch.mat 800,800"
script log/log-mlp-JKURB-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python mlp.py ../data/cv/ JKURB-1345-ch ../data/cv/C-ch.mat 800,800"

script log/log-dbn-JK-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JK-1345-ch ../data/cv/C-ch.mat 800,800 grbm"
script log/log-dbn-JKU-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JKU-1345-ch ../data/cv/C-ch.mat 800,800 grbm"
script log/log-dbn-JKUR-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JKUR-1345-ch ../data/cv/C-ch.mat 800,800 grbm"
script log/log-dbn-JKURB-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python dbn.py ../data/cv/ JKURB-1345-ch ../data/cv/C-ch.mat 800,800 grbm"

script log/log-blstm-JK-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JK-1345-ch ../data/cv/C-ch.mat 24 800"
script log/log-blstm-JKU-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JKU-1345-ch ../data/cv/C-ch.mat 24 800"
script log/log-blstm-JKUR-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JKUR-1345-ch ../data/cv/C-ch.mat 24 800"
script log/log-blstm-JKURB-1345-ch.txt -c "THEANO_FLAGS="device=cuda2" python blstm.py ../data/cv/ JKURB-1345-ch ../data/cv/C-ch.mat 24 800"