#!/bin/bash

# Directories
INPUT_DIR="/scratch/grp/msc_appbio/Group4_ABCC/output"
OUTPUT_DIR="/scratch/grp/msc_appbio/Group4_ABCC/output/faqc"

mkdir -p "${OUTPUT_DIR}"

echo "Input directory : ${INPUT_DIR}"
echo "Output directory: ${OUTPUT_DIR}"

# Loop over all *_trimmed.fastq.gz files
shopt -s nullglob   # important: if no files match, the pattern disappears instead of staying as "*"

files=("${INPUT_DIR}"/*_trimmed.fastq.gz)

if [ ${#files[@]} -eq 0 ]; then
    echo "No files matching ${INPUT_DIR}/*_trimmed.fastq.gz"
    exit 1
fi

for f in "${files[@]}"; do
    sample=$(basename "$f" _trimmed.fastq.gz)
    outdir="${OUTPUT_DIR}/${sample}"

    mkdir -p "${outdir}"

    echo "Processing ${sample} ..."
    FaQCs -u "$f" -q 20 --min_L 30 -n 3 -d "${outdir}"
done

echo "FaQCs finished. Results saved in: ${OUTPUT_DIR}"

