
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
'"${Aln::-3}"'.'"$X"'
' > /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/${Aln::-3}.$X.sh
  
  sbatch /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/${Aln::-3}.$X.sh
  done
done

```
