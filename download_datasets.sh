wget https://github.com/ods-ai-ml4sg/proj_news_viz/releases/download/data/interfax.csv.gz -P dirty_datasets/
#wget https://github.com/ods-ai-ml4sg/proj_news_viz/releases/download/data/gazeta.csv.gz -P dirty_datasets/
#wget https://github.com/ods-ai-ml4sg/proj_news_viz/releases/download/data/iz.csv.gz -P dirty_datasets/
#wget https://github.com/ods-ai-ml4sg/proj_news_viz/releases/download/data/meduza.csv.gz -P dirty_datasets/
#wget https://github.com/ods-ai-ml4sg/proj_news_viz/releases/download/data/ria.csv.gz -P dirty_datasets/
#wget https://github.com/ods-ai-ml4sg/proj_news_viz/releases/download/data/rt.csv.gz -P dirty_datasets/
#wget https://github.com/ods-ai-ml4sg/proj_news_viz/releases/download/data/tass-001.csv.gz -P dirty_datasets/

wget https://github.com/buriy/russian-nlp-datasets/releases/download/r4/news-articles-2014.tar.bz2 -P dirty_datasets/
#wget https://github.com/buriy/russian-nlp-datasets/releases/download/r4/news-articles-2015-part1.tar.bz2 -P dirty_datasets/
#wget https://github.com/buriy/russian-nlp-datasets/releases/download/r4/news-articles-2015-part2.tar.bz2 -P dirty_datasets/

#bzip2 -d *.bz2
tar -xf ./dirty_datasets/*.tar.bz2 -C ./dirty_datasets/
#gzip -dc ./dirty_datasets/*.gz > ./dirty_datasets/

for f in ./dirty_datasets/*.gz; do
  STEM=$(basename "${f}" .gz)
  gunzip -c "${f}" > ./dirty_datasets/"${STEM}"
done

rm ./dirty_datasets/*.bz2 ./dirty_datasets/*.gz
