import pandas as pd
import os

def merge_epitype_samples(sample_list, ref_path, input_dir, output_name):
    master_df = pd.read_csv(ref_path, sep="\t", header=None)
    master_df.columns = ["chr", "start", "end", "probe"]
    for name in sample_list:
        file_path = os.path.join(input_dir, f"{name}_interepitype500_ratio.bed")
        df_sample = pd.read_csv(file_path, sep="\t", header=None)
        df_sample.columns = ["chr", "start", "end", "probe", name]
        master_df = pd.merge(master_df, df_sample, how="left", on=["chr", "start", "end", "probe"])

    master_df.to_csv(output_name, index=False)
    print(f"Master file saved as: {output_name}")

if __name__ == "__main__":
    SAMPLES = ["wt1", "wt2", "wt3", "wt4", "wt5", "wt6", "mut1", "mut2", "mut3", "mut4", "mut5", "mut6", "mut7"] 
   
    REFERENCE = "epitype_ref/epitype_500mvcpg_hg38.bed"
    DATA_DIR = "interepitype500/"
    OUTPUT = "epitype_mv500cpg_merged_results.csv"

    merge_epitype_samples(SAMPLES, REFERENCE, DATA_DIR, OUTPUT)