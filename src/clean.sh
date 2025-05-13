#!/bin/bash

# This script is used to clean up the environment by removing all files and directories
# that are not part of the system. It is intended to be run as a cron job.
LOG_FILE="/var/log/syscleaner.log"
BACKUP_DIR="/var/backups/syscleaner"
DEBUG=false


logMessage() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$LOG_FILE"
    [ "$DEBUG" = true ] && echo "[$timestamp] $message"
}

checkRoot() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
        exit 1
    fi
}

cleanupPackages() {
    logMessage "Updating package lists..."
    apt-get update
    
    logMessage "Upgrading packages..."
    apt-get upgrade -y
    
    logMessage "Removing unused packages..."
    apt-get autoremove -y
    apt-get autoclean -y
}

cleanupKernels() {
    logMessage "Removing old kernels..."
    dpkg -l 'linux-image*' | awk '{ print $2 }' | grep -v $(uname -r) | xargs apt-get -y purge
}

cleanupLogs() {
    logMessage "Cleaning system logs..."
    find /var/log -type f -name "*.log" -delete
}

cleanupCache() {
    logMessage "Cleaning user caches..."
    find /home/*/.cache/thumbnails -type f -delete
    find /home/*/.local/share/Trash -type f -delete
}

showStatus() {
    logMessage "Displaying system status..."
    df -h
    free -h
}

main() {
    checkRoot
    
    mkdir -p $(dirname "$LOG_FILE")
    
    logMessage "Starting system cleanup..."
    
    cleanupPackages
    cleanupKernels
    cleanupLogs
    cleanupCache
    
    logMessage "Cleanup completed!"
    showStatus
}

main "$@"