#!/bin/bash
echo "Nom de l'usuari (\$USER): $USER"
echo "Resultat de whoami: $(whoami)"
echo ""

echo "Directori personal (\$HOME): $HOME"
echo "Directori actual (\$PWD): $PWD"
echo ""

echo "Contingut del directori actual:"
ls
echo ""

echo "Nombre d'elements al directori: $(ls | wc -l)"
echo ""

echo "PID del Shell (\$\$): $$"
echo "Codi de retorn última ordre (\$?): $?"

