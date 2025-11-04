#!/bin/bash
echo "Introduir un numero positiu o negatiu"
read numero_variable

if [[ $numero_variable -eq 0 ]]; then
        echo "Aquest numero és 0"
else
        echo "Aquest numero no és 0"
fi
