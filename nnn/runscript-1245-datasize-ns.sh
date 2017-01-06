# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions
# such as: script runlog-1245.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JK-1245-ns ../data/cv/C-ns.mat 800,800"

# examples runs:

# THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JK-1245-ns ../data/cv/C-ns.mat 800,800

# THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JK-1245-ns ../data/cv/C-ns.mat 800,800 grbm

# THEANO_FLAGS="device=cuda1" python cnn.py ../data/cv/ JK-1245-ns ../data/cv/C-ns.mat

# THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JK-1245-ns ../data/cv/C-ns.mat 24 800

script log/log-mlp-JK-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JK-1245-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKU-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JKU-1245-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKUR-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JKUR-1245-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKURB-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python mlp.py ../data/cv/ JKURB-1245-ns ../data/cv/C-ns.mat 800,800"

script log/log-dbn-JK-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JK-1245-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKU-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JKU-1245-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKUR-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JKUR-1245-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKURB-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python dbn.py ../data/cv/ JKURB-1245-ns ../data/cv/C-ns.mat 800,800 grbm"

script log/log-blstm-JK-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JK-1245-ns ../data/cv/C-ns.mat 252 800"
script log/log-blstm-JKU-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JKU-1245-ns ../data/cv/C-ns.mat 252 800"
script log/log-blstm-JKUR-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JKUR-1245-ns ../data/cv/C-ns.mat 252 800"
script log/log-blstm-JKURB-1245-ns.txt -c "THEANO_FLAGS="device=cuda1" python blstm.py ../data/cv/ JKURB-1245-ns ../data/cv/C-ns.mat 252 800"