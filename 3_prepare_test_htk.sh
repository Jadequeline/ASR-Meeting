#!/usr/bin/env bash
set -xv

# Recognizer Evaluation
# Step 11 - Recognizing the Test Data
python script/python_script/generatePrompts.py datasets/eval/waves/ datasets/eval/prompts.txt
perl script/perl_script/prompts2mlf.pl mlf/eval_words.mlf txt/eval_prompts.txt

# Evaluation file list
python script/python_script/listwavmfc.py datasets/eval/waves/ txt/eval.scp txt/eval_mfc.scp

# Evaluation MLF
htk/HCopy -C config/HCopy.cfg -S txt/eval.scp