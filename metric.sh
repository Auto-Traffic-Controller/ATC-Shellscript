#!/bin/sh

while [ 1 ]
do
        #packet_count=`ifconfig | grep -n -A 1 "(Ethernet)" | grep "RX packets" | awk {'print $4'}`
        packet_size=`ifconfig | grep -n -A 1 "(Ethernet)" | grep "RX packets" | awk {'print $6'}`
        #cpu_idle=$(mpstat | tail -1 | awk {'print $13'})
	cpu_idle=`top -b -n1 | grep -Po '[0-9.]+ id' | awk {'print $1'} | head -1`
        #echo "{'cpu':${cpu_idle}, 'size':${packet_size}}" > metric.txt
	curl -H "Content-Type: application/json" -X POST -d '{"cpu":'${cpu_idle}'}' https://port-0-atc-server-4c7jj2blhelykyu.sel4.cloudtype.app/metric/cpu 2>/dev/null
	curl -H "Content-Type: application/json" -X POST -d '{"network":'${packet_size}'}' https://port-0-atc-server-4c7jj2blhelykyu.sel4.cloudtype.app/metric/network 2>/dev/null
        sleep 0.3
done
