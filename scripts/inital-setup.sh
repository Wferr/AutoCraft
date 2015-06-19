#!/bin/bash
set -e
#Used to setup AutoCraft

if [[ $EUID -ne 0 ]]; then
   dialog --title 'Error' --msgbox 'Script must br run as root!' 5 60 1>&2
   exit 1
fi

if [ -f /home/autocraft ]; then
    dialog --title 'Error' --msgbox 'AutoCraft has already been setup!' 5 60
    exit 1
fi

echo "Running Update!"

sudo apt-get update

echo "Running Upgrade!"

sudo apt-get upgrade

echo "Installing Nessicarry packages!"

sudo apt-get install --assume-yes python-software-properties && git && tmux && htop && dialog

echo "Done, Installing Java!"

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get --assume-yes install oracle-java8-installer

echo "Done"
echo "Verifying Java Installation"

#http://stackoverflow.com/a/7335524
if type -p java; then
    echo found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME     
    _java="$JAVA_HOME/bin/java"
else
    dialog --title 'Error' --msgbox 'Java install failed! Install manually!' 5 60
    sleep 20
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" > "1.8" ]]; then
        echo "Java 8 is installed."
    else         
        dialog --title 'Error' --msgbox 'Java is outdated Install manually!' 5 60
        sleep 20
    fi
fi

echo "Done!"
echo "Creating User!"

sudo adduser autocraft --gecos "Auto Craft,1337,*,*" --disabled-password
echo "autocraft:CraftingAwesomeness101" | sudo chpasswd

echo "User Added!"
echo "Switching User!"

su autocraft

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