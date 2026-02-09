#!/bin/bash

setxkbmap borne

cd /home/pi/git/borne_arcade
echo "nettoyage des répertoires"
echo "Veuillez patienter"
./clean.sh
./compilation.sh

# Source MG2D classpath from compilation
if [ -f .mg2d_env ]; then
  source .mg2d_env
else
  MG2D_CP="/home/pi/git/MG2D"  # fallback
fi

echo "Lancement du  Menu"
echo "Veuillez patienter"

java -cp .:"$MG2D_CP" Main

./clean.sh

for i in {30..1}
do
    echo Extinction de la borne dans $i secondes
    sleep 1
done

sudo halt
