#!/bin/bash

# Definim el codi d'error que es retornarà en cas d'ús incorrecte
USG_ERR=7

# Funció que compara dos números i determina quin és el més gran
max_dos ( ) {
	# En el cas que els 2 números introduïts siguin iguals, retorna un missatge indicant que són iguals i acaba el script
	if [ "$1" -eq "$2" ] ; then
		echo 'Iguals'
		exit 0
	# Si el primer número és més gran que el segon número, emmagatzema el primer número a la variable ret_val
	elif [ "$1" -gt "$2" ] ; then
		ret_val=$1
	# Si el segon número és més gran que el primer número, emmagatzema el segon número a la variable ret_val
	else
		ret_val=$2
	fi
}

# Funció que retornarà un missatge d'error indicant com s'han d'introduir els arguments en cas que els paràmetres facilitats no siguin correctes, i finalitzarà l'script
err_str ( ) {
	echo "Ús: $0 <numero1> <numero2>"
	exit $USG_ERR
}

# Variables que emmagatzemen els 2 arguments introduïts en el script
NUM_1=$1
NUM_2=$2

# Condició que comprova si s'han passat exactament 2 arguments. En el cas que no siguin 2 arguments, mostra l'error d'ús definit a la funció err_str
if [ $# -ne 2 ] ; then
	err_str
# Condició que comprova que el primer paràmetre sigui un número enter vàlid. Si ho és, passarem a la condició que hi ha dins de l'elif
elif [ `expr $NUM_1 : '[0-9]*'` -eq ${#NUM_1} ] ; then
	# Condició que verifica si el segon número és un número enter vàlid. Si els 2 números són enters vàlids, cridem la funció max_dos per calcular el màxim dels dos números. Seguidament mostrem el resultat emmagatzemat a la variable ret_val
	if [ `expr $NUM_2 : '[0-9]*'` -eq ${#NUM_2} ] ; then
		max_dos $NUM_1 $NUM_2
		echo $ret_val
	# Si el segon número enter no és vàlid, mostra l'error d'ús definit a la funció err_str i acaba el script
	else
		err_str
	fi
# Si el primer número enter no és vàlid, mostra l'error d'ús definit a la funció err_str i acaba el script
else
	err_str
fi

# Sortim del script amb codi d'èxit 0 indicant una execució correcta
exit 0
