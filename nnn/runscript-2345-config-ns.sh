# use "script [option] [file] ... exit" to keep a log of terminal outputs and all the interactions
# suns as: script runlog-2345.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JK-2345-ns ../data/cv/C-ns.mat 800,800"

script log/log-mlp-JKU-2345-500,500,ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 500,500"
script log/log-mlp-JKU-2345-500,500,500,ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 500,500,500"
script log/log-mlp-JKU-2345-500,500,500,500,ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 500,500,500,500"

script log/log-mlp-JKU-2345-800,800,ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 800,800"
script log/log-mlp-JKU-2345-800,800,800,ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 800,800,800"
script log/log-mlp-JKU-2345-800,800,800,800,ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 800,800,800,800"

script log/log-mlp-JKU-2345-1000,1000,ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 1000,1000"
script log/log-mlp-JKU-2345-1000,1000,1000,ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 1000,1000,1000"
script log/log-mlp-JKU-2345-1000,1000,1000,1000,ns.txt -c "THEANO_FLAGS="device=cuda3" python mlp.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 1000,1000,1000,1000"



script log/log-dbn-JKU-2345-500,500,ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 500,500 grbm"
script log/log-dbn-JKU-2345-500,500,500,ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 500,500,500 grbm"
script log/log-dbn-JKU-2345-500,500,500,500,ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 500,500,500,500 grbm"

script log/log-dbn-JKU-2345-800,800,ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 800,800 grbm"
script log/log-dbn-JKU-2345-800,800,800,ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 800,800,800 grbm"
script log/log-dbn-JKU-2345-800,800,800,800,ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 800,800,800,800 grbm"

script log/log-dbn-JKU-2345-1000,1000,ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 1000,1000 grbm"
script log/log-dbn-JKU-2345-1000,1000,1000,ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 1000,1000,1000 grbm"
script log/log-dbn-JKU-2345-1000,1000,1000,1000,ns.txt -c "THEANO_FLAGS="device=cuda3" python dbn.py ../data/cv/ JKU-2345-ns ../data/cv/C-ns.mat 1000,1000,1000,1000 grbm"