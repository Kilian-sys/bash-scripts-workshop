#!/bin/bash
echo "Introduir un numero positiu o negatiu"
read numero_variable

if [[ $numero_variable -lt 0 ]]; then
	echo "Aquest numero és negatiu"
elif [[ $numero_variable -gt 0 ]]; then
	echo "Aquest numero és positiu"
elif [[ $numero_variable -eq 0 ]]; then
	echo "Aquest numero és 0"
else
	echo "El caracter introduit no és un numero"
fi
