```bash
#for i in /beegfs/data/merel/DTN/Alignments/*noFS*; do echo $i; grep '>' $i | wc -l; done | grep -w 82 -B 1
#just find one aln with all species
#scp /home/vincent/DTN/Tree/root_droso_tree_MF \
merel@pbil-gates.univ-lyon1.fr:/beegfs/data/merel/GND/dN_dS/mapNH/Test/Tree.nwk

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.local/lib

mkdir -p /beegfs/data/merel/GND/dN_dS/mapNH/Test
cd /beegfs/data/merel/GND/dN_dS/mapNH/Test
cp /beegfs/data/merel/DTN/Alignments/FAM009998_NT-gb.formatted.noStop_noFS Test.fa

nohup $HOME/.local/bin/bppml \
DATA=Test \
param=../base.bpp &> base.log &
wait
nohup $HOME/.local/bin/mapnh \
DATA=Test \
param=../map_dNdS.bpp &> mapnh.log &
```
