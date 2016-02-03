# ch = chromagram matrix
# ns = note salience matrix

# if data can be save with scipy.io(sio), do it, otherwise use h5py
# (basically for all cell matrix data suffixed with 'ns', use h5py, suffixed with 'ch', use sio

# Tips:
# - control the size of the experiments
# - control the variance of hyperparameters of each different experiment (for comparison sake)
# - do experiments in a scientific way
# - use paper writing to drive experiments
# - use ipython notebook to keep track of experiments
# - compare between various NN approaches
# - compare NN approaches with SVM approaches
# - Run an end-to-end pass everytime (link the output of NN to the ACE system)
# - Be patient
# - to autoreload in ipython
# %load_ext autoreload
# %autoreload 2

# *****************************************************
# For -ch datasets:
# *****************************************************
# (* = optional)
###parametric and non-parametric###
# Models1:
    # - J6seg-inv-mlp-ch
    # - J6seg-inv-dbn-ch
	# - B6seg-inv-mlp-ch
	# - B6seg-inv-dbn-ch   
# Models2:
	# - J6seg-inv-lstm-ch
    # - Jvarlen-inv-lstm-ch(*)
	# - Jsong-inv-ctc-ch
	# - B6seg-inv-lstm-ch
    # - Bvarlen-inv-lstm-ch(*)
	# - Bsong-inv-ctc-ch
# Models3:
    # - J6seg-inv-svm-ch
    # - J6seg-inv-knn-ch
    # - B6seg-inv-svm-ch
    # - B6seg-inv-knn-ch
# Models4:
    # - J6seg-noinv-mlp-ch
    # - J6seg-noinv-dbn-ch
    # - B6seg-noinv-mlp-ch
    # - B6seg-noinv-dbn-ch
# Models5:
	# - J6seg-noinv-lstm-ch
    # - Jvarlen-noinv-lstm-ch(*)
	# - Jsong-noinv-ctc-ch
	# - B6seg-noinv-lstm-ch
    # - Bvarlen-noinv-lstm-ch(*)
	# - Bsong-noinv-ctc-ch
# Models6:
    # - J6seg-noinv-svm-ch
    # - J6seg-noinv-knn-ch
    # - B6seg-noinv-svm-ch
    # - B6seg-noinv-knn-ch
---------------------------------------------------------------------------------------------------------------
# Experiment Group 1: English Pop/Rock - Use TheBeatles180 trained/validated model, tested on Queen19+CarolKing7
# training phase - random holdout 20% validation
# each for 6 times, train the following models
# - B6seg-inv-mlp-ch
# - B6seg-inv-dbn-ch
# - B6seg-inv-lstm-ch
# - B6seg-inv-blstm-ch
# each for 3 times, train the following models
# - B6seg-inv-svm-ch
# - B6seg-inv-knn-ch
# each for 1 time
# - Bsong-inv-ctc-ch

