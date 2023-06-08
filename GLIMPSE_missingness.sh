vcftools --vcf input.vcf --missing-site --out missingness

vcftools --vcf input.vcf --recode --out filtered --max-missing 0.10
