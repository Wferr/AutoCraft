#!/bin/bash
set -e
//Used to setup AutoCraft

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ -f /home/AutoCraft ]; then
    echo "AutoCraft has already been setup!"
    exit 1
fi

echo "Running Update!"

sudo apt-get update

echo "Running Upgrade!"

sudo apt-get upgrade

echo "Installing Nessicarry packages!"

sudo apt-get install --assume-yes python-software-properties && git && tmux && htop

echo "Done, Installing Java!"

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get --assume-yes install oracle-java8-installer

echo "Done"
echo "Verifying Java Installation"

//http://stackoverflow.com/a/7335524
if type -p java; then
    echo found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME     
    _java="$JAVA_HOME/bin/java"
else
    echo "Java Failed to install. Please install manually!"
    sleep 20
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" > "1.8" ]]; then
        echo "Java 8 is installed."
    else         
        echo "Java is outdated! Please install manually!"
        sleep 20
    fi
fi

echo "Done!"
echo "Creating User!"

sudo adduser AutoCraft --gecos "Auto Craft,1337,*,*" --disabled-password
echo "AutoCraft:CraftingAwesomeness101" | sudo chpasswd

echo "User Added!"
echo "Switching User!"

su AutoCraft

echo "Installing AutoCraft from Github!"

git clone http://github.com/Wferr/AutoCraft.git

echo "Cloned!"

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
echo "Please change AutoCraft password with 'passwd'"
echo "Enjoy AutoCraft!"