#!/bin/bash
set -e

dialog --menu "Update Options" 10 60 20  1 Both 2 Spigot 3 Bungee 2>temp
 
if [ "$?" = "0" ]
then
        _return=$(cat temp)
 
        if [ "$_return" = "1" ]
        then
        	echo "Updating Both"
        	sh $HOME/AutoCraft/scripts/bungee-update.sh
			sh $HOME/AutoCraft/scripts/spigot-update.sh
        fi
 
        if [ "$_return" = "2" ]
        then
        	echo "Updating Spigot"
            sh $HOME/AutoCraft/scripts/spigot-update.sh
        fi
 
        if [ "$_return" = "3" ]
        then
        	echo "Updating BungeeCord"
            sh $HOME/AutoCraft/scripts/bungee-update.sh
        fi
 
else
        echo "Cancled"
fi

rm -f temp