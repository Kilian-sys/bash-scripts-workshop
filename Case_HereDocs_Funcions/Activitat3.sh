#!/bin/bash

usuari="paco"
direccio="192.168.10.20"

ssh $usuari@$direccio << "EOF"
echo "Nom de l'usuari: $(whoami)"
echo ""

echo "ID de l'usuari: $(id)"
echo ""

echo "Nom de la màquina: $(hostname)"
echo ""

echo "Grups de l'usuari: $(groups)"
echo ""
EOF

