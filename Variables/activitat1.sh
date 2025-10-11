#!/bin/bash
# Variables Globals
echo "SHELL: $SHELL"
echo "DISPLAY: $DISPLAY"
echo "HOME: $HOME"
echo "PATH: $PATH"
echo "MANPATH: $MANPATH"
echo "PS1: $PS1"
echo "USER: $USER"
echo "TERM: $TERM"
echo "PWD: $PWD"
echo ""

# Arguments de Shell
echo "Nom del script (\$0): $0"
echo "Primer argument (\$1): $1"
echo "Segon argument (\$2): $2"
echo "Tercer argument (\$3): $3"
echo "Tots els arguments (\$*): $*"
echo "Arguments separats (\$@): $@"
echo "Nombre total d'arguments (\$#): $#"
echo ""

# Valor retornat per l'ultima comanda executada i PID de Shell actual
echo "PID del Shell actual (\$\$): $$"
echo "Exit code de l'última comanda (\$?): $?"
