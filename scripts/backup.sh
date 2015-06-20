#!/bin/bash
set -e

#Backup Controller Script

function full-backup {
	echo "Preforming Full Backup!"
	tar cvzf $HOME/AutoCraft/backups/full/$NOW.tar.gz $HOME/AutoCraft
	echo "Done!"
	exit 1
}

function server-backup {
	echo "Server Backup!"
	
}

dialog --menu "Backup Options" 10 60 20  1 Full 2 Servers 3 AutoCraft 2>$HOME/AutoCraft/resources/tmp/backup.tmp
 
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
            sh $HOME/AutoCraft/scripts/spigot-update.sh
            exit 0
        fi
 
        if [ "$_return" = "3" ]
        then
        	echo "Updating BungeeCord"
            sh $HOME/AutoCraft/scripts/bungee-update.sh
            exit 0
        fi
 
else
        echo "Cancled"
fi

rm -f $HOME/AutoCraft/resources/tmp/backup.tmp
