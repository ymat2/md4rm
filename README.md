# Minimal Dataset for Read Mapping


## Contents

- `ref.fa`: A reference genome with 150bp.
  (A random part of chicken genome [GRCg7b](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_016699485.2/))

- `sra_1.fq`, `sra_2.fq`: Samples of paired-end fastq files. These fastq files contain 5 reads:
  - `@read1`: will be mapped.
  - `@read2`: will also be mapped.
  - `@read3`: is a dplicate of read2.
  - `@read4`: The mate will be unmapped.
  - `@read5`: is a reverse strand read.

- `cmd.sh`: sample codes of [BWA MEM](https://bio-bwa.sourceforge.net/) and [SAMtools](https://www.htslib.org/)


## Getting this dataset

```sh
git clone https://github.com/ymat2/.git
```


## Example

### Requirements

- [BWA MEM](https://bio-bwa.sourceforge.net/) or any other tools for read mapping
- [SAMtools](https://www.htslib.org/)

### Make reference index

```sh
bwa index ref.fa
```

### Map reads

```sh
bwa mem ref.fa sra_1.fq sra_2.fq > small.sam
```

### Process SAM file using SAMtools

```sh
samtools collate small.sam -o small.c.sam      # collate reads
samtools fixmate -m small.c.sam small.cf.sam   # Add MC and ms tags
samtools sort small.cf.sam -o small.cfs.sam    # Sort reads by position
samtools markdup small.cfs.sam small.cfsm.sam  # Mark (or remove by -r) duplicates
samtools view -b small.cfsm.sam > small.bam    # Convert to BAM file
```

You can see changes of tags and flags step by step.

### View

```sh
samtools index small.bam         # Make index
samtools tview small.bam         # view without reference
samtools tview small.bam ref.fa  # view with reference
```


## Limitation

All reads will not be mapped in proper pair (i.e. lack `0x002` flag) because there are not enough pairs.
