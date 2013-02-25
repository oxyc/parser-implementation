reset
set terminal pdf color font "0,10"
set output 'output/parsers.pdf'
set boxwidth 0.5
set ylabel 'ms'
set xlabel 'Parser'
set style line 1 lc rgb '#0060ad'
set style fill solid
set xtics nomirror rotate by -25
set xtics textcolor rgb '#6a6a6a'
set ytics textcolor rgb '#6a6a6a'
unset key
plot[][0:205] 'data/parsers.dat' using 3:xticlabel(2) with boxes ls 1 notitle, \
  'data/parsers.dat' using 1:($3+6):3 with labels
# vim: set ft=gnuplot
