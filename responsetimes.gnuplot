set terminal 'pngcairo' size 1920, 1080
set output 'responsetimes.png'
set datafile separator ','
set font "Helvetica, 14"
set title "Average response time versus concurrency level" font "Helvetica, 24"
set xlabel 'Concurrency level (number of simultaneous users)' font "Helvetica, 14"
set ylabel 'Average response time (milliseconds, logarithmic scale)' font "Helvetica, 14"
set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5
set pointintervalbox 3
set grid
set xrange [10:300]
set logscale y
set yrange [10:1000000]
set xtics (0,20,40,60,80,100,120,140,160,180,200,220,240,260,280)
set style line 2 lc rgb '#900000' lt 1 lw 2 pt 7 pi -1 ps 1.5
set style line 3 lc rgb '#449990'
set style line 4 lc rgb '#009000' lt 1 lw 2 pt 7 pi -1 ps 1.5
set style line 5 lc rgb '#FF9999'
set style line 6 lc rgb '#44A0FF'
f(x) = a*x**b;
fit [50:100] f(x) "averages.csv" using 2:1 via a, b
g(x) = u*x**v;
fit g(x) "fastpages.csv" using 2:1 via u, v
i(x) = q*x**r;
fit i(x) "slowpages.csv" using 2:1 via q, r
plot "averages.csv" using 2:1 with linespoints ls 1 title 'Average response time' axes x1y1, \
  "slowpages.csv" using 2:1 with linespoints ls 2 title "Slowest pages" axes x1y1, \
  "fastpages.csv" using 2:1 with linespoints ls 4 title "Fastest pages" axes x1y1, \
  f(x) smooth csplines ls 6 title 'Average response time trend', \
  i(x) smooth csplines ls 5 title 'Slow pages trend', \
  g(x) smooth csplines ls 3 title 'Fastest pages trend'
