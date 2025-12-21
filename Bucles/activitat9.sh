#!/bin/bash

sortir="no"

while [[ $sortir == "no" ]]
do
	echo ""
	echo "Selecciona una opcio:"
	echo "1) Mostrar data i hora actual"
	echo "2) Comprovar si existeix un fitxer"
	echo "3) Sortir"
	echo ""
	read opcio

	if [[ $opcio -eq 1 ]]; then
		echo ""
		echo -n "Data i hora actual: " && date

	elif [[ $opcio -eq 2 ]]; then
		echo ""
		echo "Introdueix la ruta del fitxer:"
		read fitxer

		if [[ -e $fitxer ]]; then
			echo "El fitxer ($fitxer) existeix"
		else
			echo "El fitxer ($fitxer) no existeix"
		fi

	elif [[ $opcio -eq 3 ]]; then
		sortir="si"
		echo ""
		echo "Sortint del programa..."
	else
		echo ""
		echo "Error: Opció no vàlida"
	fi
done
