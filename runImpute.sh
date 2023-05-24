#!/bin/bash

while read -r line; do
	BAM="$line"
	sbatch GLIMPSE_GPfilter.sh $BAM
done < "bamlist.txt"
