#!/bin/bash

echo "Building STAR index..."

STAR --runThreadN 4 \
     --runMode genomeGenerate \
     --genomeDir /scratch/grp/msc_appbio/Group4_ABCC/raw_data/star_fa_gff3/ \
     --genomeFastaFiles /scratch/grp/msc_appbio/Group4_ABCC/raw_data/star_fa_gff3/Saccharomyces_cerevisiae_cen_pk113_7d_gca_000269885.ASM26988v1.dna.toplevel.fa \
     --sjdbGTFfile /scratch/grp/msc_appbio/Group4_ABCC/raw_data/star_fa_gff3/Saccharomyces_cerevisiae_cen_pk113_7d.gtf

echo "STAR index completed."

