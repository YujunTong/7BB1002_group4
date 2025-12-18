#!/bin/bash

# Activate the environment
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli
echo "successfully activate environment 2"


# Choose ONE sample BAM file for the strandness test
# specify the input bam file, the annotation file, and output directory 
BAM="/scratch/grp/msc_appbio/Group4_ABCC/output/aligned/ERR4553381_Aligned.sortedByCoord.out.bam"
GTF="/scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/annotation.gtf"
OUTDIR="/scratch/grp/msc_appbio/Group4_ABCC/output/htseq_strand_test"

# Creating new output directory
mkdir -p "$OUTDIR"

echo "Testing HTSeq-count strandedness..."
echo

# assuming an unstranded library, and count results were written to a unstranded.txt.
echo "===== Unstranded (-s no) ====="
htseq-count -s no -f bam -r pos "$BAM" "$GTF" > "$OUTDIR/unstranded.txt"
echo


# assuming a forward stranded library, and count results were written to a forward_stranded.txt.
echo "===== stranded (-s yes) ====="
htseq-count -s yes -f bam -r pos "$BAM" "$GTF" > "$OUTDIR/forward_stranded.txt"

# assuming a reverse stranded library, and count results were written to a reverse_stranded.txt.
echo "===== Reverse-stranded (-s reverse) ====="
htseq-count -s reverse -f bam -r pos "$BAM" "$GTF" > "$OUTDIR/reverse_stranded.txt"

echo
echo "Compare the results:"

echo " - If -s no has more counts means library is unstranded."
echo " - If -s yes has more counts means library is forward-stranded."
echo " - If -s reverse has more counts means library is reverse-stranded."



#which [software] and [software] --version do not work in checking HTSeq version 
# Print HTSeq version (v.0.9.1.)
echo -n "HTSeq version: "
python3 - <<EOF
import HTSeq
print(HTSeq.__version__)
EOF
