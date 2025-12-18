#!/bin/bash
set -euo pipefail

source ~/.bashrc
conda activate /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/env/Envstep1
cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew

REF=/scratch/grp/msc_appbio/Group4_ABCC/raw_data/genome/Saccharomyces_cerevisiae_cen_pk113_7d_gca_000269885.ASM26988v1.dna.toplevel.fa

run_one () {
  local code="$1"

  echo "=== Reordering ${code}.sorted.bam ==="

  picard AddOrReplaceReadGroups \
  I=${code}.bam \
  O=${code}.picard.bam 
  RGID=C1 \
  RGLB=lib1 \ 
  RGPL=ILLUMINA \ 
  RGPU=unit1 \ 
  RGSM=C1 \

  picard SortSam \ 
  I=${code}.picard.bam \ 
  O=${code}.sorted.bam \ 
  SORT_ORDER=coordinate

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

echo "job compelted"









