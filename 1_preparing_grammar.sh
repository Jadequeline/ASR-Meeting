htk/LNewMap -f WFC LMName gram/bigram/empty.wmap
htk/LGPrep -a 100000 -b 200000 -n 2 -d gram/bigram gram/bigram/empty.wmap corpus_s1_dan_s2.txt

htk/LNewMap -f WFC LMName gram/trigram/empty.wmap
htk/LGPrep -a 100000 -b 200000 -n 3 -d gram/trigram gram/trigram/empty.wmap corpus_s1_dan_s2.txt