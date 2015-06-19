#!/bin/bash
set -e

dialog --menu "Update Options" 10 60 20  1 Both 2 Spigot 3 Bungee 2>$HOME/AutoCraft/resources/tmp/update.tmp
 
if [ "$?" = "0" ]
then
        _return=$(cat $HOME/AutoCraft/resources/tmp/update.tmp)
 
        if [ "$_return" = "1" ]
        then
        	echo "Updating Both"
        	sh $HOME/AutoCraft/scripts/bungee-update.sh
			sh $HOME/AutoCraft/scripts/spigot-update.sh
            exit 0
        fi
 
        if [ "$_return" = "2" ]
        then
        	echo "Updating Spigot"
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

rm -f $HOME/AutoCraft/resources/tmp/update.tmp