
```{bash, eval=F}

cd /beegfs/data/merel/GND/dN_dS/mapNH/Runs

for Aln in Aln*
do
  
  cd  /beegfs/data/merel/GND/dN_dS/mapNH/Runs/$Aln #!
  
  #proxy categ p cc Aln
  Rscript ../Format.R $Aln
done

cd /beegfs/data/merel/GND/dN_dS/mapNH/Runs
cat */df.csv > df.csv
scp merel@pbil-gates.univ-lyon1.fr:/beegfs/data/merel/GND/dN_dS/mapNH/Runs/df.csv ~/gnd/dN_dS/mapNH/
grep -v Aln30 ~/gnd/dN_dS/mapNH/df.csv > tmp && mv tmp ~/gnd/dN_dS/mapNH/df.csv  
```