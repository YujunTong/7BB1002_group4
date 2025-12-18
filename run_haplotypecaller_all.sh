#!/bin/bash
set -euo pipefail

# Run from: /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew
cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew

# Path to the GATK Singularity container image
GATK_IMG=/scratch/grp/msc_appbio/Group4_ABCC/DNAseq/gatk_4.1.0.0.sif

# Reference genome directory
REF=/scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/reference_genome.fa

echo "GATK container: $GATK_IMG"
echo "Reference:      $REF"
echo "Working dir:    $(pwd)"
echo

# start of the loop
# Input BAM file (deduplicated)
# Output GVCF file
# Check that the input BAM file exists
# Exit immediately if it is missing

for code in C1 C2 C3 C4 C5 C6 C7 C8 C9 C10; do
  BAM="${code}.dedup.bam"
  OUT="${code}.g.vcf.gz"

  [[ -f "$BAM" ]] || { echo "ERROR: Missing $BAM" >&2; exit 1; }

  echo "=== Running $code ==="
  singularity exec -B /scratch:/scratch -B /cephfs:/cephfs "$GATK_IMG" \
    gatk HaplotypeCaller \
      -R "$REF" \
      -I "$BAM" \
      -O "$OUT" \
      -ERC GVCF \
      --sample-ploidy 1

  echo "=== Done $code -> $OUT  ==="
  echo
done

# pipeline finished
echo "All samples finished."
