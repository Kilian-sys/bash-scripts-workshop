#!/bin/bash
echo "Analitzant fitxer..."

echo "Nom del fitxer a analitzar:"
read nom_fitxer

{
    echo "==============================="
    echo "Fitxer analitzat: $nom_fitxer"
    echo "Línies útils: $(grep -c -v '^$' "$nom_fitxer")"
    echo "Paraules totals: $(wc -w < "$nom_fitxer")"
    echo "Caràcters totals: $(wc -m < "$nom_fitxer")"
    echo "Data: $(date)"
    echo "Executat per: $USER"
    echo "Directori: $PWD"
    echo "PID Shell: $$"
    echo "==============================="
} > resultats.log 2> errors.log

echo "Procés completat! Revisa resultats.log i errors.log"

cat resultats.log
