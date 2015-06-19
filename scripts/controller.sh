#!/bin/bash
set -e

#Controller script

source $HOME/AutoCraft/scripts/update.sh
source $HOME/AutoCraft/scripts/backup.sh


#Controller script

echo "Reading config!"

source $HOME/AutoCraft/resources/config.conf

echo "AutoCraft Controller Software version: $controller-version!"
echo "AutoCraft Config Version: $config-version !"
echo "AutoCraft Spigot-Config Version: $spigot-config-version !"

PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice 3"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done