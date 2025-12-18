#!/bin/bash
set -euo pipefail

# Run from: /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew
cd /scratch/grp/msc_appbio/Group4_ABCC/DNAseq/bamnew

GATK_IMG=/scratch/grp/msc_appbio/Group4_ABCC/DNAseq/gatk_4.1.0.0.sif
REF=/scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/reference_genome.fa

echo "GATK container: $GATK_IMG"
echo "Reference:      $REF"
echo "Working dir:    $(pwd)"
echo

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

echo "All samples finished."
