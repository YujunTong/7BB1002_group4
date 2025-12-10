#!/bin/bash

# Activate conda environment

export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"

echo "sucessfully activate environment 1"

micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment 2"




Fastq_dir="/scratch/grp/msc_appbio/Group4_ABCC/output/faqc/pre_star_fastq"
Output_dir="/scratch/grp/msc_appbio/Group4_ABCC/output/aligned"
Index="/scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome"

echo "start of STAR alignment"

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
    samtools index ${Output_dir}/${sample}_Aligned.sortedByCoord.out.bam

done

echo "all STAR alignments completed"

which STAR
STAR --version

