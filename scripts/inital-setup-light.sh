#!/bin/bash
set -e
#Light install from dirty linux install

echo "Creating Directories!"

mkdir $HOME/AutoCraft/backups/full/
mkdir $HOME/bungeecord/
mkdir $HOME/resources/jars/
mkdir $HOME/resources/spigot/
mkdir $HOME/resources/tmp/
mkdir $HOME/resources/servers/

echo "Done"
echo "Cleaning up!"

rm -r -rf $HOME/AutoCraft/.gitattributes
rm -r -rf $HOME/AutoCraft/.gitignore

echo "Done!"

echo "Changing Script permissions!"

chmod 770 $HOME/AutoCraft/scripts/*

echo "Done!"

echo "Install finished!"
echo "Enjoy AutoCraft!"