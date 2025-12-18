#!/bin/bash

# Activate the environment
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment"

# Define directories
INPUT_DIR="/scratch/grp/msc_appbio/Group4_ABCC/raw_data/raw_data_fastq/rna_seq_fastq"
OUTPUT_DIR="/scratch/grp/msc_appbio/Group4_ABCC/output/new_cut_adapt"

echo "Starting Cutadapt trimming..."

# NEBNext / Illumina TruSeq adapter (single-end)
ADAPTER="AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"

# Loop through all FASTQ files to perform cutadapt 
for FQ in "$INPUT_DIR"/*.fastq.gz
do
    BASENAME=$(basename "$FQ")
    OUTFILE="${OUTPUT_DIR}/${BASENAME/.fastq.gz/_trimmed.fastq.gz}"

    echo "Processing: $BASENAME"


#Cutadapt was performed
# remove the adaptor sequence in 3' end
# Trim low-quality bases (Phred < 20)
# reads shorter than 30bp was removed
# 4 threads were used

    cutadapt \
        -a $ADAPTER \
        -q 20 \
        --minimum-length 30 \
        -j 4 \
        -o "$OUTFILE" \
        "$FQ"
done

echo "Done! Trimmed files saved in: $OUTPUT_DIR"

# Show which cutadapt was used
which cutadapt
cutadapt --version
