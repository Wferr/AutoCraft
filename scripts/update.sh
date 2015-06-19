#!/bin/bash
set -e

#Used to call Update Loop

function update-both {
sh $HOME/AutoCraft/scripts/bungee-update.sh
sh $HOME/AutoCraft/scripts/spigot-update.sh
}


dialog --menu "Update Options" 10 60 20  1 Both 2 Spigot 3 Bungee 2>temp
 
 
# OK is pressed
if [ "$?" = "0" ]
then
        _return=$(cat temp)
 
        if [ "$_return" = "1" ]
        then
                dialog --title "Updating Both" --msgbox "$(update-both)" 100 100
        fi
 
        if [ "$_return" = "2" ]
        then
                dialog --title "Updating Spigot" --msgbox "$(sh $HOME/AutoCraft/scripts/spigot-update.sh)" 100 100
        fi
 
        if [ "$_return" = "3" ]
        then
                dialog --title "Updating BungeeCord" --msgbox "$(sh $HOME/AutoCraft/scripts/bungee-update.sh)" 100 100
        fi
 
else
        echo "Cancled"
fi

rm -f temp