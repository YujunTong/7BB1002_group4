
#!/bin/bash

# Activate the environment
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment"

echo "Building STAR index..."

# STAR Indexed to create 
# Use 4 threads
# tells Star that we want to generate a reference genome
#the directory of the reference genome
#the reference genome in fasta format
#the annotation file
STAR --runThreadN 4 \
     --runMode genomeGenerate \
     --genomeDir /scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/ \
     --genomeFastaFiles /scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/reference_genome.fa \
     --sjdbGTFfile /scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/annotation.gtf \
     --sjdbOverhang 84

echo "STAR index completed."


# To show STAR v.2.5.2a was used
which STAR
STAR --version
