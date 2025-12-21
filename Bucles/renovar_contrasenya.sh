#!/bin/bash

# SCRIPT DE RENOVACIÓN DE CONTRASEÑA CORPORATIVA
# Empresa de consultoría - Usuarios Debian
# Ejecución automática cada 6 meses via LDAP

# VARIABLES GLOBALES
USUARIO=$(whoami)
TMPDIR="/tmp/password_check_$USUARIO"
HISTORIAL="/var/security/password_history/$USUARIO"
DICCIONARIO="$TMPDIR/diccionario.txt"
HASHFILE="$TMPDIR/pass.hash"
SESION_JOHN="john_$USUARIO"
MIN=12
MAX=16
INTENTOS=3

# Crear directorio temporal
mkdir -p "$TMPDIR"

# FUNCIONES
comprobar_reglas() {
 PASS="$1"
 LONGITUD=${#PASS}

 if [ $LONGITUD -lt $MIN ] || [ $LONGITUD -gt $MAX ]; then
 echo "ERROR: Entre $MIN y $MAX caracteres"
 return 1
 fi

 if ! [[ $PASS =~ [A-Z] ]]; then
 echo "ERROR: Falta mayúscula"
 return 1
 fi

 if ! [[ $PASS =~ [a-z] ]]; then
 echo "ERROR: Falta minúscula"
 return 1
 fi

 if ! [[ $PASS =~ [0-9] ]]; then
 echo "ERROR: Falta número"
 return 1
 fi

 if ! [[ $PASS =~ [\!\@\#\$\%\^\&\*\(\)\_\+\-\=] ]]; then
 echo "ERROR: Falta carácter especial"
 return 1
 fi

 if [[ $PASS == ${PASS^^} ]] || [[ $PASS == ${PASS,,} ]]; then
 echo "ERROR: No todo mayúsculas o minúsculas"
 return 1
 fi

 return 0
}

comprobar_historial() {
 PASS="$1"

 if [ -f "$HISTORIAL" ]; then
 while read -r PASS_VIEJA; do
 if [ "$PASS" == "$PASS_VIEJA" ]; then
 echo "ERROR: Contraseña ya utilizada"
 return 1
 fi
 done < <(tail -3 "$HISTORIAL")
 fi

 return 0
}

comprobar_patrones() {
 PASS="$1"
 PASS_MIN=${PASS,,}

 if [[ $PASS_MIN == *${USUARIO,,}* ]]; then
 echo "ERROR: No puede contener usuario"
 return 1
 fi

 if [[ $PASS == *"123"* ]] || [[ $PASS == *"abc"* ]] || [[ $PASS == *"ABC"* ]]; then
 echo "ERROR: No secuencias obvias"
 return 1
 fi

 return 0
}

crear_diccionario() {
 > "$DICCIONARIO"

 read -p "Nombre: " NOMBRE
 read -p "Primer apellido: " APELLIDO1
 read -p "Segundo apellido: " APELLIDO2

 # Solo guardar lo introducido, sin variaciones
 echo "$NOMBRE" >> "$DICCIONARIO"
 echo "$APELLIDO1" >> "$DICCIONARIO"
 echo "$APELLIDO2" >> "$DICCIONARIO"

 read -p "Fecha nacimiento (DDMMYYYY): " DATO
 echo "$DATO" >> "$DICCIONARIO"

 read -p "Edad: " DATO
 echo "$DATO" >> "$DICCIONARIO"

 read -p "Primer hobby: " DATO
 echo "$DATO" >> "$DICCIONARIO"

 read -p "Segundo hobby: " DATO
 echo "$DATO" >> "$DICCIONARIO"

 read -p "Tercer hobby: " DATO
 echo "$DATO" >> "$DICCIONARIO"

 read -p "Deporte favorito: " DATO
 echo "$DATO" >> "$DICCIONARIO"

 read -p "Nombre mascota: " DATO
 echo "$DATO" >> "$DICCIONARIO"

 read -p "Nombre empresa: " DATO
 echo "$DATO" >> "$DICCIONARIO"

 echo "Diccionario creado en $TMPDIR"
}

probar_con_john() {
 PASS="$1"

 echo "Generando variaciones con John..."

 # Intentar con diferentes sets de reglas
 if john --wordlist=$DICCIONARIO --rules=Jumbo --stdout > "$TMPDIR/variaciones.txt" 2>/dev/null && [ -s "$TMPDIR/variaciones.txt" ]; then
 echo "Usando reglas: Jumbo"
 elif john --wordlist=$DICCIONARIO --rules=All --stdout > "$TMPDIR/variaciones.txt" 2>/dev/null && [ -s "$TMPDIR/variaciones.txt" ]; then
 echo "Usando reglas: All"
 elif john --wordlist=$DICCIONARIO --rules --stdout > "$TMPDIR/variaciones.txt" 2>/dev/null && [ -s "$TMPDIR/variaciones.txt" ]; then
 echo "Usando reglas: Por defecto"
 else
 echo "Generando variaciones manualmente..."
 > "$TMPDIR/variaciones.txt"

 while read -r PALABRA; do
 echo "$PALABRA" >> "$TMPDIR/variaciones.txt"
 echo "${PALABRA,,}" >> "$TMPDIR/variaciones.txt"
 echo "${PALABRA^^}" >> "$TMPDIR/variaciones.txt"
 echo "${PALABRA^}" >> "$TMPDIR/variaciones.txt"

 NUM=0
 while [ $NUM -le 99 ]; do
 echo "${PALABRA}${NUM}" >> "$TMPDIR/variaciones.txt"
 echo "${PALABRA^}${NUM}" >> "$TMPDIR/variaciones.txt"
 NUM=$((NUM + 1))
 done

 for CHAR in @ ! "#" "$" % "&" "*"; do
 NUM=0
 while [ $NUM -le 9 ]; do
 echo "${PALABRA}${CHAR}${NUM}" >> "$TMPDIR/variaciones.txt"
 echo "${PALABRA^}${CHAR}${NUM}" >> "$TMPDIR/variaciones.txt"
 NUM=$((NUM + 1))
 done
 done
 done < "$DICCIONARIO"

 PALABRAS=($(cat "$DICCIONARIO"))
 i=0
 while [ $i -lt ${#PALABRAS[@]} ]; do
 j=0
 while [ $j -lt ${#PALABRAS[@]} ]; do
 if [ $i -ne $j ]; then
 echo "${PALABRAS[$i]}${PALABRAS[$j]}" >> "$TMPDIR/variaciones.txt"
 echo "${PALABRAS[$i]^}${PALABRAS[$j]}" >> "$TMPDIR/variaciones.txt"

 NUM=0
 while [ $NUM -le 9 ]; do
 echo "${PALABRAS[$i]}${PALABRAS[$j]}${NUM}" >> "$TMPDIR/variaciones.txt"
 echo "${PALABRAS[$i]^}${PALABRAS[$j]}${NUM}" >> "$TMPDIR/variaciones.txt"
 NUM=$((NUM + 1))
 done

 for CHAR in @ ! "#" "$"; do
 NUM=0
 while [ $NUM -le 9 ]; do
 echo "${PALABRAS[$i]}${CHAR}${PALABRAS[$j]}${NUM}" >> "$TMPDIR/variaciones.txt"
 echo "${PALABRAS[$i]^}${CHAR}${PALABRAS[$j]}${NUM}" >> "$TMPDIR/variaciones.txt"
 NUM=$((NUM + 1))
 done
 done
 fi
 j=$((j + 1))
 done
 i=$((i + 1))
 done
 fi

 TOTAL_VAR=$(wc -l < "$TMPDIR/variaciones.txt")
 echo "Variaciones generadas: $TOTAL_VAR"
 echo "Progreso: 25%"

 HASH=$(openssl passwd -6 -salt xyz "$PASS")
 echo "$USUARIO:$HASH" > "$HASHFILE"

 echo "Progreso: 50%"
 echo "Probando contraseña..."

 timeout 30 john --session=$SESION_JOHN --wordlist=$TMPDIR/variaciones.txt --format=crypt $HASHFILE > /dev/null 2>&1 &
 PID=$!

 sleep 8
 echo "Progreso: 75%"
 sleep 7

 wait $PID 2>/dev/null
 echo "Progreso: 100%"

 RESULTADO=$(john --show "$HASHFILE" 2>/dev/null)

 if echo "$RESULTADO" | grep -q "$USUARIO:"; then
 echo "INSEGURA - Usa datos personales"
 echo "Archivos en: $TMPDIR"
 return 1
 else
 echo "SEGURA - Aprobada"
 echo "Archivos temporales en: $TMPDIR"
 return 0
 fi
}

guardar_pass() {
 PASS="$1"
 mkdir -p $(dirname $HISTORIAL)
 echo "$PASS" >> "$HISTORIAL"
}

# PROGRAMA PRINCIPAL
echo "RENOVACIÓN DE CONTRASEÑA - $INTENTOS intentos"

INTENTO=0

while [ $INTENTO -lt $INTENTOS ]; do
 echo ""
 echo "Intento $((INTENTO + 1))/$INTENTOS"

 read -s -p "Contraseña ACTUAL: " PASS_ACTUAL
 echo ""

 # Verificar con passwd
 echo -e "$PASS_ACTUAL\n$PASS_ACTUAL" | passwd $USUARIO > /dev/null 2>&1
 if [ $? -ne 0 ]; then
 echo "ERROR: Contraseña incorrecta"
 INTENTO=$((INTENTO + 1))
 continue
 fi

 read -s -p "NUEVA contraseña: " PASS_NUEVA
 echo ""
 read -s -p "Repite contraseña: " PASS_NUEVA2
 echo ""

 if [ "$PASS_NUEVA" != "$PASS_NUEVA2" ]; then
 echo "ERROR: No coinciden"
 INTENTO=$((INTENTO + 1))
 continue
 fi

 if ! comprobar_reglas "$PASS_NUEVA"; then
 INTENTO=$((INTENTO + 1))
 continue
 fi

 if ! comprobar_historial "$PASS_NUEVA"; then
 INTENTO=$((INTENTO + 1))
 continue
 fi

 if ! comprobar_patrones "$PASS_NUEVA"; then
 INTENTO=$((INTENTO + 1))
 continue
 fi

 # Crear diccionario siempre
 crear_diccionario

 if probar_con_john "$PASS_NUEVA"; then
 echo "CONTRASEÑA ACEPTADA"
 guardar_pass "$PASS_NUEVA"
 echo "Válida por 6 meses"
 echo ""
 echo "NOTA: Los archivos temporales se borrarán en el próximo reinicio"
 exit 0
 else
 echo "Prueba otra contraseña"
 INTENTO=$((INTENTO + 1))
 fi
done

echo ""
echo "INTENTOS AGOTADOS - Contacta administrador"
echo "Archivos temporales guardados en: $TMPDIR"
exit 1
