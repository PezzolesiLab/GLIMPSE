#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH -o annotate-%j.out
#SBATCH -e annotate-%j.err
#SBATCH --mail-user=devorah.stucki@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=lonepeak

BAM=$1
BASENAME=$(basename "$BAM")
SAMPLE="${BASENAME%.*}"

# Minimum Genotype Probability (GP) threshold
GP_THRESHOLD=0.95

INDIR=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_ligate/$SAMPLE
OUTDIR=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_filter${GP_THRESHOLD}/$SAMPLE

mkdir -p $OUTDIR

LST=$OUTDIR/vcflist.txt
ls -1v $INDIR/*.vcf > ${LST}

while read -r line; do
	INPUT_VCF=$line

	BASENAME=$(basename "$INPUT_VCF")
	vcfName="${BASENAME%.*}"
	OUTPUT_VCF=$OUTDIR/$vcfName_filter${GP_THRESHOLD}.vcf

	# Filter variants based on GP field
	bcftools view -i 'INFO/GP >= '${GP_THRESHOLD}'' ${INPUT_VCF} -o ${OUTPUT_VCF}
done < $LST

