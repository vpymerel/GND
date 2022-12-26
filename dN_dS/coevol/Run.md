
```bash
cd /beegfs/data/merel/DTN/Alignments/ 
mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Runs

for Aln in Aln*fa
do

	mkdir -p /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}
  cp /beegfs/data/merel/DTN/Alignments/$Aln  /beegfs/data/merel/GND/dN_dS/coevol/Runs/${Aln::-3}/
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
-d ../'"$Aln"'.phy \
-t ../Tree.nwk \
-c /beegfs/data/merel/DTN/ancov_exp/Traits.exp.csv \
-dsom \
'"$Aln"'.'"$X"'
' > /beegfs/data/merel/DTN/Ne_omega/coevol/$Aln/$Aln.$X.sh
  
  sbatch /beegfs/data/merel/DTN/Ne_omega/coevol/$Aln/$Aln.$X.sh
  done
done

```
