#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH -o merge-%j.out
#SBATCH -e merge-%j.err
#SBATCH --mail-user=devorah.stucki@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=kingspeak

chr=$1
filter=$2

#FIXME: make sure the filter threshold matches
INDIR=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_filter${filter}
OUTDIR=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_merge_filter${filter}
ANNOTATEDIR=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_annotate_filter${filter}

mkdir -p $OUTDIR
mkdir -p $ANNOTATEDIR


NORMVCF=$OUTDIR/ACfilter_missingfilter_fill_tags_BGE_GLIMPSE_filter${filter}_allsamples_chr${chr}_decomposed_normalized.vcf.gz
/uufs/chpc.utah.edu/common/home/u1311353/manipulate_VCF/Annotation/standardAnnotation_VCFs_hg38_updated_gnomad_v.sh $NORMVCF

ANNOTATEVCF=/scratch/general/vast/$USER/ACfilter_missingfilter_fill_tags_BGE_GLIMPSE_allsamples_chr${chr}_decomposed_normalized/ACfilter_missingfilter_fill_tags_BGE_GLIMPSE_filter${filter}_allsamples_chr${chr}.hg38_multianno.vcf.gz
mv $ANNOTATEVCF $ANNOTATEDIR
