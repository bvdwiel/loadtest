set terminal 'pngcairo' size 1920, 1080
set output 'statistics.png'
set datafile separator ','
set title 'Average response time versus concurrency level'
set xlabel 'Concurrency level (number of simultaneous users)'
set ylabel 'Average response time (ms.)'
set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5
set pointintervalbox 3
set grid
set xrange [40:110]
set yrange [0:3000]
set xtics (0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190.200,210)
set ytics 500
set y2label "Error count"
set y2range [0:80]
set y2tics 10
set style line 2 lc rgb '#900000' lt 1 lw 2 pt 7 pi -1 ps 1.5
f(x) = a*x**b;
fit [50:100] f(x) "averages.csv" using 2:1 via a, b
g(x) = u*x**v;
fit g(x) "errorrate.csv" using 2:1 via u, v
plot "averages.csv" using 2:1 with linespoints ls 1 title 'Response time (y1)' axes x1y1, "errorrate.csv" using 2:1 with linespoints ls 2 title "Error rate (y2)" axes x1y2, f(x) with lines title "Response time trend (y1)", g(x) with lines title "Error rate trend (y2)" axes x1y2
