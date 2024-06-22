#!/bin/bash

MONITORED_DIR="/home/pruthvibhat/dummyMonitor"
BACKUP_DIR="/home/pruthvibhat/dummyBackup"
THRESHOLD=5
LOG_FILE="disk_usage_alert.log"

send_alert() {
    local message=$1
    echo "$(date): ALERT - $message" >> $LOG_FILE
    echo "ALERT: $message"
}


compress_files() {
    local source_dir=$1
    local backup_dir=$2
    local timestamp=$(date +"%Y%m%d%H%M%S")
    local backup_file="${backup_dir}/backup_${timestamp}.tar.gz"
    
    tar -czf $backup_file -C $source_dir .
    if [ $? -eq 0 ]; then
        send_alert "Files from $source_dir have been compressed and moved to $backup_file."
    else
        send_alert "Failed to compress files from $source_dir."
    fi
}

check_disk_usage() {
    local dir=$1
    local usage=$(df -h $dir | awk 'NR==2 {print $5}' | sed 's/%//g')
    
    if [ $usage -gt $THRESHOLD ]; then
        send_alert "Disk usage for $dir has exceeded the threshold of $THRESHOLD%. Current usage: $usage%."
        compress_files $dir $BACKUP_DIR
    else
        echo "$(date): Disk usage for $dir is within the limit. Current usage: $usage%." >> $LOG_FILE
    fi
}


mkdir -p $BACKUP_DIR

check_disk_usage $MONITORED_DIR
