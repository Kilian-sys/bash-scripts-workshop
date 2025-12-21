#!/bin/bash

echo "Introdueix el nom de l'arxiu on guardar les paraules:"
read arxiu

if [[ -f $arxiu ]]; then
	echo "L'arxiu '$arxiu' ja existeix"
else
	touch "$arxiu"
	echo "Arxiu '$arxiu' creat"
fi

echo ""
echo "Escriu paraules (':>' per finalitzar):"

continuar="si"

while [[ "$continuar" = "si" ]]; do
	read paraula

	if [[ "$paraula" = ":>" ]]; then
		continuar="no"
	else
		echo "$paraula" >> "$arxiu"
	fi
done

echo ""
echo "Paraules guardades a l'arxiu '$arxiu'"
