#!/bin/bash

calcul_valid=no

until [[ $calcul_valid == "si" ]]
do

	echo "Introduiex el primer valor nùmeric:"
	read primer_valor
	echo ""

	echo "Introdueix el segon valor nùmeric:"
	read segon_valor
	echo ""

	echo "Introdueix el tercer valor nùmeric:"
	read tercer_valor
	echo ""

	if [[ "$primer_valor" =~ ^-?[0-9]+$ && "$segon_valor" =~ ^-?[0-9]+$ && "$tercer_valor" =~ ^-?[0-9]+$ ]]; then
		calcul_valid=si

		echo ""
		echo "Resultats:"
		echo ""

		suma=$(( primer_valor + segon_valor + tercer_valor ))
        	echo "La suma entre els 3 valos és: $suma"

		producte=$(( primer_valor * segon_valor * tercer_valor ))
		echo "La multiplicació entre els 3 valors és: $producte"

		maxim=$primer_valor
		minim=$primer_valor

		if [[ $segon_valor -gt $maxim ]]; then
		maxim=$segon_valor
		fi

		if [[ $tercer_valor -gt $maxim ]]; then
		maxim=$tercer_valor
		fi

		if [[ $segon_valor -lt $minim ]]; then
		minim=$segon_valor
		fi

		if [[ $tercer_valor -lt $minim ]]; then
		minim=$tercer_valor
		fi

		echo "El valor més gran és: $maxim"
		echo "El valor més petit és: $minim"
	else
		echo "Els 3 argumnets introduits no sòn valors nùmerics"
	fi
done


