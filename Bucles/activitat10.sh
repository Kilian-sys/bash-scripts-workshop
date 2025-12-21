#!/bin/bash

web_institut="agora.xtec.cat/ies-sabadell/"
connexio="no"

echo "Comprovant connexió a Google..."
echo ""

while [[ $connexio == "no" ]]
do
	if ping -c 1 "google.com" &> /dev/null; then
		connexio="si"
		echo "Connexió establerta correctament!"
		echo "Obtenint contingut de la pàgina de l'institut..."
		echo ""
		curl -s "https://$web_institut"
	else
		echo "No hi ha connexió a Internet. Reintentant en 5 segons..."
		sleep 5
	fi
done
