# Description:
This is an [Automatic Chord Estimation] (http://www.music-ir.org/mirex/wiki/2015:Audio_Chord_Estimation) System.

Automatic chord estimation, or ACE, within this context, refers to a task that estimates, recognizes, or transcribes the segmented chord sequence from a piece of audio under equal-temperament tonal music constraint.

The code here exactly implements the systems in Chapter 3 and 4 of my [PhD thesis](https://github.com/tangkk/phd-thesis-junqi-deng/blob/master/junqi-thesis-hku.pdf):
Deng, J., Large Vocabulary Automatic Chord Estimation from Audio Using Deep Learning Approaches. PhD thesis, Department of Electrical and Electronic Engineering, The University of Hong Kong, 2016


# Author:
Junqi Deng, The University of Hong Kong

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
where the first parameter specifies the parameter initialization (in this case SeventhsBass configuration); the second parameter specifies the test list; the third specifies the "mode" (whether it is a segment-tiling approach, or a fully RNN approach); the fourth is the pre-extracted feature; and the fifth is the NN model used.


Please find all the bubs and neural network models needed to run the systems [here](http://tangkk.net/me/model/ace/). The 'bubs' are the already extracted audio features.

# Publications:
@inproceedings{deng2016hybrid,
  title={A Hybrid Gaussian-HMM-Deep-Learning Approach For Automatic Chord Estimation With Very Large Vocabulary},
  author={Deng, Junqi and Kwok, Yu-Kwong},
  booktitle={ISMIR},
  year={2016}
}

@inproceedings{deng2016large,
  title={Large Vocabulary Automatic Chord Estimation with Even Chance Training Scheme},
  author={Deng, Junqi and Kwok, Yu-Kwong},
  booktitle={ISMIR},
  year={2017}
}

# License:
This software is under BSD License. For commercial use of this software, please contact the author.
