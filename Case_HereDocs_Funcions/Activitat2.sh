#!/bin/bash

if [[ $# -eq 1 ]]; then
	usuari=$1

	echo "1) Comprovar si té drets d'administrador"
	echo "2) Comprovar si l'usuari existeix"
	echo "3) Comprovar si el directori personal existeix"
	echo ""

	echo "Tria una opció: "
	read opcio

	case $opcio in
		1)
			if groups $usuari | grep -q "sudo"; then
				echo "L'usuari $usuari SÍ té drets d'administrador"
			else
				echo "L'usuari $usuari NO té drets d'administrador"
			fi
			;;
		2)
			if id $usuari &>/dev/null; then
				echo "L'usuari $usuari existeix"
			else
				echo "L'usuari $usuari NO existeix"
			fi
			;;
		3)
			directori=$(eval echo ~$usuari)
			if [[ -d $directori ]]; then
				echo "El directori $directori existeix"
			else
				echo "El directori NO existeix"
			fi
			;;
		*)
			echo "Error: Opció no vàlida"
			;;
	esac
else
	echo "Error: S'ha d'introduir un argument amb el nom d'un usuari"
fi
