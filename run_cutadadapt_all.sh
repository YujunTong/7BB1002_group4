#!/bin/bash

# Activate conda environment
conda activate /cephfs/volumes/hpc_data_grp/msc_appbio/70e465a3-ea70-4bd6-b919-9da7af124271/Group4_ABCC/env_rnaseq   

# Define directories
INPUT_DIR="/scratch/grp/msc_appbio/Group4_ABCC/raw_data/raw_data_fastq/rna_seq_fastq"
OUTPUT_DIR="/scratch/grp/msc_appbio/Group4_ABCC/output"

echo "Starting Cutadapt trimming..."

# NEBNext / Illumina TruSeq adapter (single-end)
ADAPTER="AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"

# Loop through all FASTQ files
for FQ in "$INPUT_DIR"/*.fastq.gz
do
    BASENAME=$(basename "$FQ")
    OUTFILE="${OUTPUT_DIR}/${BASENAME/.fastq.gz/_trimmed.fastq.gz}"

    echo "Processing: $BASENAME"

    cutadapt \
        -a $ADAPTER \
        -q 20 \
        --minimum-length 30 \
        -o "$OUTFILE" \
        "$FQ"
done

echo "Done! Trimmed files saved in: $OUTPUT_DIR"

