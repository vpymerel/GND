
```{bash, eval=F}

cd /beegfs/data/merel/GND/ancov

wc -l 1.trace
#93183
wc -l 2.trace
#92651


~/coevol/data/readancov -x 30000 1 31000 1 > readancov.log

echo -e "GS\tDev\tDNA\tHelitron\tLINE\tLTR\tSINE\tAll\n" > 1.txt
grep 'posterior probs' -A 13 1.cov | head -n 11 >> 1.txt
grep 'correlation coefficients' -A 13 1.cov | head -n 11 >> 1.txt

column -t 1.txt


```
 