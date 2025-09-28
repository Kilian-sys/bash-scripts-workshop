#!/bin/bash
# Aquest script ha sigut realitzat per Kilian Rodriguez Contreras
# La data de creació d'aquest script va ser el 25 de Septebre del 2025
# En aquest script farem un recompte de totes les línies que tè el fitxer /etc/passwd (sense incloure les línies buides)

echo "Començant el recompte de línies útils..."
cat /etc/passwd 2> errors.log | grep -v '^$' | wc -l > linies.log
date >> linies.log
echo "Procés completat! Consulta linies.log i errors.log"
