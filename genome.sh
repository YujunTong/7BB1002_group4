java -jar picard.jar AddOrReplaceReadGroups \ I=input.bam \ O=output.bam \ RGID=4 \ RGLB=lib1 \ RGPL=illumina \ RGPU=unit1 \ RGSM=20
picard AddOrReplaceReadGroups I=ERR5533561.bam O=ERR5533561.picard.bam RGID=1 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=sample1

From your full list, only these are used:
AddOrReplaceReadGroups
SortSam
ReorderSam (optional but mentioned)
MarkDuplicates
BuildBamIndex

01
picard_rg.sbatch
#!/bin/bash

# Activate conda environment
source ~/.bashrc
conda activate /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/env/Envstep1

# Go to working directory
cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew


# Run Picard
picard AddOrReplaceReadGroups I=ERR5533561.bam O=ERR5533561.picard.bam RGID=C1 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell1
picard AddOrReplaceReadGroups I=ERR5533562.bam O=ERR5533562.picard.bam RGID=C2 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell2
picard AddOrReplaceReadGroups I=ERR5533563.bam O=ERR5533563.picard.bam RGID=C3 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell3
picard AddOrReplaceReadGroups I=ERR5533564.bam O=ERR5533564.picard.bam RGID=C4 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell4
picard AddOrReplaceReadGroups I=ERR5533565.bam O=ERR5533565.picard.bam RGID=C5 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell5
picard AddOrReplaceReadGroups I=ERR5533566.bam O=ERR5533566.picard.bam RGID=C6 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell6
picard AddOrReplaceReadGroups I=ERR5533581.bam O=ERR5533581.picard.bam RGID=C7 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell7
picard AddOrReplaceReadGroups I=ERR5533583.bam O=ERR5533583.picard.bam RGID=C8 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell8
picard AddOrReplaceReadGroups I=ERR5533584.bam O=ERR5533584.picard.bam RGID=C9 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell9
picard AddOrReplaceReadGroups I=ERR5533591.bam O=ERR5533591.picard.bam RGID=C10 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=Cell10


New 03
#!/bin/bash

source ~/.bashrc
conda activate /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/env/Envstep1
cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew



 REF=/scratch/grp/msc_appbio/Group4_ABCC/raw_data/genome/Saccharomyces_cerevisiae_cen_pk113_7d_gca_000269885.ASM26988v1.dna.toplevel.fa


picard ReorderSam \
  I="C1.sorted.bam" \
  O="C1.sorted.reordered.bam" \
  R="$REF" \
  CREATE_INDEX=false

04
#!/bin/bash

source ~/.bashrc
conda activate /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/env/Envstep1
cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew


picard MarkDuplicates \
  I=C1.sorted.bam \
  O=C1.dedup.bam \
  M=C1.dup_metrics.txt \
  CREATE_INDEX=true

picard MarkDuplicates \
  I=C2.sorted.bam \
  O=C2.dedup.bam \
  M=C2.dup_metrics.txt \
  CREATE_INDEX=true

picard MarkDuplicates \
  I=C3.sorted.bam \
  O=C3.dedup.bam \
  M=C3.dup_metrics.txt \
  CREATE_INDEX=true

picard MarkDuplicates \
  I=C4.sorted.bam \
  O=C4.dedup.bam \
  M=C4.dup_metrics.txt \
  CREATE_INDEX=true

picard MarkDuplicates \
  I=C5.sorted.bam \
  O=C5.dedup.bam \
  M=C5.dup_metrics.txt \
  CREATE_INDEX=true

picard MarkDuplicates \
  I=C6.sorted.bam \
  O=C6.dedup.bam \
  M=C6.dup_metrics.txt \
  CREATE_INDEX=true

picard MarkDuplicates \
  I=C7.sorted.bam \
  O=C7.dedup.bam \
  M=C7.dup_metrics.txt \
  CREATE_INDEX=true

picard MarkDuplicates \
  I=C8.sorted.bam \
  O=C8.dedup.bam \
  M=C8.dup_metrics.txt \
  CREATE_INDEX=true

picard MarkDuplicates \
  I=C9.sorted.bam \
  O=C9.dedup.bam \
  M=C9.dup_metrics.txt \
  CREATE_INDEX=true

picard MarkDuplicates \
  I=C10.sorted.bam \
  O=C10.dedup.bam \
  M=C10.dup_metrics.txt \
  CREATE_INDEX=true

  05
#!/bin/bash

source ~/.bashrc
conda activate /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/env/Envstep1
cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew

  BuildBamIndex \
      I=input.bam




#!/bin/bash
set -euo pipefail

# Run from: /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew
cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew

GATK_IMG=/scratch/grp/msc_appbio/Group4_ABCC/DNAseq/gatk_4.1.0.0.sif
REF=/scratch/grp/msc_appbio/Group4_ABCC/DNAseq/reference_genome.fa

echo "GATK container: $GATK_IMG"
echo "Reference:      $REF"
echo "Working dir:    $(pwd)"
echo

for code in C1 C2 C3 C4 C5 C6 C7 C8 C9 C10; do
  BAM="${code}.dedup.bam"
  OUT="${code}.g.vcf.gz"

  [[ -f "$BAM" ]] || { echo "ERROR: Missing $BAM" >&2; exit 1; }

  echo "=== Running $code ==="
  singularity exec -B /scratch:/scratch "$GATK_IMG" \
    gatk HaplotypeCaller \
      -R "$REF" \
      -I "$BAM" \
      -O "$OUT" \
      -ERC GVCF \
      --sample-ploidy 1

  echo "=== Done $code -> $OUT  ==="
  echo
done

echo "All samples finished."








--------


cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew

GATK_IMG=/scratch/grp/msc_appbio/Group4_ABCC/DNAseq/gatk_4.1.0.0.sif
REF=/scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/reference_genome.fa

# Make sure reference index files exist (safe to rerun)
samtools faidx "$REF"
picard CreateSequenceDictionary R="$REF" O="${REF%.*}.dict"

for code in C1 C2 C3 C4 C5 C6 C7 C8 C9 C10; do
  echo "===== $code ====="

  # Fix BAM header / contigs
  picard ReorderSam \
    I=${code}.dedup.bam \
    O=${code}.dedup.fixed.bam \
    R="$REF" \
    CREATE_INDEX=true

  # Call variants in GVCF mode
  singularity exec -B /scratch:/scratch -B /cephfs:/cephfs "$GATK_IMG" \
    gatk HaplotypeCaller \
      -R "$REF" \
      -I ${code}.dedup.fixed.bam \
      -O ${code}.g.vcf.gz \
      -ERC GVCF \
      --sample-ploidy 1
done






I ran 
picard ReorderSam I=C?.dedup.bam O=C?.dedup.fixed.bam R="$REF" CREATE_INDEX=true

samtools view -H C1.dedup.bam | grep '^@SQ' | head
samtools view -H C1.dedup.fixed.bam | grep '^@SQ' | head



So the BAM “worked” because you produced fixed BAMs with a proper sequence dictionary, and then HaplotypeCaller used those fixed BAMs.

picard ReorderSam \
  I=C1.dedup.bam \
  O=C1.dedup.fixed.bam \
  R=reference_genome.fa \
  CREATE_INDEX=true










--------------------