# testing phase - on Queen19+CarolKing7
# run end-to-end experiment and generate results on this combined dataset using the above trained models
# - try to do boosting: combine weaker models to become stronger models and run the above step again
# compare performances with chordino's
'''
running scripts:
-------------------------------------------- inv ---------------------------------------------------
# 6seg
run mlp.py ../data/ch/B6seg-ch-inv.mat ../data/model/mlp-B6seg-ch-inv-[500,500]-i.pkl 500,500

run dbn.py ../data/ch/B6seg-ch-inv.mat ../data/model/dbn-B6seg-ch-inv-[500,500]-i.pkl 500,500 grbm

run lstm.py ../data/ch/B6seg-ch-inv.mat ../data/model/lstm-B6seg-ch-inv-[500]-i matrix 24 500

run blstm.py ../data/ch/B6seg-ch-inv.mat ../data/model/blstm-B6seg-ch-inv-[500]-i matrix 24 500

run knn.py ../data/ch/B6seg-ch-inv.mat ../data/model/knn-B6seg-ch-inv-i.pkl 10 distance

run svm.py ../data/ch/B6seg-ch-inv.mat ../data/model/svm-B6seg-ch-inv-i.pkl

# songwise
run ctc.py ../data/ch/Bsong-ch-inv.pkl ../data/model/ctc-Bsong-ch-inv-i 24 277 500

run bctc.py ../data/ch/Bsong-ch-inv.pkl ../data/model/bctc-Bsong-ch-inv-i 24 277 500

-------------------------------------------- noinv ---------------------------------------------------
# 6seg
run mlp.py ../data/ch/B6seg-ch-noinv.mat ../data/model/mlp-B6seg-ch-noinv-[500,500]-i.pkl 500,500

run dbn.py ../data/ch/B6seg-ch-noinv.mat ../data/model/dbn-B6seg-ch-noinv-[500,500]-i.pkl 500,500 grbm

run lstm.py ../data/ch/B6seg-ch-noinv.mat ../data/model/lstm-B6seg-ch-noinv-[500]-i matrix 24 500

run blstm.py ../data/ch/B6seg-ch-noinv.mat ../data/model/blstm-B6seg-ch-noinv-[500]-i matrix 24 500

run knn.py ../data/ch/B6seg-ch-noinv.mat ../data/model/knn-B6seg-ch-noinv-i.pkl 10 distance

run svm.py ../data/ch/B6seg-ch-noinv.mat ../data/model/svm-B6seg-ch-noinv-i.pkl

# songwise
run ctc.py ../data/ch/Bsong-ch-noinv.pkl ../data/model/ctc-Bsong-ch-noinv-i 24 61 500

run bctc.py ../data/ch/Bsong-ch-noinv.pkl ../data/model/bctc-Bsong-ch-noinv-i 24 61 500
'''
---------------------------------------------------------------------------------------------------------------
# Experiment Group 2: Chinese Pop - Use JayChou29 trained/validated model, tested on cnpop-others
# training phase - random holdout 20% validation
# each for 6 times, train the following models
# - J6seg-inv-mlp-ch
# - J6seg-inv-dbn-ch
# - J6seg-inv-lstm-ch
# - J6seg-inv-blstm-ch
# each for 3 times, train the following models
# - J6seg-inv-svm-ch
# - J6seg-inv-knn-ch
# each for 1 time
# - Jsong-inv-ctc-ch

# testing phase - on cnpop-others
# - run end-to-end experiment and generate results on this combined dataset using the above trained models
# - try to do boosting: combine weaker models to become stronger models and run the above step again
# - compare performances with chordino's
'''
running scripts:
-------------------------------------------- inv ---------------------------------------------------
# 6seg
run mlp.py ../data/ch/J6seg-ch-inv.mat ../data/model/mlp-J6seg-ch-inv-[500,500]-i.pkl 500,500

run dbn.py ../data/ch/J6seg-ch-inv.mat ../data/model/dbn-J6seg-ch-inv-[500,500]-i.pkl 500,500 grbm

run lstm.py ../data/ch/J6seg-ch-inv.mat ../data/model/lstm-J6seg-ch-inv-[500]-i matrix 24 500

run blstm.py ../data/ch/J6seg-ch-inv.mat ../data/model/blstm-J6seg-ch-inv-[500]-i matrix 24 500

run knn.py ../data/ch/J6seg-ch-inv.mat ../data/model/knn-J6seg-ch-inv-i.pkl 10 distance

run svm.py ../data/ch/J6seg-ch-inv.mat ../data/model/svm-J6seg-ch-inv-i.pkl

# songwise
run ctc.py ../data/ch/Jsong-ch-inv.pkl ../data/model/ctc-Jsong-ch-inv-i 24 277 500

run bctc.py ../data/ch/Jsong-ch-inv.pkl ../data/model/bctc-Jsong-ch-inv-i 24 277 500

-------------------------------------------- noinv ---------------------------------------------------
# 6seg
run mlp.py ../data/ch/J6seg-ch-noinv.mat ../data/model/mlp-J6seg-ch-noinv-[500,500]-i.pkl 500,500

run dbn.py ../data/ch/J6seg-ch-noinv.mat ../data/model/dbn-J6seg-ch-noinv-[500,500]-i.pkl 500,500 grbm

run lstm.py ../data/ch/J6seg-ch-noinv.mat ../data/model/lstm-J6seg-ch-noinv-[500]-i matrix 24 500

run blstm.py ../data/ch/J6seg-ch-noinv.mat ../data/model/blstm-J6seg-ch-noinv-[500]-i matrix 24 500

run knn.py ../data/ch/J6seg-ch-noinv.mat ../data/model/knn-J6seg-ch-noinv-i.pkl 10 distance

run svm.py ../data/ch/J6seg-ch-noinv.mat ../data/model/svm-J6seg-ch-noinv-i.pkl

# songwise
run ctc.py ../data/ch/Jsong-ch-noinv.pkl ../data/model/ctc-Jsong-ch-noinv-i 24 61 500

run bctc.py ../data/ch/Jsong-ch-noinv.pkl ../data/model/bctc-Jsong-ch-noinv-i 24 61 500
'''
---------------------------------------------------------------------------------------------------------------
# *****************************************************
# For -ns datasets:
# *****************************************************

