
```{bash, eval=F}
cd /beegfs/data/merel/GND/ancov/

export GNUPLOT_DRIVER_DIR=/beegfs/home/merel/gnuplot-5.4.2/src
export GNUPLOT_PS_DIR=/beegfs/home/merel/gnuplot-5.4.2/term/PostScript/


gnuplot -e "set terminal postscript color;
set output 'trace.ps';

set multiplot layout 2,2;
set xrange [1:5000];
set xlabel '# points';

set ylabel 'logprob';
plot '1.trace' using 1, '2.trace' using 1;

set ylabel 'dim';
plot '1.trace' using 2, '2.trace' using 2;

set ylabel 'root_2';
plot '1.trace' using 5, '2.trace' using 5;

set ylabel 'root_4';
plot '1.trace' using 7, '2.trace' using 7;

unset multiplot;
set multiplot layout 2,2;
set xlabel '# points';

set ylabel 'sigma_0_6';
plot '1.trace' using 16, '2.trace' using 16;

set ylabel 'sigma_1_6';
plot '1.trace' using 22, '2.trace' using 22;

set ylabel 'sigma_6_7';
plot '1.trace' using 38, '2.trace' using 38;

set ylabel 'sigma_3_5';
plot '1.trace' using 30, '2.trace' using 30;

unset multiplot;
set multiplot layout 2,2;
set xlabel '# points';

set ylabel 'sigma_2_4';
plot '1.trace' using 25, '2.trace' using 25;

set ylabel 'sigma_5_10';
plot '1.trace' using 31, '2.trace' using 31;

set ylabel 'sigma_3_6';
plot '1.trace' using 21, '2.trace' using 40;

set ylabel 'diag1';
plot '1.trace' using 48, '2.trace' using 48;

"
#Warning: empty y range [8:8], adjusting to [7.92:8.08]

ps2pdf  trace.ps  trace.pdf
firefox trace.pdf


```
 