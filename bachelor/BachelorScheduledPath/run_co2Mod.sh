#!bin/bash
mkdir results
../cd++ -m"bachelor.ma" -l"results/in.log" -t00:04:00:000
cp results/in.log01 ./in.log
rm -r results

