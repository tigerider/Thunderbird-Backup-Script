#!/usr/bin/env bash

START_TIME=$(date +%T) 
#!/usr/bin/env bash

# This is a simple, home-cooked script to back up my Thunderbird profile, compress it into a tar.gz archive.

# To be run from CLI while at the directory where you want to keep the archive

# start time for reporting upon completion of back-up
START_TIME=$(date +%T) 

echo -e "Started back-up:\t" $START_TIME "please be patient; this may take a while..."

#start a timer to count seconds until completion, via SECONDS, a built-in bash function 
SECONDS=0

# StdErr will be sent (appended) to ~/myScripts/yedekErr.log later, for now: send to null 
tar cpzf MailBackUp_$(date +%Y%m%d).tar.gz ~/.thunderbird/* 1> /dev/null  2>&1

# finish time for reporting upon completion of back-up
FINISH_TIME=$(date +%T)

#stop timer now!
elapsedTime=$SECONDS

sleep 1

# report stats: start time, finish time, duration
# Piping to "Tee" so results are sent to stdout and log file both
# Piping to "Tee" with -a allows APPENDING, not overwriting file contents
echo -e $(date +%F) "\t S:" $START_TIME "\t F:" $FINISH_TIME "\t T: $(( $elapsedTime / 60 )) min & $(( $elapsedTime % 60 )) s" | tee -a ~/myScripts/yedekle.log

sleep 1
BackupSize=$(du -h MailBackUp_$(date +%Y%m%d).tar.gz | cut -f 1)
echo "backup completed, "MailBackUp_$(date +%Y%m%d).tar.gz" was generated, file size is "$BackupSize
echo "exiting now..."
exit

########################### Feature wishlist ###########################
# 1. aynı adlı yedek dosyası var mı kontrol et; varsa uyarı çıkar
# (üstüne yazılacak)
# log dosyası belirtilen adreste (myScripts) var mı kontrol et, yoksa
# oluşturulacağını bildir

# 2. oluşturulan yedek dosyasının adını ve dosya boyutunu bildir - OK

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
