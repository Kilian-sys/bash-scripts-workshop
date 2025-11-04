#!/bin/bash
fitxer=$1

if [[ $# -gt 1 ]]; then
	echo "Error: No és pot introduir més d'un Argument"

elif [[ $# -lt 1 ]]; then
        echo "Error: No s'ha introduit cap Argument"

elif [[ -e $fitxer ]]; then
        echo -n "Tipus de fitxer:" && file $1

if [[ -r $fitxer ]]; then
        echo "El fitxer te permisos de lectura (l)"
else
        echo "El fitxer no tè permisos de lectura (l)"
fi

if [[ -w $fitxer ]]; then
        echo "El fitxer te permisos d'escriptura (w)"
else
        echo "El fitxer no tè permisos d'escriptura (w)"
fi

if [[ -x $fitxer ]]; then
        echo "El fitxer te permisos d'execució (x)"
else
        echo "El fitxer no tè permisos d'execució (x)"
fi

else
        echo "Error: El fitxer $1 no existeix"
fi
