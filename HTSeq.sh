#!/bin/bash

# Activate conda environment
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

echo "successfully activate environment"


echo "Starting HTSeq-count"
# specify the directory for bam file, the annotation file, and the output directory
Bam_dir="/scratch/grp/msc_appbio/Group4_ABCC/output/aligned"
Gtf="/scratch/grp/msc_appbio/Group4_ABCC/raw_data/final_genome/annotation.gtf"
Out_dir="/scratch/grp/msc_appbio/Group4_ABCC/output/htseq_counts"

# create a new directory
mkdir -p $Out_dir


# Start of the loop
# run HTSeq-count to generate read counts for unique mapped gene. 
# Input file format is BAM
# BAM file is sorted by genomic position
# Reverse-stranded library
# Count reads overlapping exons
# Use 'gene_id' to group exons into genes
# Input BAM file
# Gene annotation file (GTF format)
for bam in ${Bam_dir}/*_Aligned.sortedByCoord.out.bam
do
    sample=$(basename $bam _Aligned.sortedByCoord.out.bam)

    echo "Counting reads for $sample"

    htseq-count \
        -f bam \
        -r pos \
        -s reverse \
        -t exon \
        -i gene_id \
        $bam \
        $Gtf \
        > ${Out_dir}/${sample}_counts.txt

done

echo "HTSeq-count finished for all samples."


#which [software] and [software] --version do not work in checking HTSeq version 
# Print HTSeq version (v.0.9.1.)
python3 - <<EOF
import HTSeq
print("HTSeq version:", HTSeq.__version__)
EOF

