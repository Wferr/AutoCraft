#!/bin/bash
set -e
#Used to add new spigot to AutoCraft

#Used to set server port
function port-set {
echo "Type the port of the server you want to add in a range from 25566~2600, followed by [ENTER]:"

unset port
while [[ ! ${port} =~ ^[0-9]+$ ]]; do
    read port
    ! [[ ${port} -ge 25566 && ${port} -le 26000  ]] && unset port
done

echo "Using port $port"

sed -i 's/server-port=25565/server-port=$port/g' $HOME/AutoCraft/servers/$name/server.properties

echo "Done!"
}

#Used to set amount of ram
function ram-set {
echo "Type the amount of ram in MB that you want to give to the server in a range from 256~65536, followed by [ENTER]:"

unset ram
while [[ ! ${ram} =~ ^[0-9]+$ ]]; do
    read ram
    ! [[ ${ram} -ge 256 && ${ram} -le 65536  ]] && unset ram
done

echo "Using $ram MB of ram!"

echo "while :
do
java -Xmx$ramM -jar spigot.jar

echo 'Restarting in 5'
sleep 1
echo 'Restarting in 4'
sleep 1
echo 'Restarting in 3'
sleep 1
echo 'Restarting in 2'
sleep 1
echo 'Restarting in 1'
sleep 1

done" > $HOME/AutoCraft/server/$name/start.sh

echo "Done!"
}

echo "Reding Config!"
source $HOME/AutoCraft/resources/config.conf

echo "AutoCraft Controller Software version: $controller_version !"
echo "AutoCraft Config Version: $config_version !"
echo "AutoCraft Updater Version: $updater_version !"

if [ ! -f $HOME/AutoCraft/resources/jars/Spigot.jar ]; then
    echo "Spigot.jar does not exist!"
    echo "Please run update.sh!"
    exit 1
fi

name=$(dialog --title "Name of the server to add." --inputbox "What the name of the server?" 10 60 survival 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your server name is:" $name
else
    echo "Exiting"
    exit 0
fi

if [ -f $HOME/AutoCraft/servers/$name ]; then
    echo "Server Already Exists!"
    echo "To reset that server please run spigot-delete.sh then spigot-addserver.sh"
    exit 1
fi

if [ ! -f $HOME/AutoCraft/resources/configs/eula.txt ]; then
	if (dialog --title "EULA" --yesno "By responding yes you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula)" 10 60) then
    	echo "You chose Yes. Agreeing to EULA."
    	echo "Adding eula.txt"
    	echo "eula=true" > $HOME/AutoCraft/resources/configs/eula.txt
    	echo "Done!"
	else
    	echo "You chose to not agree!"
    	exit 1
	fi
fi

echo "Createing Server Directory"

mkdir $HOME/AutoCraft/servers/$name

echo "Done!"
echo "Copying over basic files!"

cp $HOME/AutoCraft/resources/configs/eula.txt $HOME/AutoCraft/servers/$name/eula.txt
cp $HOME/AutoCraft/resources/jars/Spigot.jar $HOME/AutoCraft/servers/$name/Spigot.jar

echo "Done!"

PS3='Please enter your choice for Spigot configs!: '
options=("Minimal, no nether, end, mobs" "Less, no nether end" "Full" "Custom")
select opt in "${options[@]}"
do
    case $opt in
        "Minimal, no nether, end, mobs")
            echo "Minimal Install!"
            cp $HOME/AutoCraft/resources/configs/minimal/spigot.yml $HOME/AutoCraft/servers/$name/spigot.yml
            cp $HOME/AutoCraft/resources/configs/minimal/bukkit.yml $HOME/AutoCraft/servers/$name/bukkit.yml
            cp $HOME/AutoCraft/resources/configs/minimal/server.properties $HOME/AutoCraft/servers/$name/server.properties
            port-set
            ram-set
            break
            ;;
        "Less, no nether end")
            echo "Less Install!"
            cp $HOME/AutoCraft/resources/configs/less/spigot.yml $HOME/AutoCraft/servers/$name/spigot.yml
            cp $HOME/AutoCraft/resources/configs/less/bukkit.yml $HOME/AutoCraft/servers/$name/bukkit.yml
            cp $HOME/AutoCraft/resources/configs/less/server.properties $HOME/AutoCraft/servers/$name/server.properties
            port-set
            ram-set
            break
            ;;
        "Full")
            echo "Full Install!"
            cp $HOME/AutoCraft/resources/configs/full/spigot.yml $HOME/AutoCraft/servers/$name/spigot.yml
            cp $HOME/AutoCraft/resources/configs/full/bukkit.yml $HOME/AutoCraft/servers/$name/bukkit.yml
            cp $HOME/AutoCraft/resources/configs/full/server.properties $HOME/AutoCraft/servers/$name/server.properties
            port-set
            ram-set
            break
            ;;
        "Custom")
            echo "Custom Install!"
            echo "Please run start.sh to generate config files!"
            ram-set
            break
            ;;
        *) echo invalid option;;
    esac
done

echo "Done!"


echo "Server has finished installing!"