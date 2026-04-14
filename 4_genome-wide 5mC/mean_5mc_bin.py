import pandas
import argparse

def sum_inter_bin(in_file, out_file):
    delimiter = r'\s+|\t'
    df_inter = pandas.read_csv(in_file, sep=delimiter, header=None)
    methycol = len(df_inter.columns) - 1
    covcol = len(df_inter.columns) - 2
    df_inter["methycov"] = df_inter[methycol] * df_inter[covcol]
    df=df_inter.groupby([3]).agg({"methycov":"sum",covcol:"sum"})
    df.columns=("methycov","covcol")
    df["ratio"] = df["methycov"] / df["covcol"]
    df=df.drop(columns=["methycov"])
    df.to_csv(out_file, header=False)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Calculate mean methylation proportion in regions')
    parser.add_argument('input_file', type=str, help='Input file name')
    parser.add_argument('output_file', type=str, help='Output file name')
    args = parser.parse_args()

    sum_inter_bin(args.input_file, args.output_file)
