#!/bin/bash
#******************************************************************************
#* Supervisord priority start
#* https://github.com/breakintheweb/docker-supervisor
#**
#*   Add any code you want to run before starting services here
#**
#******************************************************************************


#******************************************************************************
#**
#*   Process supervisor conf files and start them based on their priority
#**
#******************************************************************************
declare -A programs
for file in /etc/supervisor/conf.d/*.conf
do
	program_name=$(cat $file | cut -d "[" -f2 | cut -d "]" -f1 | awk -F: -v key="program" '$1==key {print $2}')
	program_priority=$(cat $file | awk -F= -v key="priority" '$1==key {print $2}')
	programs[$program_priority]=$program_name
done
## Since bash arrays are unordered, we loop through all 1000 priorities and trigger on a match
for ((i = 0; i<1000; i++))
do
	if [ "${programs[$i]}" != "" ]
	then
		## loop until process shows running
		supervisorctl start "${programs[$i]}"
		while [ `supervisorctl status "${programs[$i]}" | awk -F ' ' '{print $2}'` != "RUNNING" ]; do sleep 0.2; done
	fi
done





