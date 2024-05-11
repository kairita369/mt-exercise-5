cat data2/train.en data2/train.it | subword-nmt learn-bpe -s 2000 -o data2/code2000.bpe

# inputs> it and en, train/val/test data paths, path to data folder for the outputs, vocabbulary_threshold
subword-nmt apply-bpe -c data2/code2000.bpe < data2/train.en | subword-nmt get-vocab > bpe_vocab2000.en
subword-nmt apply-bpe -c data2/code2000.bpe < data2/train.it | subword-nmt get-vocab > bpe_vocab2000.it

subword-nmt apply-bpe -c data2/code2000.bpe --vocabulary data2/bpe_vocab2000.en --vocabulary-threshold 2000 < data2/train.en > data2/train.BPE.en
subword-nmt apply-bpe -c data2/code2000.bpe --vocabulary data2/bpe_vocab2000.it --vocabulary-threshold 2000 < data2/train.it > data2/train.BPE.it