# do the same on the -ns dataset
---------------------------------------------------------------------------------------------------------------
# perform end-to-end test on matlab
# - save intermediate results first to save time
# - generate results and evaluations using the same old excel form
# - do some subjective test on the results
'''
predict scripts:
python nn/predict.py ./data/temp/X.mat ./data/model/mlp-J6seg-ch-inv-1000.pkl mlp inv
'''

'''
- PhD thesis outline (index)
Title: deep learning approaches towards automatic chord estimation and its novel application to algorithmic improvisation and music genre classification
(* = optional)
- introduction
    - automatic chord estimation(ACE) problem definition
    - motivation and applications of ACE
    - thesis contribution preview
    - publications of the author
- background knowledge and related work
    - music theory on chord
    - chord estimation practice by human
    - related traditional approaches towards ACE
    - related modern approaches towards ACE
    - ACE evaluation metrics (MIREX)
- ACE system architecture
    - overall architecture
    - audio feature - from waveform to chromagram
    - chord progression probilistic model
    - baseline approach - Gaussian model
- parametric approaches towards ACE
    - deep neural network (contribution of this thesis)
    - recurrent neural network (contribution of this thesis)
- non-parametric approaches towards ACE
    - support vector machine (contribution of this thesis)
    - k-NN (k-nearest-neighbour)
- an ensemble approach (bagging, boosting...)
- evaluation results of the proposed approaches
    - results
    - comparisons
    - discussions
- ACE applications
    - ACE application to algorithmic improvisation (*) (contribution of this thesis)
        - algorithmic improvisation platform (refer to WIJAM and ArmKeyBoard work)
        - ACE application to algorithmic improvisation
        - subjective evaluations
    - ACE application to music genre classification (*) (contribution of this thesis)
        - music genre classification overview (refer to SAfeDJ work)
        - experiment setup
        - experiment result
- conclusion

- Appendix
    - datasets
        - TheBeatles180 dataset
        - JayChou29 dataset
    - generation process of training data
    - chord types table
    
- Bibliography

'''
# - Complete the ACE system, choose the best one as a basis for the following tasks (An ACE system based on Deep Learning)
#       ####submit to TASLP####
#       ####submit to ISMIR####

# - Link the ACE system to NIME (to solo over chords, do some simple experiments under the framework of WIJAM and ArmKeyBoard, probably the easier ArmKeyBoard is better for such experiment) turn the automatic chord estimation to automatic scale or chord-scale estimation (should be easy!!!)
#       ####submit to CMJ####

# - Link the ACE system to Music Recommendation/Classification(e.g. to tell between one artist to another(say J and B), do some simple experiments given the ACE results and use DL to classify, comparing with using ground-truth data to classify) (should be easy!!)
#       ####submit to JNMR####

# - Link all the works together to form a solid PhD thesis
#       ####PhD thesis####