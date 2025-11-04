#!/bin/bash
directori=$1
fitxer_comprimit=$2

if [[ -e $fitxer_comprimit ]]; then
        echo "El fitxer comprimit $fitxer_comprimit ja existeix. Vols sobrescriure aquest fitxer? (yes/no)"
	read confirmacio

if [[ $confirmacio == "yes" ]]; then
        tar czvf $fitxer_comprimit $directori/* >> $fitxer_comprimit
        echo "El fitxer $fitxer_comprimit ha sigut sobrescrigut."

elif [[ $confirmacio == "no" ]]; then
        echo "El fitxer no ha sigut sobrescrigut"

else
        echo "Error: No s'ha seleccionat cap de les 2 opcions. El fitxer no ha sigut sobrescrigut"
fi

elif [[ -d $directori ]]; then
        tar czvf $fitxer_comprimit $directori/*

else
        echo "Error: $arxiu no és un directori"
fi




