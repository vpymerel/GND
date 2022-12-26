
```{bash, eval=F}
mkdir /beegfs/data/merel/GND/ancov/

cd /beegfs/data/merel/GND/ancov/
#cleaning previous files if necessary
rm *chain *tab *tre *details *out *err *pdf *ps *sh *trace *run *monitor *csv *log *param

scp /home/vincent/gnd/ancov/Traits.csv merel@pbil-gates.univ-lyon1.fr:/beegfs/data/merel/GND/ancov

rm *chain *tab *tre *details *out *err *pdf *ps *sh *trace *run *monitor *log *param

for X in "1" "2"
do
  
  echo '#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4gb
#SBATCH -o /beegfs/data/merel/GND/ancov/'"$X"'.out
#SBATCH -e /beegfs/data/merel/GND/ancov/'"$X"'.err
#SBATCH --job-name='"$X"'
  
DIR=""
cd /beegfs/data/merel/GND/ancov/
  
/beegfs/home/merel/coevol/data/ancov \
-t /beegfs/data/merel/GND/dN_dS/mapNH/Test/Tree.nwk \
-c ./Traits.csv \
'"$X"'
' > /beegfs/data/merel/GND/ancov/$X.sh

sbatch /beegfs/data/merel/GND/ancov/$X.sh
   
done

```
 