import pandas as pd
import glob
from tqdm import tqdm

mapping = {1: 'uni', 2: 'bi', 3: 'tri'}

def process_df(df, counts, total, n):
    def process_row(row):
        nonlocal total
        words = row.split()
        for i in range(len(words) - (n - 1)):
            token = " ".join([words[j] for j in range(i, i + n)])
            if token in counts:
                counts[token] += 1
            else:
                counts[token] = 1
            total += 1
            
    df.apply(process_row)

def count_gram(n):
    counts = {}
    total = 0

    for path in tqdm(glob.glob('datasets/*.csv')):
        ser = pd.read_csv(
            path, 
            header=None, 
            index_col=0, 
            squeeze=True
        )
        process_df(ser.dropna(), counts, total, n)
        
        counts['<total>'] = total

    df = pd.DataFrame.from_dict(counts, orient='index', columns=['Count'])
    df.to_csv('final_counts/' + mapping[n] + '_counts.csv')

for i in range(1, 4):
    count_gram(i)
