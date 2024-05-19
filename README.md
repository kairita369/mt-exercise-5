# MT Exercise 5: Byte Pair Encoding, Beam Search
This repository is a starting point for the 5th and final exercise. As before, fork this repo to your own account and the clone it into your prefered directory.

## Requirements

- This only works on a Unix-like system, with bash available.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

## Steps

Clone your fork of this repository in the desired place:

    git clone https://github.com/[your-name]/mt-exercise-5

Create a new virtualenv that uses Python 3.10. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software as described in the exercise pdf.

Download data:

    ./download_iwslt_2017_data.sh
    
Before executing any further steps, you need to make the modifications described in the exercise pdf.

Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate a trained model with

    ./scripts/evaluate.sh

# Part 1
## Results

Here are the BLEU scores for each configuration. In (c), I tried vocaublary_size=4000. You can find the analysis of translation qualities in the pdf report.

| Configuration | Use BPE | Vocabulary Size | BLEU   |
|---------------|---------|-----------------|--------|
| (a)           | No      | 2000            | 11.7   |
| (b)           | Yes     | 2000            | 18.7   |
| (c)           | Yes     | 4000            | 19.5   |

## Changes
1. I chose the translation dircetion en to it. I created a new folder data2 manually, then created a script called scripts/truncate_data.sh to copy the files train.en-it.en, train.en-it.it, test.en-it.en, test.en-it.it, dev.en-it.en and dev.en-it.it into data2 folder, also truncating them to include the only first 10000 lines. Then I manually renamed the files to remove the "en-it" part.


        bash scripts/truncate_data.sh train.en-it.en train.en-it.it 100000       # 10000 is first 10000 lines to take in the files
   

3. Multiple config files: I created a separate config file per experiment: configs/word_level_model_moses.yaml, configs/bpe_model_2000.yaml and configs/bpe_model_4000.yaml. I set the flags in the configs files as told in the assignment sheet, for example for the bpe models, I comment out voc_limit: 2000 and use voc_file : "data2/bpe_vocab2000.it". But for the word_level_model I use voc_limit: 2000.


        bash ./scripts/train.sh


4. Running BPE to get joint vocab and code files: I created a script (scripts/run_bpe.sh) that runs learn-bpe from subword-nmt library on both train files, and then runs apply-bpe on the two train files. It creates these files: data2/code20000.bpe, bpe_vocab2000.en and bpe_vocab2000.it. Running example:


         bash scripts/run_bpe.sh 4000   # 4000 vocabulary size


5. After running the training on the three models on google colab GPUs (changed the same things as in Assignment 4 for running on GPU), I use the scripts/evaluate.sh to get the BLEU scores.


        bash ./scripts/evaluate.sh

# Part 2
## Changes
1. I edited the scripts/evaluate.sh to take beam_size as input (default value is 5 to ensure compatibility with the Part1), open and change the beam size in the config file using "sed" command and regex, and then run translations using the changed config file and evaluate them. Running example:


        bash ./scripts/evaluate.sh 9      # where 9 is the beam size to try


2. I created a new script scripts/plot_bleu_beam_sizes.py that plots a line plot. Running:


        python ./scripts/plot_bleu_beam_sizes.py
