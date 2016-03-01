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
# models
# *****************************************************
---------------------------------------------------------------------------------------------------------------
# *****************************************************
# For -ch (chromagram level) datasets:
# *****************************************************
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
'''
'''
# songwise
run ctc.py ../data/ch/Jsong-ch-inv.pkl ../data/model/ctc-Jsong-ch-inv-i 24 277 500

run bctc.py ../data/ch/Jsong-ch-inv.pkl ../data/model/bctc-Jsong-ch-inv-i 24 277 500
-------------------------------------------- no7 ---------------------------------------------------
run bctc.py ../data/ch/Jsong-ch-no7.pkl ../data/model/bctc-Jsong-ch-no7-i 24 73 500
-------------------------------------------- noinv ---------------------------------------------------
run bctc.py ../data/ch/Jsong-ch-noinv.pkl ../data/model/bctc-Jsong-ch-noinv-i 24 61 500
'''
---------------------------------------------------------------------------------------------------------------
# *****************************************************
# For -ns datasets (note salience level):
# *****************************************************
---------------------------------------------------------------------------------------------------------------
# Experiment Group 3: Chinese Pop - Use JayChou29 trained/validated model
# training phase - random holdout 20% validation
# each for 6 times, train the following models
# - J6seg-inv-mlp-ns
# - J6seg-inv-dbn-ns
# - J6seg-inv-lstm-ns
# - J6seg-inv-blstm-ns
# each for 3 times, train the following models
# - J6seg-inv-svm-ns
# - J6seg-inv-knn-ns
# each for 1 time
# - Jsong-inv-ctc-ns
'''
running scripts:
-------------------------------------------- inv ---------------------------------------------------
input dimension 252*6 = 1512
# 6seg
run mlp.py ../data/ns/J6seg-ns-inv.mat ../data/model/mlp-J6seg-ns-inv-[800,800]-i.pkl 800,800

run dbn.py ../data/ns/J6seg-ns-inv.mat ../data/model/dbn-J6seg-ns-inv-[800,800]-i.pkl 800,800 grbm

run mlp.py ../data/ns/J6seg-ns-inv.mat ../data/model/mlp-J6seg-ns-inv-[2000,2000]-i.pkl 2000,2000

run dbn.py ../data/ns/J6seg-ns-inv.mat ../data/model/dbn-J6seg-ns-inv-[2000,2000]-i.pkl 2000,2000 grbm

run lstm.py ../data/ns/J6seg-ns-inv.mat ../data/model/lstm-J6seg-ns-inv-[800]-i matrix 252 800

run blstm.py ../data/ns/J6seg-ns-inv.mat ../data/model/blstm-J6seg-ns-inv-[800]-i matrix 252 800


run knn.py ../data/ns/J6seg-ns-inv.mat ../data/model/knn-J6seg-ns-inv-i.pkl 10 distance

run svm.py ../data/ns/J6seg-ns-inv.mat ../data/model/svm-J6seg-ns-inv-i.pkl
'''
'''
# songwise
run ctc.py ../data/ns/Jsong-ns-inv.pkl ../data/model/ctc-Jsong-ns-inv-i 252 277 800
run ctcsg.py ../data/ns/Jsong-ns-inv.pkl ../data/model/ctc-Jsong-ns-inv-ii 252 277 800 500

run bctc.py ../data/ns/Jsong-ns-inv.pkl ../data/model/bctc-Jsong-ns-inv-i 252 277 800
run bctcsg.py ../data/ns/Jsong-ns-inv.pkl ../data/model/bctc-Jsong-ns-inv-ii 252 277 800 500
-------------------------------------------- no7 ---------------------------------------------------
run bctc.py ../data/ns/Jsong-ns-no7.pkl ../data/model/bctc-Jsong-ns-no7-i 252 73 800
-------------------------------------------- noinv ---------------------------------------------------
run bctc.py ../data/ns/Jsong-ns-noinv.pkl ../data/model/bctc-Jsong-ns-noinv-i 252 61 800
'''
---------------------------------------------------------------------------------------------------------------
# *****************************************************
# For -sg datasets (spectrogram level):
# *****************************************************
---------------------------------------------------------------------------------------------------------------
'''
# songwise
run ctcsg.py ../data/sg/Jsong-sg-inv.pkl ../data/model/ctc-Jsong-sg-inv-i 2049 277 5000 800

run bctcsg.py ../data/sg/Jsong-sg-inv.pkl ../data/model/bctc-Jsong-sg-inv-i 2049 277 5000 800
'''
---------------------------------------------------------------------------------------------------------------
# *****************************************************
# For -wf datasets (waveform level):
# *****************************************************
---------------------------------------------------------------------------------------------------------------
'''
# songwise
run ctcwf.py ../data/wf/Jsong-wf-inv.pkl ../data/model/ctc-Jsong-wf-inv-i 1 277 500

run bctcwf.py ../data/wf/Jsong-wf-inv.pkl ../data/model/bctc-Jsong-wf-inv-i 1 277 500
'''
---------------------------------------------------------------------------------------------------------------
# perform end-to-end test on matlab
# - save intermediate results first to save time
# - generate results and evaluations using the same old excel form
# - do some subjective test on the results
---------------------------------------------------------------------------------------------------------------
# predict scripts:
# python nn/predict.py ./data/temp/X.mat ./data/model/mlp-J6seg-ch-inv-1000.pkl mlp inv
---------------------------------------------------------------------------------------------------------------
'''
tentative framework:
(Refrain to use ''we'')

- PhD thesis outline (index)
Title: deep learning approaches towards automatic chord estimation, music mood classification and algorithmic composition

Abstract:
This thesis presents the usage of deep learning approaches towards three problems in both music information retrieval and computer music: automatic chord estimation, music mood classification and algorithmic composition. The main focus is on deep learning based automatic chord estimation, where similar learning structures are extended to form a music mood classification system, where a mood oriented algorithmic composition system is then obtained by reversing the discriminative model to be a generative model.

Concretely, this thesis first considers a unified spectrum of parametric (MLP, DBN, LSTM, BLSTM) and non-parametric (k-NN, SVM) approaches towards automatic chord estimation that support a very large chord vocabulary. At first the baseline approach is similar to chordino, including multiple feature engineering frontend steps and an HMM backend. Then approaches are put forward to try to learn these handcrafted features and transformations from data as much as possible, all the way to an end-to-end recurrent neural network system taking the waveform as input and generating its chord sequence as output. Evaluation on new MIREX standard metrics show that some of these approaches have significant advantage over MIREX state-of-the-art ones in terms of very large chord vocabulary metrics, and comparable to them in other metrics. Besides MIREX dataset, a jazz chord progression dataset with much larger vocabulary is also used to evaluate some of the very strong approaches.

Secondly, a music mood classification system is built using similar but deeper hybrid DBN-(B)LSTM recurrent neural network structure as applied in automatic chord estimation, which supports both generative pretraining and discriminative training. After the model is trained and verified using a combined MIDI dataset of chord and melody, it is turned into a generative model for music composition in terms of chord and melody... (this part is not finished yet, to be decided)


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
    - ACE application to algorithmic composition/improvisation (*) (contribution of this thesis)
        - algorithmic composition platform (refer to WIJAM and ArmKeyBoard work)
        - ACE application to algorithmic composition
        - subjective evaluations
    - ACE application to music mood classification (*) (contribution of this thesis)
        - music mood classification overview (refer to SAfeDJ work)
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