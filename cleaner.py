import pandas as pd
import string
import glob
import re
import os
from tqdm import tqdm

def clean(text):
    # remove punctuation
    text = re.sub(r'["#$%&\'()*«»\+,№—/:<=>@\[\\\]^_`{|}~]', ' ', text)
    # remove english letters
    text = re.sub(r'[A-Za-z]', '', text)
    # replace numbers with token
    text = re.sub(r'(\d+)[\-\w]*', ' <n> ', text)
    # replace - with space
    text = re.sub(r'\-', ' ', text)
    # replace sentence ending punctuation with dot
    text = re.sub(r'[….!?;]', ' . ', text)
    # remove one-word sentences
    text = re.sub(r'\. *\w+ *\.', '.', text)
    # paste whitespace before capital letters
    text = re.sub(r"(\w)([А-Я][а-я]+)", r"\1 \2", text)
    # all letters to lowercase
    text = text.lower()
    # remove multiple whitespaces
    text = re.sub(r'\s{2,}', ' ', text)
    
    return text

for filename in tqdm(list(glob.iglob('dirty_datasets/**/*.csv', recursive=True))):
    df = pd.read_csv(
        filename, 
        usecols=['text'])
    modified = df['text'].dropna().apply(clean)
    modified.to_csv('datasets/' + os.path.basename(filename))