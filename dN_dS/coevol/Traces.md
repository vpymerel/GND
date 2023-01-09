
```{bash, eval=F}

cd /beegfs/data/merel/GND/dN_dS/coevol/Runs

export GNUPLOT_DRIVER_DIR=/beegfs/home/merel/gnuplot-5.4.2/src
export GNUPLOT_PS_DIR=/beegfs/home/merel/gnuplot-5.4.2/term/PostScript/

for Aln in Aln*
do

  cd  /beegfs/data/merel/GND/dN_dS/coevol/Runs/$Aln #!
  
  /beegfs/home/merel/coevol/data/tracecomp $Aln.1 $Aln.2 &> $Aln.tracecomp

  gnuplot -e "set terminal postscript color;
set output 'trace.ps';

set multiplot layout 2,2;
set xlabel '# points';

set ylabel 'log prior';
plot '$Aln.1.trace' using 1, '$Aln.2.trace' using 1;

set ylabel 'lnL';
plot '$Aln.1.trace' using 2, '$Aln.2.trace' using 2;

set ylabel 'length';
plot '$Aln.1.trace' using 3, '$Aln.2.trace' using 3;

set ylabel 'dN/dS';
plot '$Aln.1.trace' using 4, '$Aln.2.trace' using 4;

unset multiplot;
set multiplot layout 2,2;
set xlabel '# points';

set ylabel 'sigma_1_2';
plot '$Aln.1.trace' using 5, '$Aln.2.trace' using 5;

set ylabel 'sigma_2_5';
plot '$Aln.1.trace' using 22, '$Aln.2.trace' using 22;

set ylabel 'sigma_3_15';
plot '$Aln.1.trace' using 45, '$Aln.2.trace' using 45;

set ylabel 'sigma_3_5';
plot '$Aln.1.trace' using 35, '$Aln.2.trace' using 35;
"
  
  ps2pdf  trace.ps  trace.pdf
  cp trace.pdf $Aln.trace.pdf
  #firefox trace.pdf
  
done

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=traces.pdf */trace.pdf
scp merel@pbil-gates.univ-lyon1.fr:/beegfs/data/merel/GND/dN_dS/coevol/Runs/traces.pdf ~/gnd/dN_dS/coevol/


```
 