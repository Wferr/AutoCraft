#!/bin/bash
set -e
#This is used to build and package AutoCraft into its new format, allowing for it to be one script and not many.

mkdir $HOME/AutoCraft/new/
touch $HOME/AutoCraft/new/autocraft.sh

for FILE in $HOME/AutoCraft/resources/scripts/; do
	cat $FILE >> $HOME/AutoCraft/new/autocraft.sh
	echo "Added $FILE to AutoCraft!"
done
