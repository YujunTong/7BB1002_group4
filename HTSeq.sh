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
# for all the bam files, 


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


# print software version

python3 - <<EOF
import HTSeq
print("HTSeq version:", HTSeq.__version__)
EOF

