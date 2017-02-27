#!/usr/bin/env bash

START_TIME=$(date +%T) 
# start time for reporting upon completion of back-up

echo -e "Started back-up:\t" $START_TIME "please be patient; this may take a while..."

SECONDS=0
#start a timer to count seconds until completion, via SECONDS, a built-in function 

tar cpzf MailBackUp_$(date +%Y%m%d).tar.gz ~/.thunderbird/* 1> /dev/null  2>> $(pwd)/yedekErr.log

FINISH_TIME=$(date +%T)
# finish time for reporting upon completion of back-up

#stop timer now!
elapsedTime=$SECONDS

sleep 1

echo -e $(date +%F) "\t S:" $START_TIME "\t F:" $FINISH_TIME "\t T: $(( $elapsedTime / 60 )) min & $(( $elapsedTime % 60 )) s" | tee -a $(pwd)/yedekle.log

# report stats: start time, finish time, duration
# Piping to "Tee" so results are sent to stdout and log file both
# Piping to "Tee" with -a allows APPENDING, not overwriting file contents

sleep 1
echo "exiting now..."
exit

############################################################
# time formats:
# -u	: Pzt Oca 23 07:32:05 UTC 2017 # universal
# %R	: 24 hour format = %H:%M # okay, but no seconds
# %T	: 24 hour format = %H:%M:%S # okay, w' seconds 
# %X	: locale's time format = %H:%M:%S in my case # okay
# $(date +%F) : 2017-02-23 formatında
# kullan: $(date +%Y%m%d-%H%M%S) checked: 20170223-103359
# pigz option (no good, takes longer ?, bigger archive
# tar -pcf /media/basri/LaCie250G/TB_basri_ydk_$(date +%F).tar.gz ~/.thunderbird/* | pigz
############################################################
