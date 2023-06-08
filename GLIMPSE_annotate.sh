#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH -o annotate-%j.out
#SBATCH -e annotate-%j.err
#SBATCH --mail-user=devorah.stucki@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=kingspeak

BAM=$1
BASENAME=$(basename "$BAM")
SAMPLE="${BASENAME%.*}"
INDIR=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_ligate/$SAMPLE
OUTDIR=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_annotate/$SAMPLE

mkdir $OUTDIR

LST=$OUTDIR/vcflist.txt
#ls -1v $INDIR/*.vcf > ${LST}

while read -r line; do
	BASENAME=$(basename "$line")
	vcfName="${BASENAME%.*}"
	VCF=$INDIR/$vcfName.vcf

	bcftools view -O z -o $INDIR/$vcfName.vcf.gz $VCF

	VCF=$INDIR/$vcfName.vcf.gz

	bcftools index $VCF

	# Decompose and Normalize the vcf
	/uufs/chpc.utah.edu/common/home/u1311353/manipulate_VCF/Bcftools/Normalize/decomposeNormalize_GRCh38.sh $VCF $OUTDIR
	VCF=$OUTDIR/${vcfName}_decomposed_normalized.vcf.gz

	# Annotate VCF
	/uufs/chpc.utah.edu/common/home/pezzolesi-group1/Standard_Scripts/Annotation/standardAnnotation_VCFs_hg38.sh $VCF

done < $LST 


