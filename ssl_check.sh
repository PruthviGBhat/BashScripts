#!/bin/bash

websites=("https://google.com" "https://youtube.com" "https://facebook.com")


log_file="ssl_check.log"

send_notification() {
    local website=$1
    local message=$2
    echo "Notification: $message for $website" 
}


check_ssl_certificate() {
    local website=$1
    local domain=$(echo $website | awk -F/ '{print $3}')

    
    local cert_info=$(echo | openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -dates -issuer)
    
    if [ -z "$cert_info" ]; then
        echo "$(date): Unable to retrieve SSL certificate for $website" >> $log_file
        send_notification $website "Unable to retrieve SSL certificate"
        return
    fi
    
    local expiry_date=$(echo "$cert_info" | grep 'notAfter=' | cut -d= -f2)
    local issuer=$(echo "$cert_info" | grep 'issuer=' | cut -d= -f2)

    if [ -z "$expiry_date" ] || [ -z "$issuer" ]; then
        echo "$(date): Invalid SSL certificate for $website" >> $log_file
        send_notification $website "Invalid SSL certificate"
        return
    fi

   
    local days_left=$(( ( $(date -d "$expiry_date" +%s) - $(date +%s) ) / 86400 ))

    
    echo "$(date): SSL certificate for $website issued by $issuer, expires on $expiry_date (in $days_left days)" >> $log_file

    
    if [ $days_left -lt 30 ]; then
        echo "$(date): Warning: SSL certificate for $website is expiring in $days_left days" >> $log_file
        send_notification $website "SSL certificate is expiring in $days_left days"
    fi
}


for website in "${websites[@]}"; do
    check_ssl_certificate $website &
done

wait

echo "SSL certificate check completed."
