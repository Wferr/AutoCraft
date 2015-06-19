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

if [ ! -f $HOME/AutoCraft/resources/jars/Spigot.jar ]; then
    echo "Spigot.jar does not exist!"
    echo "Please run update.sh!"
    exit 1
fi

echo "Type the name of the server you want to add, followed by [ENTER]:"

read name

if [ -f $HOME/AutoCraft/servers/$name ]; then
    echo "Server Already Exists!"
    echo "To reset that server please run spigot-delete.sh then spigot-addserver.sh"
    exit 1
fi

if [ ! -f $HOME/AutoCraft/resources/config/eula.txt ]; then
    echo "EULA has not been accepted!"
    echo "By responding yes you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula)"
    read -p "Continue (y/n)?" choice
    case "$choice" in 
        [yY][eE][sS]  ) echo "YES";;
        [nN][oO]  ) echo "Did not agree!" $$ exit 1;;
        * ) echo "Invalid Choice!";;
    esac

    echo "Adding eula.txt"
    echo "eula=true" > $HOME/AutoCraft/resources/configs/eula.txt
    echo "Done!"

fi

echo "Createing Server Directory"

mkdir $HOME/AutoCraft/servers/$name

echo "Done!"
echo "Copying over basic files!"

cp $HOME/AutoCraft/resources/configs/eula.txt $HOME/AutoCraft/servers/$name/eula.txt
cp $HOME/AutoCraft/resources/jars/Spigot.jar $HOME/AutoCraft/servers/$name/Spigot.jar

echo "Done!"

PS3='Please enter your choice for Spigot configs!: '
options=("Option 1" "Option 2" "Option 3" "Custom")
select opt in "${options[@]}"
    case $opt in
        "Option 1: Minimal, no nether, end, mobs")
            echo "Minimal Install!"
            cp $HOME/AutoCraft/resources/configs/minimal/spigot.yml
            cp $HOME/AutoCraft/resources/configs/minimal/bukkit.yml
            cp $HOME/AutoCraft/resources/configs/minimal/server.properties
            port-set
            ram-set
            break
            ;;
        "Option 2: Less, no nether end")
            echo "Less Install!"
            cp $HOME/AutoCraft/resources/configs/less/spigot.yml
            cp $HOME/AutoCraft/resources/configs/less/bukkit.yml
            cp $HOME/AutoCraft/resources/configs/less/server.properties
            port-set
            ram-set
            break
            ;;
        "Option 3: Full")
            echo "Full Install!"
            cp $HOME/AutoCraft/resources/configs/full/spigot.yml
            cp $HOME/AutoCraft/resources/configs/full/bukkit.yml
            cp $HOME/AutoCraft/resources/configs/full/server.properties
            port-set
            ram-set
            break
            ;;
        "Option 3: Custom")
            echo "Custom Install!"
            echo "Please run start.sh to generate config files!"
            ram-set
            break
            ;;
        *) echo invalid option;;
    esac

echo "Done!"


echo "Server has finished installing!"