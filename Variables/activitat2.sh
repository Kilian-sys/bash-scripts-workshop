#!/bin/bash
echo "Nom de la variable:"
read nom_variable

echo "Valor de la variable:"
read valor_variable

# eval crea una variable personalitzada
eval "$nom_variable='$valor_variable'"

echo ""
echo "Variable creada: $nom_variable"
echo "Valor: $valor_variable"

