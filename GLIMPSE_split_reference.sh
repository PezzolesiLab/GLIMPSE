#!/bin/bash

#SBATCH --time=06:00:00
#SBATCH --nodes=1
#SBATCH -o splitref-%j.out
#SBATCH -e splitref-%j.err
#SBATCH --mail-user=devorah.stucki@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi-np
#SBATCH --partition=pezzolesi-np

for CHR in {1..22}
do
	REF=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/resources/1000Genomes/1000GP.chr$CHR.bcf
	MAP=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/resources/1000Genomes/genetic_maps.b38/chr$CHR.b38.gmap.gz
	CHUNK=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/chunks/chunks.chr$CHR.txt
	OUT=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/split_reference/1000GP.chr$CHR

	while IFS="" read -r LINE || [ -n "$LINE" ];
	do
        	printf -v ID "%02d" $(echo $LINE | cut -d" " -f1)
        	IRG=$(echo $LINE | cut -d" " -f3)
        	ORG=$(echo $LINE | cut -d" " -f4)

        	~/software/GLIMPSE2_split_reference_static --reference ${REF} --map ${MAP} --input-region ${IRG} --output-region ${ORG} --output ${OUT}
	done < $CHUNK
done
