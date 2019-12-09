htk/LPlex -t gram/trigram/langmodel corpus/corpus_s1_dan_s2.txt | tee result/result_model_tri.txt
htk/LPlex -t gram/bigram/langmodel corpus/corpus_s1_dan_s2.txt | tee result/result_model_bi.txt