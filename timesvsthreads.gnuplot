set terminal 'pngcairo' size 1920, 1080
set output 'timesvsthreads.png'
set datafile separator ','
set font "Helvetica, 14"
set title "Average response time vs. concurrency\nhttps://staging.tudelft.nl/" font "Helvetica, 24"
set xlabel 'Concurrency level (number of simultaneous users)' font "Helvetica, 14"
set ylabel 'Average response time (ms.)' font "Helvetica, 14"
set y2label 'Number of requests handled per second.' font "Helvetica, 14"
set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5
set style line 2 lc rgb '#44A4FF'
set style line 3 lc rgb '#60ad00' lt 1 lw 2 pt 7 pi -1 ps 1.5
set style line 4 lc rgb '#A4FF44'
set style line 5 lc rgb '#ad0060' lt 1 lw 2 pt 7 pi -1 ps 1.5
set style line 6 lc rgb '#FF44A4'
set pointintervalbox 3
set grid
set xrange [10:280]
set yrange [10:15000]
set ytics 1000
set xtics (0,20,40,60,80,100,120,140,160,180,200,220,240,260,280)
set y2range [0:250]
set y2tics 10
f(x) = a*x**b;
fit f(x) "averages.csv" using 2:1 via a, b
g(x) = u*x**v;
fit g(x) "reqspersecond.csv" using 2:1 via u, v
h(x) = l*x**m;
fit h(x) "failcount.csv" using 2:1 via l, m
plot "averages.csv" using 2:1 with linespoints ls 1 title 'Average response time measured (y1)' axes x1y1, \
  "reqspersecond.csv" using 2:1 with linespoints ls 3 title 'Transactions per second (y2)' axes x1y2, \
  "failcount.csv" using 2:1 with linespoints ls 5 title 'Failed transactions per second (y2)' axes x1y2, \
  f(x) smooth csplines ls 2 title 'Average response time trendline (y1)', \
  g(x) smooth csplines ls 4 title 'Transactions per seconds trend (y2)' axes x1y2, \
  h(x) smooth csplines ls 6 title 'Failed transactions per second trend (y2)' axes x1y2
