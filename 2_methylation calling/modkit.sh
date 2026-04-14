samtools sort -@ 16 wt1_5mC.bam > wt1_5mC_s.bam 
samtools index wt1_5mC_s.bam 
modkit pileup -t 16 wt1_5mC_s.bam wt1_5mc.bed --ref ref/hg38.fa