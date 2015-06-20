#!/bin/bash
set -e

#Controller script

echo "Reading config!"

source $HOME/AutoCraft/resources/config.conf

echo "AutoCraft Controller Software version: $controller-version!"
echo "AutoCraft Config Version: $config-version !"
echo "AutoCraft Updater Version: $updater-version !"
sleep 5

PS3='Please enter your choice: '
options=("Update Jars" "Add Server" "Delete Server" "Backup Server" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Update Jars")
            echo "Updating Jars!"
            sh $HOME/AutoCraft/scripts/update.sh
            break
            ;;
        "Add Server")
            echo "Adding Server!"
            sh $HOME/AutoCraft/scripts/spigot-addserver.sh
            break
            ;;
        "Delete Server")
            echo "Deleting Server!"
            sh $HOME/AutoCraft/scripts/spigot-removeserver.sh
            break
            ;;
        "Backup Server")
            echo "Backing up Server!"
            sh $HOME/AutoCraft/scripts/backup.sh
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done