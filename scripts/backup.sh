#!/bin/bash
set -e

#Backup Controller Script
set -e

#format of file name
NOW=$(date +"%m-%d-%y")

function full-backup {
	echo "Preforming Full Backup!"
	tar cvzf $HOME/AutoCraft/backups/full/$NOW.tar.gz $HOME/AutoCraft
	echo "Done!"
	exit 1
}

function server-backup {
	echo "Server Backup!"
    tar cvzf $HOME/AutoCraft/backups/server/$NOW.tar.gz $HOME/AutoCraft/Servers
	
}

dialog --menu "Backup Options" 10 60 20  1 Full 2 Servers 2>$HOME/AutoCraft/resources/tmp/backup.tmp
 
if [ "$?" = "0" ]
then
        _return=$(cat $HOME/AutoCraft/resources/tmp/backup.tmp)
 
        if [ "$_return" = "1" ]
        then
        	echo "Full Backup"
        	full-backup
            exit 0
        fi
 
        if [ "$_return" = "2" ]
        then
        	echo "Server Backup"
            server-backup
            exit 0
        fi
else
        echo "Cancled"
fi

rm -f $HOME/AutoCraft/resources/tmp/backup.tmp
