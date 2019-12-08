#!/usr/bin/env bash
set -xv

 Preparing folder for the run
sh script/preparingWorkspace.sh

# Preparing Data
# Step 1 - the Task Grammar
# prompts -> lower case
python script/python_script/lowerPrompts.py datasets/train/transkrip.lab txt/transkrip_test.lab

# prompts -> wlist
perl script/perl_script/prompts2wlist.pl txt/transkrip_test.lab txt/wlist.lab

# gram.txt
python script/python_script/wlistToGram.py txt/wlist.lab txt/gram.lab

# wdnet.txt
htk/HParse txt/gram.lab txt/wdnet.lab

# Step 2 - the Dictionary
# srcDict
python script/python_script/splitWord.py txt/wlist.lab txt/srcDict_t.lab
perl script/perl_script/sort.pl txt/srcDict_t.lab txt/srcDict.lab

# HTK Dict & monophones
htk/HDMan -m -w txt/wlist.lab -n phones/monophones -l txt/dict_log.txt txt/dict.txt txt/srcDict.lab

# Other monophoes
perl script/perl_script/mkMonophones.pl phones/monophones phones/monophones0 phones/monophones1

# Step 3 - Recording the Data
# self recording

# Step 4 - Creating the Transcription Files
# MLF words
perl script/perl_script/prompts2mlf.pl mlf/words.mlf txt/transkrip_test.lab

# MLF phones
#(disini akan ketahuan mana aja kata-kata yang ga ada di wlist dan dict, jadi harus crosscheck sampe bener)
#(ERROR [+6550]  LoadHTKLabels: Junk at end of HTK transcription ->  hapus spasi 1 line )
#(ERROR [+6550]  LoadHTKList: Label Name Expected -> ini karena ada yang angka)
#(ERROR [+1232]  NumParts: Cannot find word %s in dictionary -> crosscheck sampe bener)
htk/HLEd -l '*' -d txt/dict.txt -i mlf/phones0.mlf ins/mkphones0.led mlf/words.mlf
htk/HLEd -l "*" -d txt/dict.txt -i mlf/phones1.mlf ins/mkphones1.led mlf/words.mlf

# Step 5 - Coding the Data
# Generating training file list
python script/python_script/listwavmfc.py datasets/train/waves/ txt/train.scp txt/train_mfc.scp

# Feature extraction
htk/HCopy -C config/HCopy.cfg -S txt/train.scp

python script/python_script/sanitizer.py


echo "Preparing completed"
