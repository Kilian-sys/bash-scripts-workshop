#!/bin/bash

contrasenya_valida="no"

while [[ $contrasenya_valida == "no" ]]
do
	echo "Introdueix una contrasenya:"
	read contrasenya
	echo ""

	longitud=${#contrasenya}

	if [[ $longitud -ge 7 ]]; then
		if [[ $contrasenya =~ [A-Z] ]]; then
			if [[ $contrasenya =~ [0-9] ]]; then
				contrasenya_valida="si"
				echo "La contrasenya és vàlida"
			else
				echo "Error: La contrasenya ha de contenir almenys un número"
				echo ""
			fi
		else
			echo "Error: La contrasenya ha de contenir almenys una majúscula"
			echo ""
		fi
	else
		echo "Error: La contrasenya ha de tenir almenys 8 caràcters"
		echo ""
	fi
done
