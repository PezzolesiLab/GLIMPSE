#!/bin/bash

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
OUT=/uufs/chpc.utah.edu/common/home/pezzolesi-group2/Illumina_DRAGEN_analyses/72BGEWGS_samples/GLIMPSE/GLIMPSE_concordance/$SAMPLE/

mkdir -p $OUT

REFERENCE=/scratch/general/vast/u1311353/WGS/$SAMPLE

#make input file
echo "chr 22 $REFERENCE/chr22.vcf

~/software/GLIMPSE2_concordance_static --input concordance.lst --min-val-dp 8 --output $OUT --min-val-gl 0.9999 --bins 0.00000 0.00100 0.00200 0.00500 0.01000 0.05000 0.10000 0.20000 0.50000 --af-tag AF_gnomad_all --thread $SLURM_CPUS_ON_NODE

cd plot;
./concordance_plot.py
