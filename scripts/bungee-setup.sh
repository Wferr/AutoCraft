#!/bin/bash
set -e

#Used for inital setup of BungeeCord suite

if [ ! -f $HOME/AutoCraft/resources/jars/BungeeCord.jar ]; then
    echo "BungeeCord.jar does not exist!"
    echo "Please run update.sh!"
    exit 1
fi

if [ ! -f $HOME/AutoCraft/bungeecord/BungeeCord.jar ]; then
    echo "BungeeCord is already setup!"
    echo "Please configure manually!"
    exit 1
fi

if (dialog --title "BungeeCord" --yesno "By saying yes you are indicating that you would like to setup BungeeCord)" 10 60) then
	echo "You chose Yes. Starting Setup!"
else
    echo "You chose no, exiting!"
	exit 1
fi

echo "Moving over files!"

cp $HOME/AutoCraft/resources/jars/BungeeCord.jar $HOME/AutoCraft/bungeecord/BungeeCord.jar

echo "Done!"

echo "Type the amount of ram in MB that you want to give to BungeeCord in a range from 256~65536, followed by [ENTER]:"
echo "Recomended amount is 512!"

unset ram
while [[ ! ${ram} =~ ^[0-9]+$ ]]; do
    read ram
    ! [[ ${ram} -ge 256 && ${ram} -le 65536  ]] && unset ram
done

echo "Using $ram MB of ram!"

cp $HOME/AutoCraft/resources/configs/bungeecord/start.sh $HOME/AutoCraft/bungeecord/start.sh
sed -i "s/ram/-Xmx"$ram"M/g" $HOME/AutoCraft/bungeecord/start.sh

echo "Done!"

echo "Starting up to generate configs!"

java -jar $HOME/AutoCraft/bungeecord/BungeeCord.jar -DIReallyKnowWhatIAmDoingISwear

sleep 15

end

echo "Generated!"

echo "Done!"