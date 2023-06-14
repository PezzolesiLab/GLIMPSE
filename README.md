# GLIMPSE
GLIMPSE Pipeline for imputing BGE data.

## Getting Started

### Dependencies

Install [GLIMPSE binaries](https://github.com/odelaneau/glimpse/releases)

Later scripts also use bcftools and annovar (link to annovar script). If you are running the program on the chpc you can load bcftools as a module by running the following command.
````
module load bcftools/1.14
````

### Instalation

Download the reference panel. After the reference panel is downloaded normalize the data to only keep SNPs because multiallelic varients are imputed less acurrately. Then create a sites file to speed up the imputation. This can be done with the following code.
````
bcftools norm -m -any NAME_OF_REFERENCE.vcf.gz -Ob -o reference_panel/NAME_OF_REFERENCE_norm.bcf
bcftools index -f reference_panel/NAME_OF_REFERENCE_norm.bcf
bcftools view -G -Oz -o reference_panel/NAME_OF_REFERENCE_norm.sites.vcf.gz reference_panel/NAME_OF_REFERENCE_norm.bcf
bcftools index -f reference_panel/NAME_OF_REFERENCE_norm.sites.vcf.gz
````

## Executable Files

These scripts are loosely based off the [GLIMPSE Getting Started tutorial](https://odelaneau.github.io/GLIMPSE/docs/tutorials/getting_started/). 

Make sure to update the SLURM schedular to match the user and perfered cluster. If running on the CHPC all scripts that execute a GLIMPSE binary must be run on notchpeak.

### GLIMPSE_chuck.sh

### GLIMPSE_split_reference.sh

### GLIMPSE_impute.sh

### GLIMPSE_ligate.sh

### GLIMPSE_merge_raw.sh

### GLIMPSE_GPfilter.sh

### GLIMPSE_merge_filtered.sh

### GLIMPSE_missingness.sh

### GLIMPSE_annotate.sh

### GLIMPSE_concordance.sh

### concordance_plot.py

### convert2vcf.sh

### runImpute.sh

### runMerge.sh

## Authors

Devorah Stucki



