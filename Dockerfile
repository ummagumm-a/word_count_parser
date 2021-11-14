FROM python:3.8-slim-buster

RUN pip install pandas tqdm
RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y bzip2 \
  && apt-get install -y gzip \
  && rm -rf /var/lib/apt/lists/*
COPY cleaner.py cleaner.py
COPY counter.py counter.py
COPY download_datasets.sh download_datasets.sh
COPY datasets/ datasets/
COPY dirty_datasets/ dirty_datasets/

RUN mkdir final_counts
RUN ./download_datasets.sh
RUN ls
RUN ls dirty_datasets/
RUN pwd

CMD python3 cleaner.py && python3 counter.py && ls final_counts
