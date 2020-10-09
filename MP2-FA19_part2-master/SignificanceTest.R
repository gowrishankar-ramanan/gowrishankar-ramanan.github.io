bm25 = read.table('bm25.avg_p.txt')$V1
inl2 = read.table('inl2.avg_p.txt')$V1
t.test(bm25, inl2, paired=T)
