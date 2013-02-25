reset
set terminal pdf color font "0,10" size 5,5
set output 'output/commits.pdf'
set xlabel 'Revision'
set ylabel 'ms'
set grid y
set style data linespoints
set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi 0 ps 0.7
#set style line 2 lc rgb '#E62B17' lt 1 lw 2 pt 7 pi 0 ps 0.7
set style increment user
set rmargin 15 # Keep xtics within frame
set xtics nomirror rotate by -45
set xtics textcolor rgb '#6a6a6a'
set ytics textcolor rgb '#6a6a6a'
set key autotitle columnhead
plot [][2.7:7.1] 'data/commits.dat' using 2:xticlabel(1)
#plot [][2.9:3.5] 'data/commits.dat' using 2:xticlabel(1) index 0, \
#  '' using 2 index 1
# vim: set ft=gnuplot
