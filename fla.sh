#!/bin/bash
set -e
IFS=$'\n'

case "$1" in
"")
	while ls * 1> /dev/null 2>&1; do
		# Takes care of files with spaces
		readarray -t files <<<"$(ls | shuf)"
		for CARD in "${files[@]}"; do
			read -p "$CARD"
			cat "$CARD"
			read -p "Got it? [Y/n] " -n 1 ANS
			echo
			if [ "$ANS" != "n" ] && [ "$ANS" != "N" ]; then
				mv "$CARD" ".$CARD"
			fi
		done;
	done;;
write)
	while true; do
		read -p "Prompt: " PROMPT
		read -p "Answer: " ANSWER
		echo "$ANSWER" > "$PROMPT"
	done;;
learn)
	shift
	for F in $@; do
		mv "$F" ".$F"
	done;;
forget)
	shift
        for F in $@ .[^.]*; do
                if [[ $F == .* ]];then
                        mv "$F" "${F:1}"
                fi
	done;;
*)
	CMD=`basename $0`
	echo "Usage:"
	echo "  $CMD"
	echo "  $CMD write"
	echo "  $CMD learn  <file...>"
	echo "  $CMD forget <file...>"
esac
