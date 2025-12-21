#!/bin/bash

echo "Introdueix el nom de l'arxiu:"
read arxiu

if [[ -f $arxiu ]]; then
	arxiu_net="arxiu_sense_comentaris.txt"
	> "$arxiu_net"

	for linia in $(cat "$arxiu")
		do
	if [[ ! $linia =~ ^# ]]; then
		echo "$linia" >> "$arxiu_net"
	fi
	done

	echo "Comentaris eliminats correctament"
	echo ""

	echo "Introdueix una paraula/frase: "
	read cerca

	if grep -q "$cerca" "$arxiu_net"; then
		echo "La paraula/frase '$cerca' existeix dins de l'arxiu"
	else
		echo "La paraula/frase '$cerca' NO existeix dins de l'arxiu"
	fi

	echo ""
	frase=""

	while [[ -z $frase ]]
	do
	echo "Introdueix una frase"
	read frase

	if [[ -z $frase ]]; then
		echo "Error: Has d'introduir una frase"
	fi
	done

	echo "$frase" >> "$arxiu_net"
	echo "Frase afegida correctament. Arxiu net guardat a '$arxiu_net'"

else
	echo "Error: L'arxiu '$arxiu' no existeix"
fi
