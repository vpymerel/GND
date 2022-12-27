
Getting rid of spaces, convert sequences characters to uppercase and cutting header if necessary.

```bash
mkdir -p /beegfs/data/merel/GND/Alignments/
cd /beegfs/data/merel/GND/Alignments/
nohup cp /beegfs/data/tricou/fly_annabelle/gene_families_hmmcleaner/*_NT-gb /beegfs/data/merel/GND/Alignments/ &> copy.log &

for i in /beegfs/data/merel/GND/Alignments/*_NT-gb;
do
  #Getting rid of spaces
  sed "s/ //g" $i > $i.formatted
  #To uppercase
  awk '/^>/ {print($0)}; /^[^>]/ {print(toupper($0))}' $i.formatted > tmp && mv tmp $i.formatted
  #Cutting header, e.g. teissieri_scaffold_0.g18.t1 to teissieri
  cut -f 1 -d '_' $i.formatted > tmp && mv tmp $i.formatted
done
```

MACSE pinpoints frameshifts using the "!" character (see https://bioweb.supagro.inra.fr/macse/index.php?menu=doc/programs/exportAlignment). This is not standard and need to be changed before running bpp and/or coevol. Internal frameshifts are replaced by "---" and those at sequence extremities by "-". Also stops codon are replaced by "NNN".

```bash


echo '#!/bin/bash

cd /beegfs/data/merel/GND/Alignments/

for i in /beegfs/data/merel/GND/Alignments/*_NT-gb;
do
  java -jar /beegfs/home/merel/macse_v2.03.jar \
-prog exportAlignment \
-align $i.formatted \
-codonForInternalFS --- \
-charForRemainingFS - \
-codonForInternalStop NNN \
-codonForFinalStop NNN \
-out_NT $i.formatted.noStop_noFS 

  rm ${i}_AA.formatted

done
' > exportAlignment.sh

nohup sh exportAlignment.sh &> exportAlignment.log & 




```


