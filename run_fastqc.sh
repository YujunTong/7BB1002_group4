#!/bin/bash


export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"

echo "sucessfully activate environment 1"

micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment 2"


echo "Starting HTSeq-count"


# ===== USER SETTINGS =====
INPUT_DIR="/scratch/grp/msc_appbio/k25022317/fastq_files"
OUTPUT_DIR="/scratch/grp/msc_appbio/k25022317/fastqc_results"

# Activate your environment (edit if using conda or module)
conda activate /cephfs/volumes/hpc_data_grp/msc_appbio/70e465a3-ea70-4bd6-b919-9da7af124271/Group4_ABCC/env_rnaseq

# Run FastQC on all FASTQ files in the input directory
fastqc -t 4 ${INPUT_DIR}/*.fastq.gz -o $OUTPUT_DIR

echo "FastQC finished. Results saved in: $OUTPUT_DIR"
