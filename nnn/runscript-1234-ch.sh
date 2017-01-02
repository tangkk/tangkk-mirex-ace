# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions
# such as: script runlog-1234.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JK-1234-ch ../data/cv/C-ch.mat 800,800"

# examples runs:

# THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JK-1234-ch ../data/cv/C-ch.mat 800,800

# THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JK-1234-ch ../data/cv/C-ch.mat 800,800 grbm

# THEANO_FLAGS="device=cuda0" python cnn.py ../data/cv/ JK-1234-ch ../data/cv/C-ch.mat

# THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JK-1234-ch ../data/cv/C-ch.mat 24 800

script log-mlp-JK-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JK-1234-ch ../data/cv/C-ch.mat 800,800"
script log-mlp-JKU-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKU-1234-ch ../data/cv/C-ch.mat 800,800"
script log-mlp-JKUR-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKUR-1234-ch ../data/cv/C-ch.mat 800,800"
script log-mlp-JKURB-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python mlp.py ../data/cv/ JKURB-1234-ch ../data/cv/C-ch.mat 800,800"

script log-dbn-JK-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JK-1234-ch ../data/cv/C-ch.mat 800,800 grbm"
script log-dbn-JKU-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKU-1234-ch ../data/cv/C-ch.mat 800,800 grbm"
script log-dbn-JKUR-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKUR-1234-ch ../data/cv/C-ch.mat 800,800 grbm"
script log-dbn-JKURB-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python dbn.py ../data/cv/ JKURB-1234-ch ../data/cv/C-ch.mat 800,800 grbm"

script log-blstm-JK-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JK-1234-ch ../data/cv/C-ch.mat 24 800"
script log-blstm-JKU-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKU-1234-ch ../data/cv/C-ch.mat 24 800"
script log-blstm-JKUR-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKUR-1234-ch ../data/cv/C-ch.mat 24 800"
script log-blstm-JKURB-1234-ch.txt -c "THEANO_FLAGS="device=cuda0" python blstm.py ../data/cv/ JKURB-1234-ch ../data/cv/C-ch.mat 24 800"



#cv holdout sets:
    
#JK-1234-ch
#JK-1235-ch
#JK-1245-ch
#JK-1345-ch
#JK-2345-ch

#JKU-1234-ch
#JKU-1235-ch
#JKU-1245-ch
#JKU-1345-ch
#JKU-2345-ch

#JKUR-1234-ch
#JKUR-1235-ch
#JKUR-1245-ch
#JKUR-1345-ch
#JKUR-2345-ch

#JKUB-1234-ch
#JKUB-1235-ch
#JKUB-1245-ch
#JKUB-1345-ch
#JKUB-2345-ch

#JK-1234-ns
#JK-1235-ns
#JK-1245-ns
#JK-1345-ns
#JK-2345-ns

#JKU-1234-ns
#JKU-1235-ns
#JKU-1245-ns
#JKU-1345-ns
#JKU-2345-ns

#JKUR-1234-ns
#JKUR-1235-ns
#JKUR-1245-ns
#JKUR-1345-ns
#JKUR-2345-ns

#JKUB-1234-ns
#JKUB-1235-ns
#JKUB-1245-ns
#JKUB-1345-ns
#JKUB-2345-ns