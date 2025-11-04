#!/bin/bash
argument1=$1
operador=$2
argument2=$3

if [[ $# == 3 ]]; then

    if [[ "$argument1" =~ ^-?[0-9]+$ && "$argument2" =~ ^-?[0-9]+$ ]]; then

        if [[ $operador == "add" ]]; then
            echo "$argument2 + $argument2 = $(($argument1 + $argument2))"

        elif [[ $operador == "subtract" ]]; then
            echo "$argument1 - $argument2 = $(($argument1 - $argument2))"

        elif [[ $operador == "multiply" ]]; then
            echo "$argument1 * $argument2 = $(($argument1 * $argument2))"

        elif [[ $operador == "divide" ]]; then

	if [[ $argument2 != 0 ]]; then
                echo "$argument1 / $argument2 = $(($argument1 / $argument2))"
            else
                echo "Error: No és pot dividir entre 0"
            fi

        else
            echo "Error: El operador no és add, subtract, multiply o divide"
        fi
    else
        echo "Error: Els arguments introduits no són integers vàlids"
    fi
else
    echo "Error: El nombre d'arguments no és 3"
fi
