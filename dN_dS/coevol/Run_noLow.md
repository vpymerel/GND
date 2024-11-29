This is just a test of stop-launch again

```bash
mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow
```

```r
#R tree pruner
library(ape)
tree <- read.tree("/beegfs/data/merel/GND/dN_dS/mapNH/Test/Tree.nwk")
toPrune <-c("Zgabonicus","Dnavojoa","Zafricanus","paulistrom","Dnasuta","Dalbomicans")
pruned.tree <- drop.tip(tree,tree$tip.label[match(toPrune, tree$tip.label)])
write.tree(pruned.tree, "/beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/PrunedTree.nwk")
```

```bash
for Aln in `ls /beegfs/data/merel/GND/Alignments/Aln*fa | xargs -n 1 basename | grep -v "bis"`
do

  mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/${Aln::-3}
  grep -v -E 'Zgabonicus|Dnavojoa|Zafricanus|paulistrom|Dnasuta|Dalbomicans' /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/${Aln::-3}.phy | sed 's/82/76/g' > /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/${Aln::-3}/${Aln::-3}.phy
  grep -v -E 'Zgabonicus|Dnavojoa|Zafricanus|paulistrom|Dnasuta|Dalbomicans' /beegfs/data/merel/GND/dN_dS/coevol/${Aln::-3}_Traits.csv | sed 's/82/76/g' > /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/${Aln::-3}/${Aln::-3}_Traits.csv
  cp /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/PrunedTree.nwk /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/${Aln::-3}/PrunedTree.nwk
done

for Aln in `ls /beegfs/data/merel/GND/Alignments/Aln*fa | xargs -n 1 basename | grep -v "bis"`
do

  for X in "1" "2"
  do
  
    echo '#!/bin/bash
#SBATCH --job-name='"${Aln::-3}"'.'"$X"'
#SBATCH --time=06:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=30gb
#SBATCH --output=/beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.out
#SBATCH --error=//beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.err

echo "Lets start !"

cd /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/'"${Aln::-3}"'

###Launch###
/beegfs/home/merel/coevol/data/coevol \
-f \
-d '"${Aln::-3}"'.phy \
-t PrunedTree.nwk \
-c '"${Aln::-3}"'_Traits.csv \
-dsom \
'"${Aln::-3}"'.'"$X"' &> coevol.'"$X"'.log &

sleep 1h
echo "###Stop after one hour###"
echo 0 > '"${Aln::-3}"'.'"$X"'.run
wc -l '"${Aln::-3}"'.'"$X"'.trace

echo "###Wait one hour and launch again###"
sleep 1h
wc -l '"${Aln::-3}"'.'"$X"'.trace
/beegfs/home/merel/coevol/data/coevol '"${Aln::-3}"'.'"$X"' &>> coevol.'"$X"'.log &

echo "###Stop after one hour###"
sleep 1h
echo 0 > '"${Aln::-3}"'.'"$X"'.run
wc -l '"${Aln::-3}"'.'"$X"'.trace

' > /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/${Aln::-3}/${Aln::-3}.$X.sh
  
  sbatch /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/${Aln::-3}/${Aln::-3}.$X.sh
done

#Investigating 6
cd /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/Aln6
#Looks ok  

  
```


  

```bash
mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow

for Aln in `ls /beegfs/data/merel/GND/Alignments/Aln*fa | xargs -n 1 basename | grep -v "bis"`
do

	mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/${Aln::-3}
  grep -v -E 'Zgabonicus|Dnavojoa|Zafricanus|paulistrom|Dnasuta|Dalbomicans' /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/${Aln::-3}.phy | sed 's/82/76/g' > /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/${Aln::-3}/${Aln::-3}.phy
  grep -v -E 'Zgabonicus|Dnavojoa|Zafricanus|paulistrom|Dnasuta|Dalbomicans' /beegfs/data/merel/GND/dN_dS/coevol/${Aln::-3}_Traits.csv | sed 's/82/76/g' > /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/${Aln::-3}/${Aln::-3}_Traits.csv
  cp /beegfs/data/merel/GND/dN_dS/coevol/Test_noLow/PrunedTree.nwk /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/${Aln::-3}/PrunedTree.nwk

done  


for Aln in `ls /beegfs/data/merel/GND/Alignments/Aln*fa | xargs -n 1 basename | grep -v "bis"`
do
  for X in "1" "2"
  do
  
    echo '#!/bin/bash
#SBATCH --job-name='"${Aln::-3}"'.'"$X"'
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=30gb
#SBATCH --output=/beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.out
#SBATCH --error=/beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.err
  
cd /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/'"${Aln::-3}"'
  
/beegfs/home/merel/coevol/data/coevol \
-f \
-d '"${Aln::-3}"'.phy \
-t PrunedTree.nwk \
-c '"${Aln::-3}"'_Traits.csv \
-dsom \
'"${Aln::-3}"'.'"$X"'  &> coevol.'"$X"'.log &

sleep 165h
echo "###Stop after 165 hours###"
echo 0 > '"${Aln::-3}"'.'"$X"'.run
wc -l '"${Aln::-3}"'.'"$X"'.trace

' > /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/${Aln::-3}/${Aln::-3}.$X.sh
  
  sbatch /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/${Aln::-3}/${Aln::-3}.$X.sh
  done
done

cp -r /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/ /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow_a
```

Let's add a few cycles ...

```bash

for Aln in `ls /beegfs/data/merel/GND/Alignments/Aln*fa | xargs -n 1 basename | grep -v "bis"`
do
  for X in "1" "2"
  do
  
    echo '#!/bin/bash
#SBATCH --job-name='"${Aln::-3}"'.'"$X"'
#SBATCH --time=84:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=30gb
#SBATCH --output=/beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.2.out
#SBATCH --error=/beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.2.err
  
cd /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/'"${Aln::-3}"'

echo "###Launch again###"
wc -l '"${Aln::-3}"'.'"$X"'.trace
/beegfs/home/merel/coevol/data/coevol '"${Aln::-3}"'.'"$X"' &>> coevol.'"$X"'.log &

echo "###Stop after 72 hour###"
sleep 72h
echo 0 > '"${Aln::-3}"'.'"$X"'.run
wc -l '"${Aln::-3}"'.'"$X"'.trace

' > /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/${Aln::-3}/${Aln::-3}.$X.2.sh
  
  sbatch /beegfs/data/merel/GND/dN_dS/coevol/Runs_noLow/${Aln::-3}/${Aln::-3}.$X.2.sh
  done
done

#Three jobs ""(launch failed requeued held)" (Aln3.1, Aln3.2 Aln30.1)
scancel -u merel
sbatch /beegfs/data/merel/GND/dN_dS/coevol/Runs/Aln3/Aln3.1.2.sh
sbatch /beegfs/data/merel/GND/dN_dS/coevol/Runs/Aln3/Aln3.2.2.sh
sbatch /beegfs/data/merel/GND/dN_dS/coevol/Runs/Aln30/Aln30.1.2.sh

"
```
