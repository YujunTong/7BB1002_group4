#!/bin/bash


#!/bin/bash

# Activate conda environment

export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"

echo "sucessfully activate environment 1"

micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment 2"



echo "Building STAR index..."

STAR --runThreadN 4 \
     --runMode genomeGenerate \
     --genomeDir /scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/ \
     --genomeFastaFiles /scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/reference_genome.fa \
     --sjdbGTFfile /scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/annotation.gtf \
     --sjdbOverhang 84

echo "STAR index completed."

which STAR
STAR --version
