#!/bin/bash

# Activate the environment

export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment 2"

# specify the directory for input fastq files, output, and the reference genome
Fastq_dir="/scratch/grp/msc_appbio/Group4_ABCC/output/faqc/pre_star_fastq"
Output_dir="/scratch/grp/msc_appbio/Group4_ABCC/output/aligned"
Index="/scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome"

echo "start of STAR alignment"

# Start of the loop for each fastq files
# perform star alignment
# use 4 threads
# directory for genome reference
# read compressed Fastq files
# read the fastq file
# use the fastq files name as prefix for the generated files
# Output format and sorting

for file in ${Fastq_dir}/*.fastq.gz
do
    sample=$(basename $file _QC.unpaired.trimmed.fastq.gz)

    echo "Aligning $sample"

    STAR --runThreadN 4 \
         --genomeDir $Index \
         --readFilesCommand zcat \
         --readFilesIn $file \
         --outFileNamePrefix ${Output_dir}/${sample}_ \
         --outSAMtype BAM SortedByCoordinate

    echo "Indexing BAM for $sample"

done

echo "all STAR alignments completed"

# To show STAR v.2.5.2a was used
which STAR
STAR --version

