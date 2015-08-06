function logger {
NOW=$(date +"%m-%d-%y")

echo "Used to handle archving logs!"

if [ ! -d $HOME/AutoCraft/logs/$NOW ]; then
  echo "Directory for $NOW does not exist! Creating!"
  mkdir $HOME/AutoCraft/logs/$NOW/
  echo "Done!"
fi

echo "Archiving BungeeCord Logs!"
}