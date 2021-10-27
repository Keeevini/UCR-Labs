#! /bin/bash
HOME=/root
LOG="${HOME}/lab2/uptime.log"
CHECK="${HOME}/lab2/checkfile.txt"
string=$(tail -n 1 $LOG)

if [ -f "$CHECK" ]; then
    if [[ "$string" =~ "found" ]]; then
        :
    else
        echo $(date)" - FILE \"$CHECK\" has been found" >> $LOG
        exit 1
    fi
else
    if [[ "$string" =~ "lost" ]]; then
        :
    else
        echo $(date)" - FILE \"$CHECK\" has been lost" >> $LOG
        exit 1
    fi
fi




# Reference used for making a cron job
# https://linuxhint.com/run_cron_job_every_minute/