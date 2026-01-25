#!/bin/bash

segur="no"

while [[ $segur == "no" ]]; do
	echo "Vols continuar en l'espiral d'emocions?"
	echo "Escriu 'si' o 'no':"
	read resposta

	case $resposta in
		si)
			segur="si"
			xdg-open "https://www.youtube.com/watch?v=jaLDoWqIq2M"
			;;
		no)
			echo "Adeu!"
			segur="si"
			;;
		*)
			echo ""
			;;
	esac
done
