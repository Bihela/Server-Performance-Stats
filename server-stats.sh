#!/bin/bash
while :
do
	top_p_list=$(ps aux --sort -%cpu | head -n 6)

	cpuUsage=$(mpstat 1 1 | tail -n1 | awk '{printf "%d", int(100 - $NF)}')
	memFree=$(free -m | awk '/Mem/ {print ($7/$2) * 100}')
	memusedUsage=$(free -m | awk '/Mem/ {print ($3/$2) * 100}')
	dfUsage=$(df -m --total |awk '/total/ {print $5}')
	dfFree=$(df -m --total |awk '/total/ {print 100 - $5}')
	echo "CPU Usage: ${cpuUsage}%"
	echo "Memory Free:${memFree}%"
	echo "Memory Used Usage:${memusedUsage}%"
	echo "Disk Usage:${dfUsage}"
	echo "Disk Free:${dfFree}%"
	echo "\n----Top 5 processes by CPU ---\n "
	echo "${top_p_list}" | awk 'NR>1 {print $3}'
	echo "\n---Top 5 Processes by Memory ---\n"
	echo "${top_p_list}" | awk 'NR>1 {print $4}'

	sleep 1
done
