#!/bin/bash

echo -e "CO \t N \t Idle" > results1.dat

for i in {1..70}

do

	./loadtest $i &

	 #run load test for 6secs and collect idle time
	idle=`mpstat 6 1 -o JSON | jq '.sysstat.hosts[0].statistics[0]."cpu-load"[0].idle'`


	echo "idle:  $idle"  #verifying

	co=`cat synthetic.dat | wc -l`

	echo -e "$co \t $i \t $idle" >> results1.dat  #output to results.dat

	pkill loadtest  #kill loadtest
done
