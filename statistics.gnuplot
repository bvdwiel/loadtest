set terminal 'pngcairo' size 1920, 1080
set output 'statistics.png'
set datafile separator ','
set font "Helvetica, 14"
set title "Average response time versus concurrency level" font "Helvetica, 24"
set xlabel 'Concurrency level (number of simultaneous users)' font "Helvetica, 14"
set ylabel 'Average response time (ms.)' font "Helvetica, 14"
set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5
set pointintervalbox 3
set grid
set xrange [10:370]
set yrange [0:2000]
set xtics (0,20,40,60,80,100,120,140,160,180,200,220,240,260,280)
set ytics 500
set y2label "Error count"
set y2range [0:75]
set y2tics 10
set style line 2 lc rgb '#900000' lt 1 lw 2 pt 7 pi -1 ps 1.5
f(x) = a*x**b;
fit [50:100] f(x) "averages.csv" using 2:1 via a, b
g(x) = u*x**v;
fit g(x) "errorrate.csv" using 2:1 via u, v
plot "averages.csv" using 2:1 with linespoints ls 1 title 'Response time (y1)' axes x1y1, \
  "errorrate.csv" using 2:1 with linespoints ls 2 title "Error rate (y2)" axes x1y2, \
  f(x) with lines title sprintf('Response time trend f(x) = %.2f·x^{%.2f} (y2)',a, b), \
  g(x) with lines title sprintf('Error count trend f(x) = %.2g·x^{%.2g} (y2)',u, v) axes x1y2
