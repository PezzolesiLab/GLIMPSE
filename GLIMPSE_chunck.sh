#!/bin/bash

#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH -o chunk-%j.out
#SBATCH -e chunk-%j.err
#SBATCH --mail-user=devorah.stucki@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi-np
#SBATCH --partition=pezzolesi-np

for CHR in {1..22}
do
	MAP=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/resources/1000Genomes/genetic_maps.b38/chr$CHR.b38.gmap.gz
	SITES=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/resources/1000Genomes/1000GP.chr$CHR.sites.vcf.gz
	OUT=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/chunks/chunks.chr$CHR.txt
	REGION=chr$CHR
	~/software/GLIMPSE2_chunk_static --input ${SITES} --region ${REGION} --sequential --output ${OUT} --map ${MAP}
done
