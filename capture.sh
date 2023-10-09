#!/bin/sh

while [ 1 ]
do	
	tshark -f "icmp or udp or tcp" -T json -a duration:5 >> data.json
done
