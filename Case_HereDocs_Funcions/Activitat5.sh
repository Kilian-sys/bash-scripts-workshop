#!/bin/bash

LOG="servidors.log"

comprovar() {
	servidor=$1

	if ping -c 1 $servidor &>/dev/null; then
		echo "$servidor està actiu"
		echo "$servidor està actiu" >> $LOG
		echo ""
	else
		echo "$servidor està inactiu"
		echo "$servidor està inactiu" >> $LOG
		echo ""
	fi
}

menu() {
	cat << EOF
1) Comprovar Google
2) Comprovar GitHub
3) Comprovar localhost
4) Sortir
EOF
	echo "Escull una opció: "
	read opcio
}

continuar="si"

while [[ $continuar == "si" ]]; do
	menu

	case $opcio in
		1)
			comprovar "google.com"
		;;
		2)
			comprovar "github.com"
		;;
		3)
			comprovar "localhost"
		;;
		4)
			echo "Sortint del programa"
			continuar="no"
		;;
		*)
			echo "Opció no vàlida"
			echo ""
		;;
	esac
done
