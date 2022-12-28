```bash
cd /beegfs/data/merel/GND/Alignments/ 
rm -r /beegfs/data/merel/GND/dN_dS/mapNH/Runs
mkdir -p /beegfs/data/merel/GND/dN_dS/mapNH/Runs

for Aln in Aln*fa
do

	mkdir -p /beegfs/data/merel/GND/dN_dS/mapNH/Runs/${Aln::-3}
  cp /beegfs/data/merel/GND/Alignments/$Aln  /beegfs/data/merel/GND/dN_dS/mapNH/Runs/${Aln::-3}/
  cp /beegfs/data/merel/GND/dN_dS/mapNH/Test/Tree.nwk /beegfs/data/merel/GND/dN_dS/mapNH/Runs/${Aln::-3}/
  
	echo '#!/bin/bash
#SBATCH --job-name='"${Aln::-3}"'
#SBATCH --partition=normal
#SBATCH --time=72:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --output=/beegfs/data/merel/GND/dN_dS/mapNH/Runs/'"${Aln::-3}"'/'"${Aln::-3}"'.out
#SBATCH --error=/beegfs/data/merel/GND/dN_dS/mapNH/Runs/'"${Aln::-3}"'/'"${Aln::-3}"'.err

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.local/lib

cd /beegfs/data/merel/GND/dN_dS/mapNH/Runs/'"${Aln::-3}"'

$HOME/.local/bin/bppml \
DATA='"${Aln::-3}"' \
param=../../base.bpp > base.log 
echo "Plop"
$HOME/.local/bin/mapnh \
DATA='"${Aln::-3}"' \
param=../../map_dNdS.bpp > mapnh.log 

' > /beegfs/data/merel/GND/dN_dS/mapNH/Runs/${Aln::-3}/${Aln::-3}.sh

sbatch /beegfs/data/merel/GND/dN_dS/mapNH/Runs/${Aln::-3}/${Aln::-3}.sh
done
```
