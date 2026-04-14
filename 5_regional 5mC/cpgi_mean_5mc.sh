bedtools intersect -a ref/cpgi.bed -b modbed_wt1_5mc.bed -wa -wb > wt1_cpgi.bed
python mean_5mc_cpgi.py wt1_cpgi.bed wt1_inter_cpgi.csv 
python sum_5mc_cpgi.py wt1_inter_cpgi.csv wt1_average_cpgi.csv 