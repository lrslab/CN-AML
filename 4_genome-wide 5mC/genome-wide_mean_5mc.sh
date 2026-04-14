bedtools intersect -a ref/hg38_100b.bed -b mutR882_5mc.bed -wa -wb > mutR882_100b.bed
python mean_5mc_bin.py mutR882_100b.bed mutR882_100b.csv
bedtools intersect -a ref/hg38_100b.bed -b wt_5mc.bed -wa -wb > wt_100b.bed
python mean_5mc_bin.py wt_100b.bed wt_100b.csv