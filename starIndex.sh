#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --mail-user=jjenn010@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="star index"
#SBATCH -p epyc # You can use any of the following; epyc, intel, batch, highmem, gpu

# Print current date
date

# Load star
module load star

STAR --runThreadN 10 --runMode genomeGenerate --genomeDir \
./star_index_mouse_gencode --genomeFastaFiles ./mouse_genome_gencode/genome.fa \
--sjdbGTFfile ./mouse_genome_gencode/genes.gtf --sjdbOverhang 99

# Print name of node
hostname
