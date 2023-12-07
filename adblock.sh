#!/bin/bash
# You are NOT allowed to change the files' names!
domainNames="domainNames.txt"
IPAddresses="IPAddresses.txt"
adblockRules="adblockRules"

function ProgressBar {
# Process data
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
# Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:                           
# 1.2.1.1 Progress : [########################################] 100%
printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"

}

function adBlock() {
    if [ "$EUID" -ne 0 ];then
        printf "Please run as root.\n"
        exit 1
    fi
    if [ "$1" = "-domains"  ]; then
        failed_domains=""
        i=0
        end=$(wc -l < "$domainNames")
        echo 'Converting Domain names to IP addresses...'
        # Configure adblock rules based on the domain names of $domainNames file.
        while IFS= read -r domain
        do
            ((i++))
            # Resolve the domain to an IP address using nslookup
            ip_address=$(nslookup "$domain" | awk '/^Address: / { print $2 }')

            # Save the IP address to the file
            if [ -n "$ip_address" ]; then
            echo "$ip_address" >> "$IPAddresses"
            else
            failed_domains+=" $domain"
            fi
            sleep 0.1
            ProgressBar ${i} ${end}
        done < "$domainNames"

        if [ -n "$failed_domains" ]; then
          echo "Process Finished! However failed to find ip for the following domains:$failed_domains"
        else
          echo "Process Finished!"
        fi
        true
            
    elif [ "$1" = "-ips"  ]; then
        # Configure adblock rules based on the IP addresses of $IPAddresses file.
        # Write your code here...
        # ...
        # ...
        true
        
    elif [ "$1" = "-save"  ]; then
        # Save rules to $adblockRules file.
        sudo iptables-save > "$adblockRules"
        true
        
    elif [ "$1" = "-load"  ]; then
        # Load rules from $adblockRules file.
        sudo iptables-restore < "$adblockRules"
        true

        
    elif [ "$1" = "-reset"  ]; then
        # Reset rules to default settings (i.e. accept all).
        # Write your code here...
        # ...
        # ...
        true

        
    elif [ "$1" = "-list"  ]; then
        # List current rules.
        sudo iptables -L -n -v
        true
        
    elif [ "$1" = "-help"  ]; then
        printf "This script is responsible for creating a simple adblock mechanism. It rejects connections from specific domain names or IP addresses using iptables.\n\n"
        printf "Usage: $0  [OPTION]\n\n"
        printf "Options:\n\n"
        printf "  -domains\t  Configure adblock rules based on the domain names of '$domainNames' file.\n"
        printf "  -ips\t\t  Configure adblock rules based on the IP addresses of '$IPAddresses' file.\n"
        printf "  -save\t\t  Save rules to '$adblockRules' file.\n"
        printf "  -load\t\t  Load rules from '$adblockRules' file.\n"
        printf "  -list\t\t  List current rules.\n"
        printf "  -reset\t  Reset rules to default settings (i.e. accept all).\n"
        printf "  -help\t\t  Display this help and exit.\n"
        exit 0
    else
        printf "Wrong argument. Exiting...\n"
        exit 1
    fi
}

adBlock $1
exit 0