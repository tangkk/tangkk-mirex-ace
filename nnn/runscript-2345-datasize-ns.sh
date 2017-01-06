# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions
# such as: script runlog-2345.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JK-2345-ns ../data/cv/C-ns.mat 800,800"

# examples runs:

# THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JK-2345-ns ../data/cv/C-ns.mat 800,800

# THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JK-2345-ns ../data/cv/C-ns.mat 800,800 grbm

# THEANO_FLAGS="device=cuda3" python cnn.py ../data/cv/ JK-2345-ns ../data/cv/C-ns.mat

# THEANO_FLAGS="device=cuda3" python blstm.py ../data/cv/ JK-2345-ns ../data/cv/C-ns.mat 24 800

script log/log-mlp-JK-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JK-2345-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKU-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKUR-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKUR-2345-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKURB-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKURB-2345-ns ../data/cv/C-ns.mat 800,800"

script log/log-dbn-JK-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JK-2345-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKU-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKUR-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKUR-2345-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKURB-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKURB-2345-ns ../data/cv/C-ns.mat 800,800 grbm"

script log/log-blstm-JK-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python blstm.py ../data/cv/ JK-2345-ns ../data/cv/C-ns.mat 252 800"
script log/log-blstm-JKU-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python blstm.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 252 800"
script log/log-blstm-JKUR-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python blstm.py ../data/cv/ JKUR-2345-ns ../data/cv/C-ns.mat 252 800"
script log/log-blstm-JKURB-2345-ns.txt -c "THEANO_FLAGS="device=cuda3" python blstm.py ../data/cv/ JKURB-2345-ns ../data/cv/C-ns.mat 252 800"