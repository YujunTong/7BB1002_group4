#!/bin/bash
#SBATCH --job-name=faqcs
#SBATCH --output=faqcs_%j.out
#SBATCH --error=faqcs_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G

# FAQC File Position
INPUT_DIR="$/scratch/grp/msc_appbio/Group4_ABCC/output"

#Make Dir in output for faqc
mkdir faqcs_results
# Output dierectory
OUTPUT_DIR="/scratch/grp/msc_appbio/Group4_ABCC/output/faqcs_results"
mkdir -p $OUTPUT_DIR

# run all the trimmed files (single ends)
for fq in ${INPUT_DIR}/*.fastq.gz; do

    sample=$(basename $fq .fastq.gz)
    outdir="${OUTPUT_DIR}/${sample}"

    mkdir -p $outdir

    echo "Processing $sample ..."

    FaQCs.pl \
        -1 $fq \
        -q 20 -min_L 30 -n 3 \
        -o $outdir
done

echo "FaQCs finished. Results saved in: $OUTPUT_DIR"
