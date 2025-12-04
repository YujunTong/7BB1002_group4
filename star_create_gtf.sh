#!/bin/bash

echo "Starting file conversion"

gffread /scratch/grp/msc_appbio/Group4_ABCC/raw_data/star_fa_gff3/Saccharomyces_cerevisiae_cen_pk113_7d_gca_000269885.ASM26988v1.62.gff3 -T -o /scratch/grp/msc_appbio/Group4_ABCC/raw_data/star_fa_gff3/Saccharomyces_cerevisiae_cen_pk113_7d.gtf

echo "finished file conversion"


