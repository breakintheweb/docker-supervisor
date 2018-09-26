# Docker Supervisor delay start
A docker showing process delayed start with supervisor

## Motivation
By default, supervisor doesn't (easily) have a way to delay the starting of processes or ensure a process is running before moving on to starting the next. There are events available, and some people have added this functionality via a fork but I was looking for something sipmler. I also wanted to have an init script that reliably ran before all services start.

## Overview
This is a sample docker container with two running services nginx, and openssh. When the docker is started, the init.sh script in /etc/supervisor will autostart. Inside this script you can place any code you want to execute prior to starting the services. Once these tasks are run, the script will start the services defined in /etc/supervisor/conf.d based on their configured priority. The script will wait for each process to show a 'running' status in supervisorctl before starting the next. 

### Requirements
* All services need to be set to autostart=false
* All services need to be defined with a priority 2-999 (1 is reserved init.sh)
* All services need to be defined in /etc/services/conf.d and end with a .conf suffix
