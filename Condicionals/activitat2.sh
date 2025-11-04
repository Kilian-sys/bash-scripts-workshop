#!/bin/bash
echo "Introduir un numero positiu o negatiu"
read numero_variable

if [[ $numero_variable -lt 0 ]]; then
        echo "Aquest numero és negatiu"
elif [[ $numero_variable -gt 0 ]]; then
        echo "Aquest numero no és negatiu"
else
        echo "El numero introduit no és negatiu ni positiu"
fi
