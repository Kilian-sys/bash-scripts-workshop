#!/bin/bash
echo "Log Doctor - analitzador de logs"

if [[ $# -eq 0 ]]; then
    existeix=no
    while [[ "$existeix" = "no" ]]; do
        echo "Introdueix el fitxer a analitzar:"
        read fitxer

        if [[ -e $fitxer ]]; then
            existeix=si
            echo "El fitxer $fitxer existeix"
        else
            echo "El fitxer introduït, no és vàlid o no existeix"
        fi
    done
else
    fitxer=$1
    existeix=no
    while [[ "$existeix" = "no" ]]; do
        if [[ -e $fitxer ]]; then
            existeix=si
            echo "El fitxer $fitxer existeix"
        else
            echo "El fitxer introduït, no és vàlid o no existeix"
            echo "Introdueix el fitxer a analitzar:"
            read fitxer
        fi
    done
fi

echo ""
total=$(wc -l < "$fitxer")
errors=$(grep -c "ERROR" "$fitxer")
warnings=$(grep -c "WARNING" "$fitxer")

echo "Total de línies: $total"
echo "Línies amb ERROR: $errors"
echo "Línies amb WARNING: $warnings"

valida_numero=no
while [[ "$valida_numero" = "no" ]]; do
    echo "Quants informes vols generar?"
    read N

    if [[ $N =~ ^[0-9]+$ ]]; then
        if [[ $N -gt 0 ]]; then
            valida_numero=si
        else
            echo "Error: Has d'introduir un número major que 0"
        fi
    else
        echo "Error: Has d'introduir un número enter vàlid"
    fi
done

i=1
while [[ $i -le $N ]]; do
    echo "Total de línies: $total" > "informe_$i.txt"
    echo "Línies amb ERROR: $errors" >> "informe_$i.txt"
    echo "Línies amb WARNING: $warnings" >> "informe_$i.txt"
    echo "Informe $i creat: informe_$i.txt"
    i=$((i + 1))
done
