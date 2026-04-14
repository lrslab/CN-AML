import pandas as pd
import argparse

def calculate_average_ratio(input_file, output_file, sample_name):
    df = pd.read_csv(input_file,header=None)
    df.columns=['chr','start','end','cpg_region','ratio']
    avg_ratios = df.groupby('cpg_region')['ratio'].mean().reset_index()
    avg_ratios['sample_name'] = sample_name
    avg_ratios.to_csv(output_file, index=False)

def main():
    parser = argparse.ArgumentParser(description='Calculate average ratio for each cpg_region')
    parser.add_argument('input_file', help='Input CSV file')
    parser.add_argument('output_file', help='Output CSV file')
    parser.add_argument('sample_name', help='Sample name')
    args = parser.parse_args()

    calculate_average_ratio(args.input_file, args.output_file, args.sample_name)
    print(f"Average ratios for {args.sample_name} saved to {args.output_file}")

if __name__ == "__main__":
    main()
