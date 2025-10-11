#!/bin/bash
echo "Nom d'una variable global (HOME, USER, SHELL, PWD, PATH):"
read variable_global

echo "El valor de la variable global és: $variable_global"
echo ""
echo "Arguments passats: $*"
echo "Exit code: $?"
echo "PID del Shell: $$"
