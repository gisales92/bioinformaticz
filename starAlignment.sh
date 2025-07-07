#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=50G
#SBATCH --time=06:15:00     # 6 hours and 15 minutes
#SBATCH --mail-user=jjenn010@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="star bulk alignment"
#SBATCH -p epyc # You can use any of the following; epyc, intel, batch, highmem, gpu

# Print current date
date

# Loop through each R1 file
for R1 in *_1.trimmed.fastq.gz
do
    # Get sample base name (remove _1.trimmed.fastq.gz)
    SAMPLE=$(basename "$R1" _1.trimmed.fastq.gz)

    # Define R2 filename
    R2="${SAMPLE}_2.trimmed.fastq.gz"

    echo "Aligning sample: $SAMPLE"

    STAR --runThreadN 10 \
         --genomeDir ./star_index_mouse_gencode \
         --readFilesIn "$R1" "$R2" \
         --readFilesCommand zcat \
         --outFileNamePrefix ./star_output/"$SAMPLE"_ \
         --outSAMtype BAM SortedByCoordinate \
         --outSAMattributes NH HI AS nM \
         --outSAMstrandField intronMotif

    echo "Finished $SAMPLE"
done

# Print name of node
hostname