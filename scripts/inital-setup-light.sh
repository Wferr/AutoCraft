#!/bin/bash
set -e
#Light install from dirty linux install

echo "Creating Directories!"

mkdir $HOME/AutoCraft/backups/
mkdir $HOME/AutoCraft/backups/full/
mkdir $HOME/AutoCraft/backups/servers
mkdir $HOME/AutoCraft/bungeecord/
mkdir $HOME/AutoCraft/resources/jars/
mkdir $HOME/AutoCraft/resources/spigot/
mkdir $HOME/AutoCraft/resources/tmp/
mkdir $HOME/AutoCraft/resources/plugins/
mkdir $HOME/AutoCraft/servers/
mkdir $HOME/AutoCraft/logs/

echo "Done!"
echo "Cleaning up!"

rm -r -rf $HOME/AutoCraft/.gitattributes
rm -r -rf $HOME/AutoCraft/.gitignore

echo "Done!"

echo "Changing Script permissions!"

chmod 770 $HOME/AutoCraft/scripts/* -R

echo "Done!"

echo "Building/Installing Jars!"

/$HOME/AutoCraft/scripts/bungee-update.sh
/$HOME/AutoCraft/scripts/spigot-update.sh
/$HOME/AutoCraft/scriptps/bungee-setup.sh

echo "Install finished!"
echo "Enjoy AutoCraft!"