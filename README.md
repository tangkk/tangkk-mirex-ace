# Description:
This is an [Automatic Chord Estimation](http://www.music-ir.org/mirex/wiki/2016:Audio_Chord_Estimation) System.

Automatic chord estimation, or ACE, within this context, refers to a task that estimates, recognizes, or transcribes the segmented chord sequence from a piece of audio under equal-temperament tonal music constraint.

The code here exactly implements the systems in Chapter 3 and 4 of my [PhD thesis](https://github.com/tangkk/phd-thesis-junqi-deng/blob/master/junqi-thesis-hku.pdf).


# Author:
[Junqi Deng](http://www.tangkk.net/), [The University of Hong Kong](http://www.hku.hk/)

# System Environment:
- MATLAB R2015a or later
- Python 2.7 with Numpy and Theano installed
- Run the system on Windows if possible

# How to Run:
Open the runscript.m file to see all possible ways to run the system in Matlab shell. For example, for the baseline approach, run:
```
tangkkace('Chordino','tempList.txt','0','0','0');
```

For cross-valiation score, you could run for example:
```
tangkkace_cv('mlp-JKU-ch-6seg-800,800','get');
```

For simple chord estimation output, you could run for example:
```
tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800]-1.npz');
```
where the first parameter specifies the parameter initialization (in this case SeventhsBass configuration); the second parameter specifies the test list; the third specifies the "mode" (whether it is a segment-tiling approach, or a fully RNN approach); the fourth specifies the pre-extracted feature (bub); and the fifth specifies the neural network.

# The modes
3 -> RNN sequence decoder with chromgram as input feature
4 -> RNN sequence decoder with notegram as input feature
2 -> Hybrid Gaussian-HMM-DNN approach with chromagram as input feature
6 -> Hybrid Gaussian-HMM-DNN approach with notegram as input feature

others models are also useable but not discussed in the thesis.

# BUBs and models
The BUBs are extracted by specifying the "mode" to be -2(for notegram) or -1(for chromagram).

The models are trained using the scripts provided in the ./nn and ./nnn folders. You could perfectly repeat all the experiments if you have access to all the original audios and ground-truth labels. If you are interested in these contents, please contact me directly.

# Pretrained models
Please find all the bubs and neural network models needed to run the systems [here](http://tangkk.net/me/model/ace/). The 'bubs' are the pre-extracted audio features. The models are exactly those used to derive the thesis.

# Publications:
Deng, J., Kwok, Y. K., Large Vocabulary Automatic Chord Estimation with an Even Chance Training Scheme, In Proceedings of the 18th International Society for Music Information Retrieval Conference, Suzhou, China, 2017 (ISMIR 2017)

Deng, J., Large Vocabulary Automatic Chord Estimation from Audio Using Deep Learning Approaches. PhD thesis, Department of Electrical and Electronic Engineering, The University of Hong Kong, 2016

Deng, J., Kwok, Y. K., A Hybrid Gaussian-HMM and Deep Learning Approach For SeventhsBass Automatic Chord Estimation, In Proceedings of the 17th International Society for Music Information Retrieval Conference, 2016 (ISMIR 2016)

# License:
This software is under BSD License.
