#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/.mg2d_env" ]; then
	# shellcheck disable=SC1091
	source "$SCRIPT_DIR/.mg2d_env"
elif [ -f "$SCRIPT_DIR/MG2D/mg2d.jar" ]; then
	MG2D_CP="$SCRIPT_DIR/MG2D/mg2d.jar"
else
	echo "MG2D introuvable. Attendu: .mg2d_env ou MG2D/mg2d.jar"
	exit 1
fi

xdotool mousemove 1280 1024
cd projet/Minesweeper
touch highscore
java -cp .:../..:"$MG2D_CP" Minesweeper
