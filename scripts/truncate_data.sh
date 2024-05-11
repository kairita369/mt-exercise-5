#!/bin/bash

# Check if correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <file1> <file2> <lines>"
    exit 1
fi

# Extract inputs
file1="$1"
file2="$2"
lines="$3"

scripts=$(dirname "$0")
base=$scripts/..

data_dir=$base/data
output_dir=$base/data2

# Check if files exist
if [ ! -f "$output_dir/$file1" ] || [ ! -f "$output_dir/$file2" ]; then
    echo "One or both input files do not exist."
    exit 1
fi

# Take first 'lines' lines from each file and save to new files
head -n "$lines" "data_dir/$file1" | tee "$output_dir/${file1}"
head -n "$lines" "data_dir/$file2" | tee "$output_dir/${file2}"

echo "Extraction complete."
