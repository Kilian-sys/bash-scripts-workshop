#!/bin/bash

echo "Usuaris del Sistema:"
echo ""
cut -d: -f1 /etc/passwd | grep '[A-Z]'
echo ""

usuari_valid="no"

while [[ $usuari_valid == "no" ]]
do
	read -p "Introdueix el nom d'un usuari: " nom_usuari

	if grep -q "^$nom_usuari:" /etc/passwd; then
		usuari_valid="si"
		echo ""
		echo "Detalls de l'usuari"
		echo ""
		echo -n "Informació del Sistema: " && grep "^$nom_usuari:" /etc/passwd
		echo ""
		echo -n "Informació de l'usuari: " && id "$nom_usuari"
		echo ""
		echo -n "Directori home: " && grep "^$nom_usuari:" /etc/passwd | cut -d: -f6
	else
		echo "Error: L'usuari '$nom_usuari' no existeix"
		echo ""
	fi
done
