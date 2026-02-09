#!/bin/bash

# Variables
usuari=$1
servidor=$2
LOG="control_servidor.log"

# Funció informació usuari
info_usuari() {
	echo "INFORMACIO USUARI"
	echo ""

	ssh "$usuari@$servidor" << 'EOF'
echo "Usuari: $(whoami)"
echo "ID: $(id -u)"
echo "Grups: $(groups)"
echo "HOME: $HOME"
echo ""
EOF
}

# Funció veure directori
veure_directori() {
	echo "DIRECTORI ACTUAL"
	echo ""

	ssh "$usuari@$servidor" << 'EOF'
echo "Directori: $(pwd)"
echo ""
ls -lh
echo ""
EOF
}

# Funció verificar DHCP
verificar_dhcp() {
	echo "VERIFICAR SERVEI DHCP"
	echo ""

	ssh "$usuari@$servidor" << 'EOF'
systemctl is-active isc-dhcp-server dhcpd &>/dev/null
if [ $? -eq 0 ]; then
	echo "DHCP: ACTIU"
else
	echo "DHCP: INACTIU"
fi
echo ""
EOF
}

# Funció verificar DNS
verificar_dns() {
	echo "VERIFICAR SERVEI DNS"
	echo ""

	ssh "$usuari@$servidor" << 'EOF'
systemctl is-active bind9 named dnsmasq &>/dev/null
if [ $? -eq 0 ]; then
	echo "DNS: ACTIU"
else
	echo "DNS: INACTIU"
fi
echo ""
EOF
}

# Funció verificar SSH
verificar_ssh() {
	echo "VERIFICAR SERVEI SSH"
	echo ""

	ssh "$usuari@$servidor" << 'EOF'
systemctl is-active ssh sshd &>/dev/null
if [ $? -eq 0 ]; then
	echo "SSH: ACTIU"
else
	echo "SSH: INACTIU"
fi
echo ""
EOF
}

# Funció comprovar si nmap està instal·lat
comprovar_nmap() {
	ssh "$usuari@$servidor" << 'EOF'
command -v nmap &>/dev/null
if [ $? -ne 0 ]; then
	echo "NMAP no esta instal·lat"
	echo "Instal·lant NMAP..."
	sudo apt-get update -qq
	sudo apt-get install -y nmap -qq

	command -v nmap &>/dev/null
	if [ $? -eq 0 ]; then
		echo "NMAP instal·lat correctament"
		echo ""
	else
		echo "Error instal·lant NMAP"
	fi
fi
EOF
}

# Funció llistar hosts actius
llistar_hosts() {
	echo "HOSTS ACTIUS A LA XARXA"
	echo ""

	comprovar_nmap

	ssh "$usuari@$servidor" << 'EOF'
echo "Escanejant xarxa local..."
ip=$(hostname -I | awk '{print $1}')
xarxa=$(echo $ip | cut -d'.' -f1-3).0/24
nmap -sn $xarxa | grep "Nmap scan report" | awk '{print $5}'
echo ""
EOF
}

# Funció ports oberts
ports_oberts() {
	echo "PORTS OBERTS"
	echo ""

	comprovar_nmap

	ssh "$usuari@$servidor" << 'EOF'
echo "Escanejant ports oberts..."
nmap localhost | grep "open"
echo ""
EOF
}

# Funció comprovar internet
comprovar_internet() {
	echo "SORTIDA A INTERNET"
	echo ""

	ssh "$usuari@$servidor" << 'EOF'
ping -c 2 8.8.8.8 &>/dev/null
if [ $? -eq 0 ]; then
	echo "Internet: SI"
else
	echo "Internet: NO"
fi

ping -c 2 google.com &>/dev/null
if [ $? -eq 0 ]; then
	echo "DNS: SI"
else
	echo "DNS: NO"
fi
echo ""
EOF
}

# Menú principal
menu() {
	cat << 'EOF'

CONTROL DE SERVIDOR REMOT

1) Informacio usuari
2) Veure directori
3) Verificar serveis
4) Hosts actius
5) Ports oberts
6) Sortida Internet
7) Sortir

EOF
	read -p "Opcio: " opcio
}

# Submenú verificar serveis
submenu_serveis() {
	cat << 'EOF'

VERIFICAR SERVEIS

1) Verificar DHCP
2) Verificar DNS
3) Verificar SSH
4) Tornar

EOF
	read -p "Opcio: " subopcio
}

# Verificar arguments
if [ $# -ne 2 ]; then
	echo "Error: S'ha d'introduir 2 arguments amb l'usuari i el seu servidor a connectar"
	exit 1
fi

# Comprovar connectivitat
ping -c 1 "$servidor" &>/dev/null
if [ $? -eq 0 ]; then
	echo "Servidor OK"
else
	echo "Error: servidor no accessible"
	exit 1
fi

# Comprovar SSH
ssh -o ConnectTimeout=10 "$usuari@$servidor" "echo OK" &>/dev/null
if [ $? -eq 0 ]; then
	echo "SSH OK"
else
	echo "Error: SSH fallida"
	exit 1
fi

echo ""

# Bucle principal
continuar="si"

while [ $continuar == "si" ]; do
	menu

	case $opcio in
		1)
			echo ""
			info_usuari
			;;
		2)
			echo ""
			veure_directori
			;;
		3)
			continuar_sub="si"
			while [ $continuar_sub == "si" ]; do
				echo ""
				submenu_serveis

				case $subopcio in
					1)
						echo ""
						verificar_dhcp
						;;
					2)
						echo ""
						verificar_dns
						;;
					3)
						echo ""
						verificar_ssh
						;;
					4)
						continuar_sub="no"
						;;
					*)
						echo "Opcio incorrecta"
						;;
				esac

				if [ $continuar_sub == "si" ]; then
					read -p "ENTER per continuar..."
				fi
			done
			;;
		4)
			echo ""
			llistar_hosts
			;;
		5)
			echo ""
			ports_oberts
			;;
		6)
			echo ""
			comprovar_internet
			;;
		7)
			continuar="no"
			echo ""
			echo "Sortint..."
			echo ""
			;;
		*)
			echo ""
			echo "Opcio incorrecta"
			;;
	esac

	if [ $continuar == "si" ]; then
		echo ""
		read -p "ENTER per continuar..."
	fi
done

exit 0
