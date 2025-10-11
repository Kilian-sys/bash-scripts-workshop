#!/bin/bash
# tr ' ' '\n' converteix els espais en salts de línia
echo "$@" | tr ' ' '\n'
echo ""
echo "Nombre d'arguments utilitzats: $#"
