#!/bin/bash

filter=$1

# Iterate through chromosomes 1 to 22
for ((chr=1; chr<=22; chr++)); do
    # Run the command for each chromosome
    sbatch GLIMPSE_merge_filtered.sh $chr $filter
done
