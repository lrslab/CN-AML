import pandas
import argparse

def sum_inter_cpgi(in_file, out_file):
    delimiter = r'\s+|\t'
    df_inter = pandas.read_csv(in_file, sep=delimiter, engine='python', header=None)
    methycol = len(df_inter.columns) - 8
    covcol = len(df_inter.columns) - 9
    df_inter["methycov"] = df_inter[methycol] / 100 * df_inter[covcol]
    df = df_inter.groupby([0,1,2,3])["methycov"].sum() / df_inter.groupby([0,1,2,3])[covcol].sum()
    df.to_csv(out_file, header=False)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Calculate mean methylation proportion in regions')
    parser.add_argument('input_file', type=str, help='Input file name')
    parser.add_argument('output_file', type=str, help='Output file name')
    args = parser.parse_args()

    sum_inter_cpgi(args.input_file, args.output_file)
