#!/bin/bash
echo "Log Doctor - analitzador de logs"

if [[ $# -eq 0 ]]; then
    echo "Introdueix el fitxer a analitzar:"
    read fitxer
else
    fitxer=$1
fi

echo "Fitxer seleccionat: $fitxer"
