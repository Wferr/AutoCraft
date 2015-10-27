#!/bin/bash
set -e
#Used to Update Spigot Suite

function compile-paperspigot {
echo "Creating Paper Spigot!"

cd $HOME/AutoCraft/resources/paperspigot

#Disableing git config for now.. Causes issues?
#git config --global --unset core.autocrlf
java -jar BuildTools.jar --rev latest
}

if [ ! -f $HOME/AutoCraft/resources/papespigot/BuildTools.jar ]
	then
	echo "BuildTools not found, Downloading!"
    cd $HOME/AutoCraft/resources/paperspigot/
    wget https://ci.destroystokyo.com/job/PaperSpigot-BuildTools/lastSuccessfulBuild/artifact/target/PaperTools.jar
    echo 'Done!'
    compile-paperspigot
    mv $HOME/AutoCraft/resources/paperspigot/paperspigot*.jar $HOME/AutoCraft/resources/jars/paperspigot.jar
fi

cd $HOME/AutoCraft/resources/tmp/
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

MD5_1=$(md5sum "$HOME/AutoCraft/resources/paperspigot/BuildTools.jar" | cut -d " " -f 1)
MD5_2=$(md5sum "$HOME/AutoCraft/resources/tmp/BuildTools.jar" | cut -d " " -f 1)

echo "Old MD5 $MD5_1"
echo "New MD5 $MD5_2"

if [ $MD5_1 != $MD5_2 ]
then
	echo "BuildTools is out of date! Copying over new BuildTools!"

	rm $Home/AutoCraft/resources/spigot/BuildTools.jar
	mv $HOME/AutoCraft/resources/tmp/BuildTools.jar $HOME/AutoCraft/resources/spigot/BuildTools.jar

	echo "Done!"
else
	echo "BuildTools is up to date!"   
fi
echo "Cleaning TMP directory!"
rm $HOME/AutoCraft/resources/tmp/BuildTools*

echo "Done!" 

compile-paperspigot

mv $HOME/AutoCraft/resources/paperspigot/paperspigot*.jar $HOME/AutoCraft/resources/tmp/paperspigot.jar

MD52_1=$(md5sum "$HOME/AutoCraft/resources/jars/paperspigot.jar" | cut -d " " -f 1)
MD52_2=$(md5sum "$HOME/AutoCraft/resources/tmp/paperspigot.jar" | cut -d " " -f 1)

if [ $MD52_1 != $MD52_2 ]
then
	echo "Paper Spigot is out of date! Copying over new Spigot!"

	if [ -f $HOME/AutoCraft/resources/jars/paperspigot.jar ]
		then
		echo "Old Paper Spigot Found. Deleteing!"
		rm $HOME/AutoCraft/resources/jars/paperspigot.jar
		echo "Done!"
	fi
	mv $HOME/AutoCraft/resources/tmp/paperspigot.jar $HOME/AutoCraft/resources/jars/paprspigot.jar

	echo "Done"

fi

echo "Done! Paper Spigot is upto date!"