Getting rid of spaces, convert sequences characters to uppercase and cutting header if necessary.

```bash
for i in /beegfs/data/merel/DTN/Alignments/*_NT-gb;
do
  #Getting rid of spaces
  sed "s/ //g" $i > $i.tmp
  #To uppercase
  awk '/^>/ {print($0)}; /^[^>]/ {print(toupper($0))}' $i.tmp > tmp && mv tmp $i.tmp
  #Cutting header, e.g. teissieri_scaffold_0.g18.t1 to teissieri
  cut -f 1 -d '_' $i.tmp > tmp && mv tmp $i.tmp
done
```

MACSE pinpoints frameshifts using the "!" character (see https://bioweb.supagro.inra.fr/macse/index.php?menu=doc/programs/exportAlignment). This is not standard and need to be changed before running bpp and/or coevol. Internal frameshifts are replaced by "---" and those at sequence extremities by "-". Also stops codon are replaced by "NNN".

```bash
for i in /beegfs/data/merel/DTN/Alignments/*_NT-gb;
do
  java -jar /beegfs/home/merel/macse_v2.03.jar \
-prog exportAlignment \
-align $i.tmp \
-codonForInternalFS --- \
-charForRemainingFS - \
-codonForInternalStop NNN \
-codonForFinalStop NNN \
-out_NT $i.formatted 

rm ${i}.tmp
rm ${i}_AA.tmp

done

```

```
