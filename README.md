**ARuS (Automated RNAseq analysis using Snakemake)**

This is a Snakemake pipeline for running automated mapping-based RNAseq analysis, from fastq reads to DE analysis.

Usage:
Wildcard for sample identification is "{sample}_1.fastq.gz" and "{sample}_2.fastq.gz". 


The pipeline is designed for 150-bp paired-end Illumina reads and it includes:

1. Read quality control (QC) and adapter-trimming (trim_reads.smk)
2. Mapping of reads against provided genome sequence (build_gnm_idx_and_map.smk)
3. Assign mapped reads to genes - this step also computes TPM values and uses them to produce a PCA plot (count.smk)
4. Differential expression (DE) analysis using edgeR (edgeR_de.smk)
5. Post-DE annotation of DE genes and optionally combine with orthology results (post_DE.smk)

Dependencies:

1. FASTQC
https://github.com/s-andrews/FastQC

2. Trimommatic
https://github.com/usadellab/Trimmomatic

3. STAR
https://github.com/alexdobin/STAR

4. featureCounts
https://github.com/torkian/subread-1.6.1

5. edgeR
https://bioconductor.org/packages/release/bioc/html/edgeR.html

6. Trinity-bundled Perl scripts for DE analysis using edgeR
https://github.com/trinityrnaseq/trinityrnaseq

If you use it on hisat2-mapping mode, you will also need:

7. hisat2
https://github.com/DaehwanKimLab/hisat2

8. samtools
https://github.com/samtools/samtools

Every dependency is automatically installed through conda.

**To you use the Docker container, run:**
git clone https://github.com/JasonCharamis/ARuS.git
cd ARuS/workflow/ && sudo docker build -t automated_rnaseq_analysis:latest .
sudo docker run -it -v `pwd`:/workflow -w /workflow automated_rnaseq_analysis:latest snakemake --use-conda --cores 20 --snakefile ARuS/workflow/Snakefile
