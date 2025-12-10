#!/bin/bash

# Activate conda environment
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"

echo "sucessfully activate environment 1"

micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment 2"

echo "Starting file conversion"

gffread /scratch/grp/msc_appbio/Group4_ABCC/raw_data/star_fa_gff3/Saccharomyces_cerevisiae_cen_pk113_7d_gca_000269885.ASM26988v1.62.gff3 -T -o /scratch/grp/msc_appbio/Group4_ABCC/raw_data/star_fa_gff3/Saccharomyces_cerevisiae_cen_pk113_7d.gtf


 


echo "finished file conversion"

which gffread

gffread --version

