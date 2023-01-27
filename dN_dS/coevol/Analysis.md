
```{bash, eval=F}

cd /beegfs/data/merel/GND/dN_dS/coevol/Runs

for Aln in Aln*
do
  
  cd  /beegfs/data/merel/GND/dN_dS/coevol/Runs/$Aln #!
  
  for X in "1" "2"
  do
  
    ~/coevol/data/readcoevol  +mean -x 300 1 1300 $Aln.$X > $Aln.$X.log
    
  done
done

# Formatting

cd /beegfs/data/merel/GND/dN_dS/coevol/Runs
echo -e "dS\tomega\tGS\tDev\tDNA\tHelitron\tLINE\tLTR\tSINE\tTEs\tENCprime\tSCUO" > rownames.txt
echo -e ".\.\ndS\nomega\nGS\nDev\nDNA\nHelitron\nLINE\nLTR\nSINE\nTEs\nENCprime\nSCUO\n" > colnames.txt

cd /beegfs/data/merel/GND/dN_dS/coevol/Runs

for Aln in Aln*
do
  
  cd  /beegfs/data/merel/GND/dN_dS/coevol/Runs/$Aln #!
  cat ../rownames.txt > pp.csv
  cat ../rownames.txt > cc.csv

  grep 'posterior probs' -A 13 $Aln.1.cov | head -n 14 | tail -n 12 >> pp.csv
  grep 'correlation coefficients' -A 13 $Aln.1.cov | head -n 14 | tail -n 12 >> cc.csv

  paste ../colnames.txt pp.csv > tmp && mv tmp pp.csv
  paste ../colnames.txt cc.csv > tmp && mv tmp cc.csv

  #Keeping Y, then X
  cut -f 1,4,6,7,8,9,10,11 pp.csv | awk '{if ($1==".\\." || $1=="omega" || $1=="Dev" || $1=="ENCprime" || $1=="SCUO") print $0}' > tmp && mv tmp pp.csv
  cut -f 1,4,6,7,8,9,10,11 cc.csv | awk '{if ($1==".\\." || $1=="omega" || $1=="Dev" || $1=="ENCprime" || $1=="SCUO") print $0}' > tmp && mv tmp cc.csv

  #proxy categ pp cc Aln 
  Rscript ../Format.R $Aln
  
  #Adding min, max, median GC3
  GC3=`Rscript /beegfs/data/merel/GND/Alignments/get_GC3.R /beegfs/data/merel/GND/Alignments/$Aln.txt`
  Min=`echo $GC3 | cut -f 2 -d ' '`
  Max=`echo $GC3 | cut -f 3 -d ' '`
  Median=`echo $GC3 | cut -f 4 -d ' '`

  awk -v Min=$Min \
  -v Max=$Max \
  -v Median=$Median '{print $0" "Min" "Max" "Median}'   df.csv > tmp && mv tmp df.csv
done

cd /beegfs/data/merel/GND/dN_dS/coevol/Runs
cat */df.csv > df.csv

scp merel@pbil-gates.univ-lyon1.fr:/beegfs/data/merel/GND/dN_dS/coevol/Runs/df.csv ~/gnd/dN_dS/coevol/
grep -v Aln30 ~/gnd/dN_dS/coevol/df.csv > tmp && mv tmp ~/gnd/dN_dS/coevol/df.csv

```{r, eval=F}
df <- read.table("~/gnd/dN_dS/coevol/df.csv", quote="\"", comment.char="")
colnames(df) <- c("proxy","categ","pp","cc","Aln","min_GC3","max_GC3","median_GC3")

#No Random (i.e. Aln > )

Random_list <- paste("Aln",20:29,collapse=NULL, sep="")

df <- df %>%
  mutate(concat=ifelse(grepl(paste(Random_list,collapse='|'),Aln),"Random","NotRandom")) %>%
  mutate(significant=ifelse(pp>0.975,"pp>0.975",
  ifelse(pp>0.95,"pp>0.95","ns")))
library(ggplot2)
ggplot(df[df$concat!="Random",], aes(x=median_GC3, y=cc, color=significant)) + 
  geom_point() + 
  facet_grid(proxy~categ) +
  theme_bw()
  
  
ggplot(df[df$concat=="Random",], aes(x=median_GC3, y=cc, color=significant)) + 
  geom_point() + 
  facet_grid(proxy~categ) +
  theme_bw()
```

# Adding GC, min, max, median
echo "Aln0 0.309 0.516 0.457
Aln1
Aln2
Aln3
Aln4
Aln5
Aln6
Aln7
Aln8
Aln9
Aln10
Aln11
Aln12
Aln13
Aln14
Aln15
Aln16
Aln17
Aln18
Aln19
Aln20
Aln21
Aln22
Aln23
Aln24
Aln25
Aln26
Aln27
Aln28
Aln29"


cd /beegfs/data/merel/GND/dN_dS/coevol/Runs



```
 
 