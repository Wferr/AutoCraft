#!/bin/bash
set -e
#Used to Update BungeeCord Suite

if [ ! -f $HOME/AutoCraft/resources/jars/BungeeCord.jar ]; then
    echo "BungeeCord not found, Downloading!"
    cd $HOME/AutoCraft/resources/jars/
    wget http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar
    cp $HOME/AutoCraft/resources/jars/BungeeCord.jar $HOME/AutoCraft/bungeecord/BungeeCord.jar
fi

cd $HOME/AutoCraft/resources/tmp/
wget http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar

MD5_1 = _$(md5sum "$HOME/AutoCraft/resources/jars/BungeeCord.jar" | cut -d " " -f 1)
MD5_2 = _$(md5sum "$HOME/AutoCraft/resources/tmp/BungeeCord.jar" | cut -d " " -f 1)

if [$MD5_1 == $MD5_2]
then
    echo "BungeeCord is running the most upto date version and needed no update-restart!"
    exit 1
fi

echo "BungeeCord is out of date! Copying over new BungeeCord!"

rm $HOME/AutoCraft/resources/jars/BungeeCord.jar
mv $HOME/AutoCraft/resources/tmp/BungeeCord.jar $HOME/AutoCraft/resources/jars/BungeeCord.jar

echo "Done!"

echo "Cleaning TMP directory"
rm $HOME/AutoCraft/resources/tmp/BungeeCord.jar

echo "Done!"