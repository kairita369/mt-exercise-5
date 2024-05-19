#! /bin/bash

beam_size=${1:-5}

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data2
configs=$base/configs

translations=$base/translations

mkdir -p $translations

src=en
trg=it


num_threads=4
device=0

# measure time

SECONDS=0

model_name=bpe_model_4000

echo "###############################################################################"
echo "model_name $model_name"

translations_sub=$translations/$model_name

mkdir -p $translations_sub

# change the beam+size in config file
sed -E "s/(\s\s\s\sbeam_size: )[0-9]+/\1$beam_size/g" configs/$model_name.yaml >  configs/$model_name.tmp.yaml

CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt translate $configs/$model_name.tmp.yaml < $data/test.$src > $translations_sub/test.$model_name.$trg.$beam_size

# compute case-sensitive BLEU 

cat $translations_sub/test.$model_name.$trg.$beam_size | sacrebleu $data/test.$trg


echo "time taken:"
echo "$SECONDS seconds"
