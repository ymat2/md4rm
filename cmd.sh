bwa index ref.fa
bwa mem ref.fa sra_1.fq sra_2.fq > small.sam
bwa mem -I 90 ref.fa sra_1.fq sra_2.fq > small.sam
samtools collate small.sam -o small.c.sam
samtools fixmate -m small.c.sam small.cf.sam
samtools sort small.cf.sam -o small.cfs.sam
samtools markdup small.cfs.sam small.cfsm.sam
samtools view -b small.cfsm.sam > small.bam
samtools index small.bam
samtools tview small.bam
samtools tview small.bam ref.fa
