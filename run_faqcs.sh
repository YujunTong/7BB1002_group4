#!/bin/bash

#############################################################
# CONFIGURATION
#############################################################


# Activate the environment
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli
echo "successfully activate environment"

# Input FASTQ directory
INPUT_DIR="/scratch/grp/msc_appbio/Group4_ABCC/output/new_cut_adapt"

# Output directory
OUTPUT_DIR="/scratch/grp/msc_appbio/Group4_ABCC/output/faqc"

# Create output directory if not exist
mkdir -p "${OUTPUT_DIR}"

echo "Input directory : ${INPUT_DIR}"
echo "Output directory: ${OUTPUT_DIR}"


# If wildcard matches nothing, avoid literal "*"
shopt -s nullglob


# find the files
# Match files ending with '_trimmed.fastq.gz'
files=("${INPUT_DIR}"/*_trimmed.fastq.gz)

# If no trimmed files found, try all fastq.gz
if [ ${#files[@]} -eq 0 ]; then
    echo "No *_trimmed.fastq.gz found, falling back to all .fastq.gz files"
    files=("${INPUT_DIR}"/*.fastq.gz)
fi

# If still none, exit
if [ ${#files[@]} -eq 0 ]; then
    echo "Error: No FASTQ files found in ${INPUT_DIR}"
    exit 1
fi

echo "Files to be processed:"
printf '  %s\n' "${files[@]}"

#############################################################
# PROCESS EACH SAMPLE
#############################################################

for f in "${files[@]}"; do

    # Determine sample name
    if [[ "$f" == *_trimmed.fastq.gz ]]; then
        sample=$(basename "$f" _trimmed.fastq.gz)
    else
        sample=$(basename "$f" .fastq.gz)
    fi

    outdir="${OUTPUT_DIR}/${sample}"

    # Skip already processed samples
    if [ -d "$outdir" ]; then
        echo "Skipping ${sample} (already processed)"
        continue
    fi

    echo "========================================="
    echo "Processing sample: ${sample}"
    echo "Input file       : ${f}"
    echo "Output directory : ${outdir}"
    echo "========================================="

    mkdir -p "${outdir}"

    #########################################################
    # Run FaQCs (single-end mode)
    #########################################################
    
   #FaQCs was performed
   # single-end input
   # Trim low-quality bases (Phred < 20)
   # reads shorter than 30bp are removed
   # reads containing more than 3 Ns will be removed
   # 4 threads were used
    
    FaQCs -u "$f" \
          -q 20 \
          --min_L 30 \
          -n 3 \
          -t 4 \
          -d "${outdir}"

    #########################################################
    # Compress output FASTQ files to save storage
    #########################################################

    if [ -f "${outdir}/QC.unpaired.trimmed.fastq" ]; then
        echo "Compressing: QC.unpaired.trimmed.fastq"
        gzip "${outdir}/QC.unpaired.trimmed.fastq"
    fi

    if [ -f "${outdir}/QC.paired.trimmed.fastq" ]; then
        echo "Compressing: QC.paired.trimmed.fastq"
        gzip "${outdir}/QC.paired.trimmed.fastq"
    fi

    echo "Finished: ${sample}"
    echo
done

echo "All remaining samples processed."
echo "Final output stored in: ${OUTPUT_DIR}"


# verify that FaQCs (v.2.08) was used
which faqcs
faqcs --version
