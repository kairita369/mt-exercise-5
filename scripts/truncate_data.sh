#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <file1> <file2> <lines>"
    exit 1
fi

file1="$1"
file2="$2"
lines="$3"

scripts=$(dirname "$0")
base=$scripts/..

data_dir=$base/data
output_dir=$base/data2

if [ ! -f "$output_dir/$file1" ] || [ ! -f "$output_dir/$file2" ]; then
    echo "One or both input files do not exist."
    exit 1
fi

head -n "$lines" "data_dir/$file1" | tee "$output_dir/${file1}"
head -n "$lines" "data_dir/$file2" | tee "$output_dir/${file2}"

echo "Extraction complete."
