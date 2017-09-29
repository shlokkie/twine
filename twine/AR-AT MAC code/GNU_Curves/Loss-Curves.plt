set term postscript noenhanced color dashed eps font ",18"


# output filename
set output 'Loss-Curves.eps'
set key top right;

# set labels next to axis
set xlabel 'Time (seconds)'
set ylabel 'Accuracy Loss (%)'

set logscale x 10

set format x "1e+%L";
set xtics (1,10,100,1000,10000, 100000)

set xrange [1:100000]

file_in = 'Loss-Curves.csv'

# removes tics from top
set xtics nomirror

# Input file contains comma-separated values fields
set datafile separator ","

plot file_in using 1:2 with steps title column(2) lt 3 lc rgb "red" lw 7 dashtype 3 , \
     file_in using 1:3 with steps title column(3) lt 1 lc rgb "black"   lw 3 , \
     file_in using 1:4 with steps title column(4) lt 3 lc rgb "green" lw 7 dashtype 3 ,  \
     file_in using 1:5 with steps title column(5) lt 1 lc rgb "blue" lw 7 dashtype 3;

set output
