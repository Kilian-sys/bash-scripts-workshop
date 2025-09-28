#!/bin/bash
cat /etc/invisible.txt > errors.log 2>&1
echo "Alguna cosa ha fallat! Revisa errors.log"
