#!/bin/bash

echo "start copying and renaming"

# Step 1: go to the directory that contains the 20 folders
cd /scratch/grp/msc_appbio/Group4_ABCC/output/faqc/

# Step 2: make the destination folder
mkdir -p pre_star_fastq

# Step 3: for each folder (ERR4553381 to ERR4553400)
for folder in ERR4553381 ERR4553382 ERR4553383 ERR4553384 ERR4553385 ERR4553386 ERR4553387 ERR4553388 ERR4553389 ERR4553390 ERR4553391 ERR4553392 ERR4553393 ERR4553394 ERR4553395 ERR4553396 ERR4553397 ERR4553398 ERR4553399 ERR4553400
do
    # Step 4: copy and rename QC.unpaired.trimmed.fastq out of the folder and paste it into the destination folder
    cp "$folder/QC.unpaired.trimmed.fastq.gz" "pre_star_fastq/${folder}_QC.unpaired.trimmed.fastq.gz"
done

echo "finish"
