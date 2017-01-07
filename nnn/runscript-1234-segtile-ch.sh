# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions
# such as: script runlog-1234.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JK-1234-ch-1seg ../data/cv/C-ch-1seg.mat 800,800"

# examples runs:

# THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JK-1234-ch-1seg ../data/cv/C-ch-1seg.mat 800,800

# THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JK-1234-ch-1seg ../data/cv/C-ch-1seg.mat 800,800 grbm

# THEANO_FLAGS="device=cuda0" python cnn.py ../data/cv/ JK-1234-ch-1seg ../data/cv/C-ch-1seg.mat

# THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JK-1234-ch-1seg ../data/cv/C-ch-1seg.mat 24 800

script log/log-mlp-JKU-1234-ch-1seg.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKU-1234-ch-1seg ../data/cv/C-ch-1seg.mat 800,800"

script log/log-dbn-JKU-1234-ch-1seg.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKU-1234-ch-1seg ../data/cv/C-ch-1seg.mat 800,800 grbm"

script log/log-blstm-JKU-1234-ch-1seg.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKU-1234-ch-1seg ../data/cv/C-ch-1seg.mat 24 800"


script log/log-mlp-JKU-1234-ch-2seg.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKU-1234-ch-2seg ../data/cv/C-ch-2seg.mat 800,800"

script log/log-dbn-JKU-1234-ch-2seg.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKU-1234-ch-2seg ../data/cv/C-ch-2seg.mat 800,800 grbm"

script log/log-blstm-JKU-1234-ch-2seg.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKU-1234-ch-2seg ../data/cv/C-ch-2seg.mat 24 800"


script log/log-mlp-JKU-1234-ch-3seg.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKU-1234-ch-3seg ../data/cv/C-ch-3seg.mat 800,800"

script log/log-dbn-JKU-1234-ch-3seg.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKU-1234-ch-3seg ../data/cv/C-ch-3seg.mat 800,800 grbm"

script log/log-blstm-JKU-1234-ch-3seg.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKU-1234-ch-3seg ../data/cv/C-ch-3seg.mat 24 800"


script log/log-mlp-JKU-1234-ch-9seg.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKU-1234-ch-9seg ../data/cv/C-ch-9seg.mat 800,800"

script log/log-dbn-JKU-1234-ch-9seg.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKU-1234-ch-9seg ../data/cv/C-ch-9seg.mat 800,800 grbm"

script log/log-blstm-JKU-1234-ch-9seg.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKU-1234-ch-9seg ../data/cv/C-ch-9seg.mat 24 800"


script log/log-mlp-JKU-1234-ch-12seg.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKU-1234-ch-12seg ../data/cv/C-ch-12seg.mat 800,800"

script log/log-dbn-JKU-1234-ch-12seg.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKU-1234-ch-12seg ../data/cv/C-ch-12seg.mat 800,800 grbm"

script log/log-blstm-JKU-1234-ch-12seg.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKU-1234-ch-12seg ../data/cv/C-ch-12seg.mat 24 800"