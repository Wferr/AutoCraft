#!/bin/bash
set -e

#Controller script

echo "Reading config!"

source $HOME/AutoCraft/resources/config.conf

echo "AutoCraft Controller Software version: $controller_version!"
echo "AutoCraft Config Version: $config_version !"
echo "AutoCraft Updater Version: $updater_version !"
sleep 1

PS3='Please enter your choice: '
options=("Start Servers" "Update Jars" "Add Server" "Delete Server" "Backup Server" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Start Servers")
			echo "Starting Servers!"
			/$HOME/AutoCraft/scripts/startup.sh
			break
			;;
		"Update Jars")
			echo "Updating Jars!"
			/$HOME/AutoCraft/scripts/update.sh
			break
			;;
		"Add Server")
			echo "Adding Server!"
			/$HOME/AutoCraft/scripts/spigot-addserver.sh
			break
			;;
		"Delete Server")
			echo "Deleting Server!"
			/$HOME/AutoCraft/scripts/spigot-removeserver.sh
			break
			;;
		"Backup Server")
			echo "Backing up Server!"
			/$HOME/AutoCraft/scripts/backup.sh
			break
			;;
		"Quit")
			break
			;;
		*) echo invalid option;;
    esac
done