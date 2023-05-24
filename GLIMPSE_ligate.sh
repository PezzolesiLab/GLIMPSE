#!/bin/bash

#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH -o ligate-%j.out
#SBATCH -e ligate-%j.err
#SBATCH --mail-user=devorah.stucki@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=notchpeak

BAM=$1
BASENAME=$(basename "$BAM")
SAMPLE="${BASENAME%.*}"
OUTDIR=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_ligate/$SAMPLE
INDIR=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_impute/$SAMPLE

mkdir $OUTDIR

for CHR in {1..22}
do
	LST=$OUTDIR/list.chr$CHR.txt
	ls -1v $INDIR/chr${CHR}_*.bcf > ${LST}

	~/software/GLIMPSE2_ligate_static --input ${LST} --output $OUTDIR/${SAMPLE}_chr${CHR}_ligated.bcf
	bcftools view $OUTDIR/${SAMPLE}_chr${CHR}_ligated.bcf -o $OUTDIR/${SAMPLE}_chr${CHR}_ligated.vcf
done
