#!/bin/bash
#SBATCH --job-name=HTSeq
#SBATCH --output=htseq_%j.out
#SBATCH --error=htseq_%j.err

# ================================
# 1. active micromamba environment
# ================================
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

# ================================
# 2. Set input and parameters
# ================================
# reference genome
GTF=/scratch/grp/msc_appbio/Group4_ABCC/......

# STAR BAM files catalogue
BAMDIR=/scratch/grp/msc_appbio/Group4_ABCC/output/aligned......

# HTSeq export catalogue
OUTDIR=/scratch/grp/msc_appbio/Group4_ABCC/counts
mkdir -p $OUTDIR

# ================================
# 3. Run HTSeq-count on each sample
# ================================
for bam in $BAMDIR/*.bam; do

    base=$(basename "$bam" "_Aligned.sortedByCoord.out.bam")

    sample=${base%%__*}

    echo "Running HTSeq-count for sample: $sample"

    htseq-count \
        -f bam \
        -r pos \
        -s reverse \
        -t exon \
        -i gene_id \
        "$bam" \
        "$GTF" \
        > $OUTDIR/${sample}.counts.txt

    echo "Finished: $sample"
done

echo "All samples completed."
