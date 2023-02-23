This is just a test of stop-launch again

```bash
cd /beegfs/data/merel/GND/Alignments/ 
mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Test

Aln="Aln17.fa"

mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Test/${Aln::-3}
cp /beegfs/data/merel/GND/Alignments/${Aln::-3}.phy  /beegfs/data/merel/GND/dN_dS/coevol/Test/${Aln::-3}/
cp /beegfs/data/merel/GND/dN_dS/mapNH/Test/Tree.nwk /beegfs/data/merel/GND/dN_dS/coevol/Test/${Aln::-3}/
  
for X in "1" "2"
do
  
    echo '#!/bin/bash
#SBATCH --job-name='"${Aln::-3}"'.'"$X"'
#SBATCH --time=06:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=30gb
#SBATCH --output=/beegfs/data/merel/GND/dN_dS/coevol/Test/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.out
#SBATCH --error=/beegfs/data/merel/GND/dN_dS/coevol/Test/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.err

echo "Lets start !"

cd /beegfs/data/merel/GND/dN_dS/coevol/Test/'"${Aln::-3}"'

###Launch###
/beegfs/home/merel/coevol/data/coevol \
-f \
-d '"${Aln::-3}"'.phy \
-t Tree.nwk \
-c /beegfs/data/merel/GND/dN_dS/coevol/'"${Aln::-3}"'_Traits.csv \
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

' > /beegfs/data/merel/GND/dN_dS/coevol/Test/${Aln::-3}/${Aln::-3}.$X.sh
  
  sbatch /beegfs/data/merel/GND/dN_dS/coevol/Test/${Aln::-3}/${Aln::-3}.$X.sh
done

  
  
```


```bash
cd /beegfs/data/merel/GND/Alignments/ 
mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Runs

for Aln in Aln*fa
do

	mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}
  cp /beegfs/data/merel/GND/Alignments/${Aln::-3}.phy  /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/
  cp /beegfs/data/merel/GND/dN_dS/mapNH/Test/Tree.nwk /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/
  
  for X in "1" "2"
  do
  
    echo '#!/bin/bash
#SBATCH --job-name='"${Aln::-3}"'.'"$X"'
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=30gb
#SBATCH --output=/beegfs/data/merel/GND/dN_dS/coevol/Runs/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.out
#SBATCH --error=/beegfs/data/merel/GND/dN_dS/coevol/Runs/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.err
  
cd /beegfs/data/merel/GND/dN_dS/coevol/Runs/'"${Aln::-3}"'
  
/beegfs/home/merel/coevol/data/coevol \
-f \
-d '"${Aln::-3}"'.phy \
-t Tree.nwk \
-c /beegfs/data/merel/GND/dN_dS/coevol/'"${Aln::-3}"'_Traits.csv \
-dsom \
'"${Aln::-3}"'.'"$X"'  &> coevol.'"$X"'.log &

sleep 165h
echo "###Stop after 165 hours###"
echo 0 > '"${Aln::-3}"'.'"$X"'.run
wc -l '"${Aln::-3}"'.'"$X"'.trace

' > /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/${Aln::-3}.$X.sh
  
  sbatch /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/${Aln::-3}.$X.sh
  done
done

```

Let's add a few cycles ...

```bash
cd /beegfs/data/merel/GND/Alignments/ 

for Aln in Aln*fa
do

  for X in "1" "2"
  do
  
    echo '#!/bin/bash
#SBATCH --job-name='"${Aln::-3}"'.'"$X"'
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=30gb
#SBATCH --output=/beegfs/data/merel/GND/dN_dS/coevol/Runs/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.2.out
#SBATCH --error=/beegfs/data/merel/GND/dN_dS/coevol/Runs/'"${Aln::-3}"'/'"${Aln::-3}"'.'"$X"'.2.err
  
cd /beegfs/data/merel/GND/dN_dS/coevol/Runs/'"${Aln::-3}"'

echo 0 > '"${Aln::-3}"'.'"$X"'.run

/beegfs/home/merel/coevol/data/coevol \
-d '"${Aln::-3}"'.phy \
-t Tree.nwk \
-c /beegfs/data/merel/GND/dN_dS/coevol/'"${Aln::-3}"'_Traits.csv \
-dsom \
'"${Aln::-3}"'.'"$X"'
' > /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/${Aln::-3}.$X.2.sh
  
  sbatch /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/${Aln::-3}.$X.2.sh
  done
done

```
