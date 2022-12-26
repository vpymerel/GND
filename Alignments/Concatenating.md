List of genes per concatenate were built with GC_CU/Script.R

```bash

for i in `seq 0 20`
do
  ~/concat-aln/concat-fasta FASTA Aln$i $(cat Aln$i.txt) && mv Aln$i.phy Aln$i.fa
done

for i in `seq 0 20`
do
 grep '>' Aln$i.fa | wc -l
done
```
