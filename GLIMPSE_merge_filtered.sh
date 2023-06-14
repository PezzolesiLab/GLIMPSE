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

VCFLIST=$OUTDIR/vcflist_chr${chr}.txt
#FIXME: make sure the name matches the file names in the input directory
ls -d $INDIR/*/*chr${chr}_ligated_filter${filter}.vcf.gz > $VCFLIST

MERGEVCF=$OUTDIR/BGE_GLIMPSE_fiter${filter}_allsamples_chr${chr}.vcf.gz	
bcftools merge -O z -o $MERGEVCF --threads $SLURM_CPUS_ON_NODE -l $VCFLIST

FILLVCF=$OUTDIR/fill_tags_BGE_GLIMPSE_fiter${filter}_allsamples_chr${chr}.vcf.gz
bcftools +fill-tags $MERGEVCF -O z -o $FILLVCF --threads $SLURM_CPUS_ON_NODE -- -t AC,AN

MISSVCF=$OUTDIR/missingfilter_fill_tags_BGE_GLIMPSE_filter${filter}_allsamples_chr${chr}.vcf.gz
bcftools view -i 'INFO/AN > 124' $FILLVCF -O z -o $MISSVCF --threads $SLURM_CPUS_ON_NODE

ACVCF=$OUTDIR/ACfilter_missingfilter_fill_tags_BGE_GLIMPSE_filter${filter}_allsamples_chr${chr}.vcf.gz
bcftools view -i 'INFO/AC > 0' $MISSVCF -O z -o $ACVCF --threads $SLURM_CPUS_ON_NODE

/uufs/chpc.utah.edu/common/home/u1311353/manipulate_VCF/Bcftools/Normalize/decomposeNormalize_GRCh38.sh $ACVCF $OUTDIR

NORMVCF=$OUTDIR/ACfilter_missingfilter_fill_tags_BGE_GLIMPSE_filter${filter}_allsamples_chr${chr}_decomposed_normalized.vcf.gz
/uufs/chpc.utah.edu/common/home/u1311353/manipulate_VCF/Annotation/standardAnnotation_VCFs_hg38_updated_gnomad_v.sh $NORMVCF

