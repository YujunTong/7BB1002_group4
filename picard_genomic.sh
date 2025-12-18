#!/bin/bash
set -euo pipefail

# activate the environment
source ~/.bashrc
conda activate /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/env/Envstep1
cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew

# reference genome directory
REF=/scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/reference_genome.fa

# process one sample at a time
run_one () {
  local code="$1"

  echo "=== Reordering ${code}.sorted.bam ==="
  
 # Add or replace read group information
  picard AddOrReplaceReadGroups \
  I=${code}.bam \
  O=${code}.picard.bam 
  RGID=C1 \
  RGLB=lib1 \ 
  RGPL=ILLUMINA \ 
  RGPU=unit1 \ 
  RGSM=C1 \
  
# Sort BAM file by genomic coordinates
  picard SortSam \ 
  I=${code}.picard.bam \ 
  O=${code}.sorted.bam \ 
  SORT_ORDER=coordinate

 # Mark duplicate reads and create BAM index
  picard MarkDuplicates \
  I=${code}.sorted.bam \ 
  O=${code}.dedup.bam \ 
  M=${code}.dup_matrics.txt\
  CREATE-INDEX=True

# Run for all 10 samples
run_one C1
run_one C2
run_one C3
run_one C4
run_one C5
run_one C6
run_one C7
run_one C8
run_one C9
run_one C10
eference_genome.fa

# job finished
echo "job compelted"









