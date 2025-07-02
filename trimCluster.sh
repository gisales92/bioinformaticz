#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --mail-user=jjenn010@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="trimming"
#SBATCH -p epyc # You can use any of the following; epyc, intel, batch, highmem, gpu

# Print current date
date

# Load trimmomatic
module load trimmomatic

for R1 in *_1.fq.gz
  do
  # Extract base name (remove _1.fq.gz)
  BASE=${R1%_1.fq.gz}
  # Define paired R2 file
  R2=${BASE}_2.fq.gz
  # Define output file names
  OUT_R1_P=${BASE}_1.trimmed.fastq.gz
  OUT_R1_U=${BASE}_1.unpaired.fastq.gz
  OUT_R2_P=${BASE}_2.trimmed.fastq.gz
  OUT_R2_U=${BASE}_2.unpaired.fastq.gz
  # Run Trimmomatic
  echo "Trimming $BASE..."
  trimmomatic PE $R1 $R2 \
  $OUT_R1_P $OUT_R1_U $OUT_R2_P $OUT_R2_U \
  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 \
  HEADCROP:10 SLIDINGWINDOW:4:20 TRAILING:3 MINLEN:35
  echo "Done with $BASE"
done

# Print name of node
hostname
