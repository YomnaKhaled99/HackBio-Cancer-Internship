#!/bin/sh

# Adding channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# Create a new conda environment and install require packages 
conda create -n NGS-Analysis fastqc multiqc fastp bwa samtools freebayes

# Activate the environment
conda activate NGS-Analysis

#Check the java version as it's required for bbtools function
java -version

#Install java 7 if not found
#sudo apt-get install -y openjdk-7-jdk

# Download BBTools
wget https://sourceforge.net/projects/bbmap/files/latest/download -O bbtools.tar.gz

# Extract BBTools
tar -xzf bbtools.tar.gz

# Move it to /opt
sudo mv bbmap /opt/bbtools

# Add BBTools to PATH
echo 'export PATH=$PATH:/opt/bbtools' >> ~/.bashrc
source ~/.bashrc

# Verify BBTools installation
bbduk.sh --version

