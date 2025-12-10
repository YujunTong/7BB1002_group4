#!/bin/bash

# Activate conda environment
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"

echo "sucessfully activate environment 1"

micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment 2"


# Choose ONE sample BAM file to test
BAM="/scratch/grp/msc_appbio/Group4_ABCC/output/aligned/ERR4553381_Aligned.sortedByCoord.out.bam"
GTF="/scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/annotation.gtf"
OUTDIR="/scratch/grp/msc_appbio/Group4_ABCC/output/htseq_strand_test"

mkdir -p "$OUTDIR"

echo "Testing HTSeq-count strandedness..."
echo

echo "===== Unstranded (-s no) ====="
htseq-count -s no -f bam -r pos "$BAM" "$GTF" > "$OUTDIR/unstranded.txt"
echo

echo "===== stranded (-s yes) ====="
htseq-count -s yes -f bam -r pos "$BAM" "$GTF" > "$OUTDIR/forward_stranded.txt"

echo
echo "===== Reverse-stranded (-s reverse) ====="
htseq-count -s reverse -f bam -r pos "$BAM" "$GTF" > "$OUTDIR/reverse_stranded.txt"

echo
echo "Compare the results:"

echo " - If -s no has more counts means library is unstranded."
echo " - If -s yes has more counts means library is forward-stranded."
echo " - If -s reverse has more counts means library is reverse-stranded."

# Print HTSeq version
echo -n "HTSeq version: "
python3 - <<EOF
import HTSeq
print(HTSeq.__version__)
EOF
