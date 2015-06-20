#!/bin/bash
set -e
#Used to Update Spigot Suite

function compile-spigot {
echo "Creating Spigot!"

cd $HOME/AutoCraft/resources/spigot

git config --global --unset core.autocrlf
java -jar BuildTools.jar --rev latest
}

if [ ! -f $HOME/AutoCraft/resources/spigot/BuildTools.jar ]
	then
    echo "BuildTools not found, Downloading!"
    cd $HOME/AutoCraft/resources/spigot/
    wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
    echo 'Done!'
    compile-spigot
    mv $HOME/AutoCraft/resources/spigot/spigot*.jar $HOME/AutoCraft/resources/jars/Spigot.jar

fi

cd $HOME/AutoCraft/resources/tmp/
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

MD5_1=$(md5sum "$HOME/AutoCraft/resources/spigot/BuildTools.jar" | cut -d " " -f 1)
MD5_2=$(md5sum "$HOME/AutoCraft/resources/tmp/BuildTools.jar" | cut -d " " -f 1)

echo "Old MD5 $MD5_1"
echo "New MD5 $MD5_2"

if [ $MD5_1 != $MD5_2 ]
then
    echo "BuildTools is out of date! Copying over new BuildTools!"

	rm $Home/AutoCraft/resources/spigot/BuildTools.jar
	mv $HOME/AutoCraft/resources/tmp/BuildTools.jar $HOME/AutoCraft/resources/spigot/BuildTools.jar

	echo "Done!"

	echo "Cleaning TMP directory!"
	rm $HOME/AutoCraft/resources/tmp/BuildTools.jar

	echo "Done!"
else
	echo "BuildTools is up to date!"
	echo "Cleaning TMP directory!"
	rm $HOME/AutoCraft/resources/tmp/BuildTools.jar

	echo "Done!"    
fi

compile-spigot

mv $HOME/AutoCraft/resources/spigot/spigot*.jar $HOME/AutoCraft/resources/tmp/Spigot.jar

MD5_1 = _$(md5sum "$HOME/AutoCraft/resources/jars/Spigot.jar" | cut -d " " -f 1)
MD5_2 = _$(md5sum "$HOME/AutoCraft/resources/tmp/Spigot.jar" | cut -d " " -f 1)

if [ $MD5_1 != $MD5_2]
then
    echo "Spigot is out of date! Copying over new Spigot!"

	rm $Home/AutoCraft/resources/jars/Spigot.jar
	mv $HOME/AutoCraft/resources/tmp/Spigot.jar $HOME/AutoCraft/resources/jars/Spigot.jar

	echo "Done"

	echo "Cleaning TMP directory"
	rm $HOME/AutoCraft/resources/tmp/Spigot.jar

	echo "Done"
    
fi

echo "Done! Spigot is upto date!"