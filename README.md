# Plant_Virus_ONT

In collaboration with Alma Laney. These scripts will take Oxford Nanopore metagenomic data (fastq files) and:
 
 - Remove plant host reads
 - Assemble contigs with Flye
 - BLAST contigs against NCBI virus database
 - Return an annotated fasta file of viral contigs

## To run: plant_virus_blast "host sci_name" /path/to/Nanopore/fastqs

### Depends: blastn, minimap2, samtools, flye 2.9+, R 4+, seqtk,
### external files at:
### Zahn, Geoffrey. (2022). NCBI Virus BLAST Database [Data set]. Zenodo. https://doi.org/10.5281/zenodo.7250322

