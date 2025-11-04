#!/bin/bash
fitxer=$1

[[ -r $fitxer ]] && echo "$fitxer te permisos de lectura"
[[ -w $fitxer ]] && echo "$fitxer te permisos d'escriptura"
[[ -x $fitxer ]] && echo "$fitxer te permisos d'execució"


