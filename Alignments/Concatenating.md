List of genes per concatenate were built with GC_CU/Script.R

```bash
#Non bis aln can't be used anymore
#fasta
for i in `seq 0 19`
do
  ~/concat-aln/concat-fasta FASTA Aln$i.bis $(cat Aln$i.bis.txt) && mv Aln$i.bis.phy Aln$i.bis.fa
done

for i in `seq 0 19`
do
 grep '>' Aln$i.bis.fa | wc -l
done

echo -e "seq_id\tA\tT\tG\tC"; while read line; do echo $line | grep ">" | sed 's/>//g'; for i in A T G C;do echo $line | grep -v ">" | grep -o $i | wc -l | grep -v "^0"; done; done <  Aln6.bis.fa | paste - - - - -

#phylip (for coevol)
for i in `seq 0 29`
do
  ~/concat-aln/concat-fasta PHYLIP Aln$i $(cat Aln$i.txt)
done
```
