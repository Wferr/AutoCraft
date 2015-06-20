#!/bin/bash
set -e
#Used to upgrade AutoCraft Scripts


echo "WARNING: UPGRADE IS IN TESTING STILL AND MAY CAUSE LOSS OF DATA"
echo "PLEASE PLEASE PLEASE BACKUP!"
echo "Reading config!"
sleep 10

echo "AutoCraft Updater"
echo "By pressing a key you accept the risk involved with upgrade!"
read -p "Press any Key to continue with upgrade!"

echo "Reding Config!"
source $HOME/AutoCraft/resources/config.conf

echo "AutoCraft Controller Software version: $controller-version !"
echo "AutoCraft Config Version: $config-version !"
echo "AutoCraft Updater Version: $updater-version !"

echo "Done!"
echo "Checking for updates!"

cd $HOME/AutoCraft/resources/tmp/
wget https://raw.githubusercontent.com/Wferr/AutoCraft/master/resources/config.conf

echo "Comparing Config Files!"

MD5_1=$(md5sum "$HOME/AutoCraft/resources/config.conf" | cut -d " " -f 1)
MD5_2=$(md5sum "$HOME/AutoCraft/resources/tmp/config.conf" | cut -d " " -f 1)

echo "Old config MD5 $MD5_1"
echo "New config MD5 $MD5_2"

if [ $MD5_1 == $MD5_2 ]
	then
	echo "AutoCraft is upto date!"
	echo "Cleaning TMP directory"
	rm $HOME/AutoCraft/resources/tmp/config.conf
	echo "Done!"
	exit 0
fi

echo "AutoCraft is out of date!"
echo "Downloading AutoCraft!"

cd $HOME/AutoCraft/resources/tmp/
git clone https://github.com/Wferr/AutoCraft.git
echo "Done!"

echo "Copying Changed Scripts!"

for line in $(cat $HOME/AutoCraft/resources/tmp/AutoCraft/scripts/)
do
	rm $($HOME/AutoCraft/$line)
	cp $($HOME/AutoCraft/resources/tmp/AutoCraft/$line) $($HOME/AutoCraft/$line)
done

echo "Done Copying Scripts!"

echo "Running Patch!"
sh $HOME/AutoCraft/scripts/upgrade/patch.sh

echo "Done!"
echo "Please visit GitHub to see the changelog!"