#!/bin/bash
# El parametre -s amaga caractrs en la introducció del read
echo "Introduir el nou usuari:"
read nom_usuari

echo "Introduir la seva contrasenya:"
read -s contrasenya

echo ""
echo "S'ha creat l'usuari $nom_usuari amb la seva contrasenya $contrasenya"

