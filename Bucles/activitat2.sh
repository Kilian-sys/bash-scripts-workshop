#!/bin/bash

numeros_positius=0
numeros_negatius=0
numeros_neutrals=0

if [[ $# -gt 0 ]]; then
	for numero in "$@"
	do
		if [[ $numero =~ ^-?[0-9]+$ ]]; then
			if [[ $numero -gt 0 ]]; then
				numeros_positius=$((numeros_positius +1))
			elif [[ $numero -lt 0 ]]; then
				numeros_negatius=$((numeros_negatius +1))
			else
				numeros_neutrals=$((numeros_neutrals +1))
			fi
		else
			echo "Error: L'argument $numero, no és un número enter vàlid"
		fi
	done

	echo "Numeros positius: $numeros_positius"
	echo "Numeros negatius: $numeros_negatius"
	echo "Numeros neutrals (0): $numeros_neutrals"

else
	echo "Error: S'ha d'introduir un argument com a mínim"
fi
