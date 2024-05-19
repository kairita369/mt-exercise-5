#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <num_features>"
  exit 1
fi

num_features=$1

cat data2/train.en data2/train.it | subword-nmt learn-bpe -s ${num_features} -o data2/code${num_features}.bpe

# inputs> it and en, train/val/test data paths, path to data folder for the outputs, vocabbulary_threshold
subword-nmt apply-bpe -c data2/code${num_features}.bpe < data2/train.en | subword-nmt get-vocab > data2/bpe_vocab${num_features}.en
subword-nmt apply-bpe -c data2/code${num_features}.bpe < data2/train.it | subword-nmt get-vocab > data2/bpe_vocab${num_features}.it

# remove the numbers at each row
sed -i -E 's/\s[0-9]+//g' data2/bpe_vocab4000.en
sed -i -E 's/\s[0-9]+//g' data2/bpe_vocab4000.it

# subword-nmt apply-bpe -c data2/code${num_features}.bpe --vocabulary data2/bpe_vocab${num_features}.en --vocabulary-threshold 2000 < data2/train.en > data2/train.BPE.en
# subword-nmt apply-bpe -c data2/code${num_features}.bpe --vocabulary data2/bpe_vocab${num_features}.it --vocabulary-threshold 2000 < data2/train.it > data2/train.BPE.it
