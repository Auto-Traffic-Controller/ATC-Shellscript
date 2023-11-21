#!/bin/sh

while [ 1 ]
do	
	tshark -f "icmp or udp or tcp" -a duration:5 -T json -w /var/packet_data/data.json
done
