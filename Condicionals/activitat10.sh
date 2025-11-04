#!/bin/bash
fitxer=$1
paraula_clau=$2

if [[ $# -eq 2 ]]; then

    if [[ -e $fitxer ]]; then

        if [[ $fitxer == *.txt || $fitxer == *.csv ]]; then
            coincidencies=$(grep -i -c "$paraula_clau" "$fitxer")

            if [[ $coincidencies -gt 0 ]]; then
                echo "S'han trobat $coincidencies linies amb '$paraula_clau'"
            else
                echo "No s'ha trobat cap coincidència per a '$paraula_clau'"
            fi

        else
            echo "Error: El fitxer ha de tenir extensió .txt o .csv"
        fi

    else
        echo "Error: El fitxer '$fitxer' no existeix"
    fi

else
    echo "Error: S'han d'introduir exactament 2 arguments"
fi
