#!/bin/bash

directori_valid=no

until [[ $directori_valid == "si" ]]
do
	echo "Introdueix la ruta del directori:"
	read ruta_directori
	echo ""

	if [[ -d $ruta_directori ]]; then
		directori_valid="si"

		echo "Permisos del directori:"
		if [[ -r $ruta_directory ]]; then
			echo "El directori te permisos de lectura (r)"
		else
			echo "El directori no te permisos de lectura (r)"
		fi

		if [[ -w $ruta_directory ]]; then
			echo "El directori te permisos de escriptura (w)"
		else
			echo "El directori te permisos de escriptura (w)"
		fi

		if [[ -x $ruta_directori ]]; then
			echo "El directori te permisos de execució (x)"
		else
			echo "El directori te psrmisos de execució (x)"
		fi

		echo ""
		echo "Nom dels Directoris:"
		find $ruta_directori -maxdepth 1 -type d
		echo -n "Total Directoris:" && find $ruta_directori -maxdepth 1 -type d | wc -l
		echo ""

		echo "Nom dels Fitxers:"
		find $ruta_directori -maxdepth 1 -type f
		echo -n "Total Fitxers: " && find $ruta_directori -maxdepth 1 -type f | wc -l
	else
		echo "El directori introduit no existeix"
		echo ""
	fi
done



