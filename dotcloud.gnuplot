set terminal 'pngcairo' size 1920, 1080
set output 'dotcloud.png'
set font "Helvetica, 14"
set datafile separator ","
set title "Website stresstest raw results\nhttps://staging.tudelft.nl/" font "Helvetica, 24"
set ylabel "Response time in seconds"
set xlabel "Time"
set xdata time
set ytics 2
set timefmt "%Y-%m-%d %H:%M:%S"
set grid
plot "dotcloud.csv" using 2:1 with points title "Response time"
