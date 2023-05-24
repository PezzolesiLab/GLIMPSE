#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH -o phase-%j.out
#SBATCH -e phase-%j.err
#SBATCH --mail-user=devorah.stucki@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=notchpeak

BAM=$1
BASENAME=$(basename "$BAM")
SAMPLE="${BASENAME%.*}"
OUT=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_impute/$SAMPLE/

mkdir $OUT

for CHR in {1..22}
do
	REF=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/split_reference/1000GP.chr$CHR
	CHUNK=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/chunks/chunks.chr$CHR.txt

	while IFS="" read -r LINE || [ -n "$LINE" ];
	do
        	printf -v ID "%02d" $(echo $LINE | cut -d" " -f1)
        	IRG=$(echo $LINE | cut -d" " -f3)
        	ORG=$(echo $LINE | cut -d" " -f4)
        	CHR=$(echo ${LINE} | cut -d" " -f2)
        	REGS=$(echo ${IRG} | cut -d":" -f 2 | cut -d"-" -f1)
        	REGE=$(echo ${IRG} | cut -d":" -f 2 | cut -d"-" -f2)
        
		~/software/GLIMPSE2_phase_static --bam-file ${BAM} --reference ${REF}_${CHR}_${REGS}_${REGE}.bin --output ${OUT}${CHR}_${REGS}_${REGE}.bcf --threads $SLURM_CPUS_ON_NODE
	done < $CHUNK
done
