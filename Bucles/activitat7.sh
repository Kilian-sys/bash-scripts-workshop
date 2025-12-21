#!/bin/bash

numero=$((RANDOM%3))
repetir="si"

while [ "$repetir" = "si" ]
do
	echo "Pedra, Paper o............."
	read nom_variable

	if [[ $nom_variable == "Pedra" && $numero -eq 0 ]]; then
		echo "Jugador: Pedra!!!"
		echo "Maquina: Pedra!!!"
		echo ""
		echo "El jugador ha empatat amb la maquina!!!"

	elif [[ $nom_variable == "Pedra" && $numero -eq 1 ]]; then
		echo "Jugador: Pedra!!!"
		echo "Maquina: Paper!!!"
		echo ""
		echo "La maquina ha guanyat!!!"

	elif [[ $nom_variable == "Pedra" && $numero -eq 2 ]]; then
		echo "Jugador: Pedra!!!"
		echo "Maquina: Tisores!!!"
		echo ""
		echo "El jugador ha guanyat!!!"

	elif [[ $nom_variable == "Paper" && $numero -eq 0 ]]; then
		echo "Jugador: Paper!!!"
		echo "Maquina: Pedra!!!"
		echo ""
		echo "El jugador ha guanyat!!!"

	elif [[ $nom_variable == "Paper" && $numero -eq 1 ]]; then
        	echo "Jugador: Paper!!!"
		echo "Maquina: Paper!!!"
		echo ""
		echo "El jugador ha empatat amb la maquina!!!"

	elif [[ $nom_variable == "Paper" && $numero -eq 2 ]]; then
		echo "Jugador: Paper!!!"
		echo "Maquina: Tisores!!!"
		echo ""
		echo "La maquina ha guanyat!!!"

	elif [[ $nom_variable == "Tisores" && $numero -eq 0 ]]; then
		echo "Jugador: Tisores!!!"
		echo "Maquina: Pedra!!!"
		echo ""
		echo "La maquina ha guanyat!!!"

	elif [[ $nom_variable == "Tisores" && $numero -eq 1 ]]; then
		echo "Jugador: Tisores!!!"
		echo "Maquina: Paper!!!"
		echo ""
		echo "El jugador ha guanyat!!!"

	elif [[ $nom_variable == "Tisores" && $numero -eq 2 ]]; then
		echo "Jugador: Tisores!!!"
		echo "Maquina: Tisores!!!"
		echo ""
		echo "El jugador ha empatat amb la maquina!!!"

	else
		echo "Error: S'ha d'escollir entre Pedra, Paper o Tisores"
	fi

read -p "Quieres repetir?" repetir
done
