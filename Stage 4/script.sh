#!/bin/sh

# Activate the conda environment if not activated
conda activate NGS-Analysis

# Create a new folder for the analysis then one for the samples
mkdir NGS_analysis
cd NGS_analysis
mkdir samples

#Download the samples inside the samples folder
wget -P samples/ https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz samples/ https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz
#ACBarrie
wget -P samples/ https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R1.fastq.gz https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R2.fastq.gz
#Alsen
wget -P samples/ https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R1.fastq.gz https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R2.fastq.gz
#Baxter
wget -P samples/ https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R1.fastq.gz https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R2.fastq.gz
#Chara
wget -P samples/ https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R1.fastq.gz https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R2.fastq.gz
#Drysdale
wget -P samples/ https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R1.fastq.gz https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R2.fastq.gz

# Create a new folder for the reference genome
mkdir reference

#Download the reference genome inside the reference folder
wget -P reference/ https://zenodo.org/records/10886725/files/Reference.fasta

# Assessing the quality of the samples
mkdir assessedQC

for file in samples/*.fastq.gz; do
    fastqc $file -o assessedQC
done

#Create a summary report to visualise the combined samples using multiqc.
multiqc assessedQC/*_fastqc.zip

#Correct disordered reads
mkdir repaired_samples
mkdir SINGLETONS

for READ in samples/*1.fastq.gz; do
	base=$(basename $READ 1.fastq.gz)
	repair.sh in1=samples/${base}1.fastq.gz in2=samples/${base}2.fastq.gz \
              out1=repaired_samples/${base}1_repaired.fastq.gz out2=repaired_samples/${base}2_repaired.fastq.gz \
              outs=SINGLETONS/${base}_singletons.fastq.gz
done

#Trimm low quality parts
mkdir trimmed_samples

for sample in repaired_samples/*1_repaired.fastq.gz; do 
	base=$(basename $sample 1_repaired.fastq.gz)
	fastp \
	-i repaired_samples/${base}1_repaired.fastq.gz \
	-I repaired_samples/${base}2_repaired.fastq.gz \
	-o trimmed_samples/${base}1_trimmed.fastq.gz \
	-O trimmed_samples/${base}2_trimmed.fastq.gz \
	-l 36 \
	--html trimmed_samples/${base}_fastp.html
done

#Genome indexing
mkdir aligned_reads
bwa index reference/Reference.fasta

#Align the trimmed samples with the reference genome
for read in trimmed_samples/*1_trimmed.fastq.gz; do
    base=$(basename $read 1_trimmed.fastq.gz)
    bwa mem reference/Reference.fasta trimmed_samples/${base}1_trimmed.fastq.gz trimmed_samples/${base}2_trimmed.fastq.gz -o aligned_reads/${base}.sam
done

 #Convert SAM files into BAM files using samstools
mkdir BAM_files

for sam in aligned_reads/*.sam; do
    base=$(basename $sam .sam)
    samtools view -Sb $sam | samtools sort -o BAM_files/${base}_sorted.bam
     samtools index BAM_files/${base}_sorted.bam
done   

#Variant calling using freebayes
mkdir VCF_Output
for bam in BAM_files/*_sorted.bam; do
    base=$(basename $bam _sorted.bam)
    freebayes -f reference/Reference.fasta BAM_files/${base}_sorted.bam \
        --vcf VCF_Output/${base}_VCF_Output.vcf
done
