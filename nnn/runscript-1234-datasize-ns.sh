# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions
# such as: script runlog-1234.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JK-1234-ns ../data/cv/C-ns.mat 800,800"

# examples runs:

# THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JK-1234-ns ../data/cv/C-ns.mat 800,800

# THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JK-1234-ns ../data/cv/C-ns.mat 800,800 grbm

# THEANO_FLAGS="device=cuda0" python cnn.py ../data/cv/ JK-1234-ns ../data/cv/C-ns.mat

# THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JK-1234-ns ../data/cv/C-ns.mat 24 800

script log/log-mlp-JK-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JK-1234-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKU-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKU-1234-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKUR-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKUR-1234-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKURB-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKURB-1234-ns ../data/cv/C-ns.mat 800,800"

script log/log-dbn-JK-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JK-1234-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKU-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKU-1234-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKUR-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKUR-1234-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKURB-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKURB-1234-ns ../data/cv/C-ns.mat 800,800 grbm"

script log/log-blstm-JK-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JK-1234-ns ../data/cv/C-ns.mat 252 800"
script log/log-blstm-JKU-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKU-1234-ns ../data/cv/C-ns.mat 252 800"
script log/log-blstm-JKUR-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKUR-1234-ns ../data/cv/C-ns.mat 252 800"
script log/log-blstm-JKURB-1234-ns.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKURB-1234-ns ../data/cv/C-ns.mat 252 800"