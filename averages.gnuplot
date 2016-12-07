set terminal 'pngcairo' size 1920, 1080
set output 'averages.png'
set datafile separator ','
set title 'Average response time versus concurrency level'
set xlabel 'Concurrency level (number of simultaneous users)'
set ylabel 'Average response time (ms.)'
set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5
set pointintervalbox 3
set grid
set xrange [0:160]
set yrange [0:5000]
set xtics (0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160)
set ytics 500
plot "averages.csv" using 2:1 with linespoints ls 1 title 'Response time'
