#!/bin/bash

# activate the environment
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment"


# Define the input and output directory
INPUT_DIR="/scratch/grp/msc_appbio/k25022317/fastq_files"
OUTPUT_DIR="/scratch/grp/msc_appbio/k25022317/fastqc_results"

# Run FastQC on all FASTQ files in the input directory
fastqc -t 4 ${INPUT_DIR}/*.fastq.gz -o $OUTPUT_DIR

echo "FastQC finished. Results saved in: $OUTPUT_DIR"

# show which fastqc was used
which fastqc
fastqc --version
