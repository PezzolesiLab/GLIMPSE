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

These scripts are loosely based off the GLIMPSE tutorial located here. 

Make sure to update the SLURM schedular to match the user and perfered cluster. If running on the CHPC all scripts that execute a GLIMPSE binary must be run on notchpeak.

### example_script_1.R

What does this script do?

What needs to be done every time the script is run? What is the input for the script? What arguments does this script take?
1. Argument 1
2. Argument 2

What is the output for this script?

### example-script_2.py

Rinse and repeat

## Other Notes

If you want more information on how to format a markdown document [this website](https://www.markdownguide.org/basic-syntax/) gives a great overview.

## Authors

Devorah Stucki



