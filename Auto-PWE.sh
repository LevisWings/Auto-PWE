#!/bin/bash

#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
cyan="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

# Banner
function banner(){
	echo 
	echo -e "  ░█████╗░██╗░░░██╗████████╗░█████╗░░░░░░░██████╗░░██╗░░░░░░░██╗███████╗"
	echo -e "  ██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗░░░░░░██╔══██╗░██║░░██╗░░██║██╔════╝\t\t   ${cyan}Auto Professional Work Environment${end}"
	echo -e "  ███████║██║░░░██║░░░██║░░░██║░░██║█████╗██████╔╝░╚██╗████╗██╔╝█████╗░░\tScript to customize the work environment automatically"
	echo -e "  ██╔══██║██║░░░██║░░░██║░░░██║░░██║╚════╝██╔═══╝░░░████╔═████║░██╔══╝░░\t\t\t   Inspired by ${red}s4vitar${end}"
	echo -e "  ██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝░░░░░░██║░░░░░░░╚██╔╝░╚██╔╝░███████╗    Video by s4vitar: https://www.youtube.com/watch?v=66IAhBI0bCM"
	echo -e "  ╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░░░░░░░╚═╝░░░░░░░░╚═╝░░░╚═╝░░╚══════╝\t\t\t  Created by ${blue}leviswings${end}"
}

# Declaracion de variables
username=""

function help(){
	echo -e "${yellow}\n[?] Uso para instalar el entorno de trabajo:${end}"
	echo -e "\n\t - ${cyan}./Auto-PWE.sh 1${end} -> Para actualizar el sistema, instalar utilidades y fuentes necesarias..."
	echo -e "\t - ${cyan}./Auto-PWE.sh 2${end} -> Para seleccionar el tema de la polybar y el powerlevel10k..."
	echo -e "\t - ${cyan}./Auto-PWE.sh 3${end} -> Para ajustar configuraciones del .p10k.zsh e instalar el fzf para el usuario..."
	echo -e "\t - ${cyan}sudo ./Auto-PWE.sh 4${end} -> Para instalar powerlevel10k para el usuario root..."
	echo -e "\t - ${cyan}sudo ./Auto-PWE.sh 5${end} -> Para ajustar configuraciones, instalar plugins y el fzf para root..."
	echo -e "${red}\n[!] Ejecutar todos los 5 pasos de manera ordenada.${end}"
	echo
	exit 1
}

function comprobacion(){
	if [[ "$(echo $?)" == "0" ]]; then
		echo -e "${cyan}\n[+] Acción realizada con éxito\n${end}"
	else
		echo -e "${red}\n[!] Ocurrió un error\n${end}"
		exit 1
	fi
}

function updates_directories_dependencies(){
	# Actualizando el sistema
	echo -e "${yellow}\n[*] Buscando actualizaciones del sistema...\n${end}"
	while true; do
		sudo apt update; comprobacion
		echo -ne "\n${purple}[?] ¿Ves que falta actualizar el sistema?${end}\n\n\t - [${yellow}1${end}] Si\n\t - [${yellow}2${end}] No\n\t - Opción: "
		read option
		if [[ $option == 1 ]]; then
			while true;do
				echo -e "${red}\n[?] Indique cual es la distribución de Linux que está usando:\n${end}"
				echo -e "${blue}\t - ${end}${yellow}[1]${end}${blue} Kali Linux 2020.4${end}"
				echo -ne "${green}\t - ${end}${yellow}[2]${end}${green} Parrot${end}\n\t - Opción: "
				read distribution_linux
				if [ $distribution_linux == 1 ];then
					echo -ne "${red}\n[?] Usted a elegido a ${end}${cyan}\"Kali Linux\"${end}${red}. Presione la tecla [${end}${yellow}1${end}${red}] para confirmar (o cualquier tecla para cancelar): ${end}"
					read confirm_kali
					if [ $confirm_kali == 1 ]; then
						echo -e "${yellow}\n[*] Actualizando el sistema Kali Linux...\n${end}"
						sudo apt upgrade -y; comprobacion
						break
					else
						:
					fi
				elif [ $distribution_linux == 2 ];then
					echo -ne "${red}\n[?] Usted a elegido a ${end}${green}\"Parrot\"${end}${red}. Presione la tecla [${end}${yellow}1${end}${red}] para confirmar (o cualquier tecla para cancelar): ${end}"
					read confirm_parrot
					if [ $confirm_parrot == 1 ]; then
						echo -e "${yellow}\n[*] Actualizando el sistema Parrot...\n${end}"
						sudo parrot-upgrade -y; comprobacion
						break
					else
						:
					fi
				else
					:
				fi
			done
		elif [[ $option == 2 ]]; then
			break
		else
			echo -e "${red}\n[!] Opción incorrecta. Realizando nuevamente la comprobación de actualizaciones...${end}"
		fi
	done
	echo -e "${yellow}\n[*] Instalando dependencias...\n${end}"
	sudo apt-get install libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev -y
	sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev -y
	sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y
}

function bspwm_and_sxhkd(){
	# Eliminando existencias
	rm -f -r -p ~/.config/{bspwm,sxhkd} 2>/dev/null
	rm -f -r ~/.config/bspwm/scripts 2>/dev/null
	rm -f -r ~/bspwm 2>/dev/null
	rm -f -r ~/sxhkd 2>/dev/null
	sudo rm -f /usr/local/share/doc/bspwm/examples/bspwmrc 2>/dev/null
	sudo rm -f /usr/local/share/doc/bspwm/examples/sxhkdrc 2>/dev/null
	rm -f ~/.xinitrc 2>/dev/null
	echo -e "${yellow}\n[*] Instalando bspwm y otros programas...\n${end}"
	# Instalación de bspwm y sxhkd
	mkdir -p ~/.config/{bspwm,sxhkd}
	mkdir ~/.config/bspwm/scripts
	sudo apt install bspwm rofi gnome-terminal dunst scrub xclip -y
	cd && git clone https://github.com/baskerville/bspwm.git
	git clone https://github.com/baskerville/sxhkd.git
	cd bspwm && make && sudo make install
	cd ../sxhkd && make && sudo make install
	cd && cp /usr/local/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
	cp /usr/local/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
	touch ~/.xinitrc
	echo -e "sxhkd &\nexec bspwm" > ~/.xinitrc
	rm ~/.config/bspwm/bspwmrc
	cd ~/.config/bspwm && wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/bspwmrc
	cat ~/.config/bspwm/bspwmrc | sed "s/username/$(whoami)/g" > ~/.config/bspwm/bspwmrc
	chmod u+x ~/.config/bspwm/bspwmrc
	rm ~/.config/sxhkd/sxhkdrc
	cd ~/.config/sxhkd && wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/sxhkdrc
	cat ~/.config/sxhkd/sxhkdrc | sed "s/username/$(whoami)/g" > ~/.config/sxhkd/sxhkdrc
	cd ~/.config/bspwm/scripts && wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/bspwm_resize && chmod +x ~/.config/bspwm/scripts/bspwm_resize
}

function compton_and_feh(){
	# Eliminando existencias
	rm -f -r ~/.config/compton 2>/dev/null
	rm -r -f ~/Wallpapers 2>/dev/null
	# Instalando compton
	mkdir ~/.config/compton
	mkdir -p ~/Wallpapers
	echo -e "${yellow}\n[*] Instalando compton y feh...\n${end}"
	sudo apt install compton feh -y; comprobacion
	cd ~/Wallpapers/ && wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/FondoDePantalla.jpg ; comprobacion
	echo -e "${yellow}\n [*] Realizando algunas configuraciones\n${end}"
	cd ~/.config/compton/ && wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/compton.conf ; comprobacion
}

function scripts(){
	# Eliminando existencias
	rm -f -r ~/.config/bin 2>/dev/null
	# Añadiendo scripts
	mkdir ~/.config/bin; comprobacion
	echo -e "${yellow}\n[*] Añadiendo scripts...\n${end}"
	cd ~/.config/bin
	wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/hackthebox.sh && chmod +x hackthebox.sh
	wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/ethernet_status.sh && chmod +x ethernet_status.sh
	echo -e '#!/bin/bash\n\necho -e "%{F#FF0000} %{F#e2ee6a}$(whoami)%{u-}"' > $(whoami).sh && chmod +x $(whoami).sh
}

function font(){
	echo -e "${yellow}\n[*] Instalando la fuente Hack Nerd Font...${end}"
	cd /usr/local/share/fonts && sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip && sudo unzip Hack.zip
	sudo rm Hack.zip
	sleep 1
}

function polybar(){
	# Eliminar existencias
	rm -f -r ~/.config/polybar 2>/dev/null
	rm -f -r ~/polybar-themes 2>/dev/null
	# Instalar polybar y su tema
	mkdir ~/.config/polybar
	sudo whoami > /dev/null 2>&1; comprobacion
	while true; do
		clear
		banner
		echo -e "\n${purple}[?] Elige la opción a instalar para la polybar:${end}\n\n\t - [${yellow}1${end}] Compilación 1\n\t - [${yellow}2${end}] Compilación 2 (a prueba de errores)\n\t - [${yellow}3${end}] Método estable"
		echo -e "\n${red}[!] Se recomienda usar las opciones de forma ordenada, es decir, primero el 1, y si nos da un error, probamos con el 2, y si este no funciona, probamos con el 3${end}"
		echo -ne "\n\t - Opción: "
		read opcion_polybar
		if [ $opcion_polybar == 1 ]; then
			# Eliminar existencia
			sudo rm -f -r /opt/polybar/ 2>/dev/null
			echo -e "\n${yellow}[*] Inslando polybar...\n${end}"
			cd /opt
			sudo rm -f /opt/polybar-3.4.3.tar 2>/dev/null # Eliminar existencia
			sudo wget https://github.com/polybar/polybar/releases/download/3.4.3/polybar-3.4.3.tar; comprobacion
			sudo tar -xf polybar-3.4.3.tar; comprobacion
			sudo rm -f /opt/polybar-3.4.3.tar
			cd /opt/polybar && sudo mkdir build && cd build
			sudo cmake .. ; comprobacion
			sudo make -j$(nproc); comprobacion
			sudo make install; comprobacion
			break
		elif [ $opcion_polybar == 2 ]; then
			# Eliminar existencia
			sudo rm -f -r /opt/polybar/ 2>/dev/null
			echo -e "\n${yellow}[*] Inslando polybar...\n${end}"
			cd /opt
			sudo rm -f /opt/polybar-3.4.3.tar 2>/dev/null # Eliminar existencia
			sudo wget https://github.com/polybar/polybar/releases/download/3.4.3/polybar-3.4.3.tar; comprobacion
			sudo tar -xf polybar-3.4.3.tar; comprobacion
			sudo rm -f /opt/polybar-3.4.3.tar
			cd /opt/polybar && sudo mkdir build && cd build
			sudo cmake .. ; comprobacion
			# Bypass del error
			sudo mv /usr/lib/python3.9/fractions.py /usr/lib/python3.9/fractions.pyc
			sudo cp /usr/lib/python3.8/fractions.py /usr/lib/python3.9/fractions.py
			sudo make -j$(nproc)
			if [[ "$(echo $?)" == "0" ]]; then
				echo -e "${cyan}\n[+] Acción realizada con éxito\n${end}"
				sudo make install
				if [[ "$(echo $?)" == "0" ]]; then
					echo -e "${cyan}\n[+] Acción realizada con éxito\n${end}"
					sudo rm /usr/lib/python3.9/fractions.py
					sudo mv /usr/lib/python3.9/fractions.pyc /usr/lib/python3.9/fractions.py
				else
					sudo rm /usr/lib/python3.9/fractions.py
					sudo mv /usr/lib/python3.9/fractions.pyc /usr/lib/python3.9/fractions.py
					echo -e "${red}\n[!] Ocurrió un error\n${end}"
					exit 1
				fi
			else
				sudo rm /usr/lib/python3.9/fractions.py
				sudo mv /usr/lib/python3.9/fractions.pyc /usr/lib/python3.9/fractions.py
				echo -e "${red}\n[!] Ocurrió un error\n${end}"
				exit 1
			fi
			break
		elif [ $opcion_polybar == 3 ]; then
			# Eliminar existencia
			sudo rm -f -r /opt/polybar/ 2>/dev/null
			echo -e "\n${yellow}[*] Inslando polybar...\n${end}"
			sudo apt install polybar -y; comprobacion
			break
		else
			:
		fi
	done
	echo -e "\n${cyan}[+] Polybar instalada correctamente..."
	# FIN TESTING
	num_theme=0
	option=0
	key=0
	while [ $key != 1 ]; do
		echo -e "${purple}[*] Configure en su terminal la fuente o tipografía llamada:\n\t - Hack Nerd Font o Hack Nerd Font Mono Regular\n${end}"
		echo -e "${cyan}\t[!] En Kali Linux: Editar -> Preferencias -> Click en \"Tipografiía personalizada\" -> Seleccionamos la fuente${end}"
		echo -e "${green}\t[!] En Parrot: Editar -> Preferencias de perfil -> Desmarcar la casilla \"Usar la tipografia de ancho fijo del sistema\" -> Seleccionamos la fuente${end}"
		echo -e "${purple}\t[!] También puede cambiar el tamaño de la letra según sus preferencias${end}\n"
		echo -ne "${purple}\t[!] Pulse la tecla [${end}${yellow}1${end}${purple}] para continuar: ${end}"
		read key
	done
	clear
	banner
	echo
	echo -e "\n${yellow}[*] Instalando los temas para la polybar...\n${end}"
	cd && git clone https://github.com/LevisWings/Auto-PWE/
	mv Auto-PWE/polybar-themes/ .
	rm -f -r Auto-PWE
	while true; do
		echo -ne "\n${purple}[?] Elija el tema a instalar: ${end}"
		read num_theme
		if (($num_theme >= 1 && $num_theme <= 13)); then
			rm ~/.config/polybar/launch.sh 2>/dev/null
			chmod +x ~/polybar-themes/polybar-$num_theme/scripts/*
			chmod +x ~/polybar-themes/polybar-$num_theme/launch.sh
			chmod +x ~/polybar-themes/polybar-$num_theme/tester.sh 2>/dev/null
			if [ $num_theme == 8 ]; then
				chmod +x ~/polybar-themes/polybar-$num_theme/source/feather/scripts/*
				chmod +x ~/polybar-themes/polybar-$num_theme/source/material/scripts/*
				chmod +x ~/polybar-themes/polybar-$num_theme/source/siji/scripts/*
				chmod +x ~/polybar-themes/polybar-$num_theme/source/typicons/scripts/*
			fi
			cd ~/polybar-themes/polybar-$num_theme
			mkdir -p ~/.local/share/fonts
			cp -r fonts/* ~/.local/share/fonts
			fc-cache -v
			sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf 2>/dev/null
			cp -r * ~/.config/polybar
			~/.config/polybar/launch.sh 2>/dev/null
			while [ 0 = 0 ]; do
				echo -e "\n${yellow}[*] Presione las teclas: Windows + Alt + R para actualizar las configuraciones${end}"
				echo -ne "\n${purple}[?] ¿Estas conforme con el estilo de la polybar?\n\n\t - [${end}${yellow}1${end}${purple}] Si\n\t - [${end}${yellow}2${end}${purple}] No\n\t - Opción: ${end}"
				read option
				if [[ $option == 1 ]]; then
					echo -e "\n${cyan}[+] Tema instalado con éxito${end}"
					break
				elif [[ $option == 2 ]]; then
					break
				else
					:
				fi
			done
		else
			echo -e "${red}\n[!] Inserter un numero del 1 al 13!${end}"
		fi
		if [ $option == 1 ];then
			break
		fi
	done
	if [ $num_theme == 11 ];then
		while true; do
			echo -ne "${purple}\n[?] ¿Quieres instalar la configuración de s4vitar?${end}\n\n\t${purple} - [${end}${yellow}1${end}${purple}] Si\n\t - [${end}${yellow}2${end}${purple}] No\n\t - Opción: ${end}"
			read option2
			if [[ $option2 == 1 ]]; then
				echo -e "\n${yellow}[+] Instalando la configuración de s4vitar${end}"
				scripts
				rm -f -r ~/.config/polybar 2>/dev/null
				cd ~/.config && wget https://github.com/LevisWings/Auto_WE/raw/main/Comprimido.tar
				tar -xf Comprimido.tar && sleep 1 && rm Comprimido.tar ; comprobacion
				rm ~/.config/polybar/launch.sh
				rm ~/.config/polybar/config.ini
				cd ~/.config/polybar && wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/launch.sh && sleep 1 && chmod +x launch.sh
				cd ~/.config/polybar/ && wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/config.ini
				cat ~/.config/polybar/config.ini | sed "s/username/$(whoami)/g" > ~/.config/polybar/config.ini
				sleep 1
				~/.config/polybar/launch.sh 2>/dev/null ;comprobacion
				break
			elif [[ $option2 == 2 ]]; then
				break
			else
				:
			fi
		done
	fi
}

function powerlevel10k_zsh_username(){
	# Eliminar existencias
	rm -f -r ~/powerlevel10k 2>/dev/null
	rm -f ~/.zshrc 2>/dev/null
	# Instalando powerlevel10k
	echo -e "${yellow}\n[*] Instalando powerlevel10k para el usuario $(whoami)${end}\n"
	cd
	git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
	echo -e "${purple}\n[*] A continuación, se procederá a configurar el powerlevel10k para el usuario $(whoami)\n${end}"
	sleep 5
	zsh
}
function powerlevel10k_zsh_root(){
	# Eliminar existencias
	sudo rm -f -r /root/powerlevel10k 2>/dev/null
	sudo rm -f /root/.zshrc 2>/dev/null
	# Instalando powerlevel10k
	echo -e "${purple}\n[*] A continuación, se procederá a configurar el powerlevel10k para el usuario root\n${end}"
	sleep 5
	sudo git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git /root/powerlevel10k
	sudo echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> /root/.zshrc
	sudo zsh
}

function powerlevel10k_zsh_username_config(){
	echo -e "${yellow}\n[*] Realizando algunas configuraciones para el usuario $(whoami)...\n${end}"
	cat ~/.p10k.zsh | sed "s/status                  # exit/#status                  # exit/" >> ~/.p10k2.zsh; comprobacion
	cat ~/.p10k2.zsh | sed "s/command_execution_time  # duration/#command_execution_time  # duration/" > ~/.p10k3.zsh
	cat ~/.p10k3.zsh | sed "s/background_jobs         # presence/#background_jobs         # presence/" > ~/.p10k4.zsh
	cat ~/.p10k4.zsh | sed "s/direnv                  # direnv/#direnv                  # direnv/" > ~/.p10k5.zsh
	cat ~/.p10k5.zsh | sed "s/asdf                    # asdf/#asdf                    # asdf/" > ~/.p10k6.zsh
	cat ~/.p10k6.zsh | sed "s/virtualenv              # python/#virtualenv              # python/" > ~/.p10k7.zsh
	cat ~/.p10k7.zsh | sed "s/anaconda                # conda/#anaconda                # conda/" > ~/.p10k8.zsh
	cat ~/.p10k8.zsh | sed "s/pyenv                   # python/#pyenv                   # python/" > ~/.p10k9.zsh
	cat ~/.p10k9.zsh | sed "s/goenv                   # go/#goenv                   # go/" > ~/.p10k10.zsh
	cat ~/.p10k10.zsh | sed "s/nodenv                  # node.js/#nodenv                  # node.js/" > ~/.p10k11.zsh
	cat ~/.p10k11.zsh | sed "s/nvm                     # node.js/#nvm                     # node.js/" > ~/.p10k12.zsh
	cat ~/.p10k12.zsh | sed "s/nodeenv                 # node.js/#nodeenv                 # node.js/" > ~/.p10k13.zsh
	cat ~/.p10k13.zsh | sed "s/rbenv                   # ruby/#rbenv                   # ruby/" > ~/.p10k14.zsh
	cat ~/.p10k14.zsh | sed "s/rvm                     # ruby/#rvm                     # ruby/" > ~/.p10k15.zsh
	cat ~/.p10k15.zsh | sed "s/fvm                     # flutter/#fvm                     # flutter/" > ~/.p10k16.zsh
	cat ~/.p10k16.zsh | sed "s/luaenv                  # lua/#luaenv                  # lua/" > ~/.p10k17.zsh
	cat ~/.p10k17.zsh | sed "s/jenv                    # java/#jenv                    # java/" > ~/.p10k18.zsh
	cat ~/.p10k18.zsh | sed "s/plenv                   # perl/#plenv                   # perl/" > ~/.p10k19.zsh
	cat ~/.p10k19.zsh | sed "s/phpenv                  # php/#phpenv                  # php/" > ~/.p10k20.zsh
	cat ~/.p10k20.zsh | sed "s/scalaenv                # scala/#scalaenv                # scala/" > ~/.p10k21.zsh
	cat ~/.p10k21.zsh | sed "s/haskell_stack           # haskell/#haskell_stack           # haskell/" > ~/.p10k22.zsh
	cat ~/.p10k22.zsh | sed "s/kubecontext             # current/#kubecontext             # current/" > ~/.p10k23.zsh
	cat ~/.p10k23.zsh | sed "s/terraform               # terraform/#terraform               # terraform/" > ~/.p10k24.zsh
	cat ~/.p10k24.zsh | sed "s/aws                     # aws/#aws                     # aws/" > ~/.p10k25.zsh
	cat ~/.p10k25.zsh | sed "s/aws_eb_env              # aws/#aws_eb_env              # aws/" > ~/.p10k26.zsh
	cat ~/.p10k26.zsh | sed "s/azure                   # azure/#azure                   # azure/" > ~/.p10k27.zsh
	cat ~/.p10k27.zsh | sed "s/gcloud                  # google/#gcloud                  # google/" > ~/.p10k28.zsh
	cat ~/.p10k28.zsh | sed "s/google_app_cred         # google/#google_app_cred         # google/" > ~/.p10k29.zsh
	cat ~/.p10k29.zsh | sed "s/context                 # user@hostname/#context                 # user@hostname/" > ~/.p10k30.zsh
	cat ~/.p10k30.zsh | sed "s/nordvpn                 # nordvpn/#nordvpn                 # nordvpn/" > ~/.p10k31.zsh
	cat ~/.p10k31.zsh | sed "s/ranger                  # ranger/#ranger                  # ranger/" > ~/.p10k32.zsh
	cat ~/.p10k32.zsh | sed "s/nnn                     # nnn/#nnn                     # nnn/" > ~/.p10k33.zsh
	cat ~/.p10k33.zsh | sed "s/vim_shell               # vim/#vim_shell               # vim/" > ~/.p10k34.zsh
	cat ~/.p10k34.zsh | sed "s/midnight_commander      # midnight/#midnight_commander      # midnight/" > ~/.p10k35.zsh
	cat ~/.p10k35.zsh | sed "s/nix_shell               # nix/#nix_shell               # nix/" > ~/.p10k36.zsh
	cat ~/.p10k36.zsh | sed "s/vi_mode                 # vi/#vi_mode                 # vi/" > ~/.p10k37.zsh
	cat ~/.p10k37.zsh | sed "s/todo                    # todo/#todo                    # todo/" > ~/.p10k38.zsh
	cat ~/.p10k38.zsh | sed "s/timewarrior             # timewarrior/#timewarrior             # timewarrior/" > ~/.p10k39.zsh
	cat ~/.p10k39.zsh | sed "s/taskwarrior             # taskwarrior/#taskwarrior             # taskwarrior/" > ~/.p10k40.zsh
	cat ~/.p10k40.zsh | sed "s/vcs                     # git status/vcs                     # git status\n    status\n    command_execution_time\n    context/" > ~/.p10k41.zsh
	for (( i=0; i < 41; i++ )); do
    	rm ~/.p10k$i.zsh 2>/dev/null
	done
	mv ~/.p10k41.zsh ~/.p10k.zsh
}

function powerlevel10k_zsh_root_config(){
	echo -e "${yellow}\n[*] Realizando algunas configuraciones para el usuario root...\n${end}"
	sudo cat /root/.p10k.zsh | sudo sed "s/status                  # exit/#status                  # exit/" > /root/.p10k2.zsh
	sudo cat /root/.p10k2.zsh | sudo sed "s/command_execution_time  # duration/#command_execution_time  # duration/" > /root/.p10k3.zsh
	sudo cat /root/.p10k3.zsh | sudo sed "s/background_jobs         # presence/#background_jobs         # presence/" > /root/.p10k4.zsh
	sudo cat /root/.p10k4.zsh | sudo sed "s/direnv                  # direnv/#direnv                  # direnv/" > /root/.p10k5.zsh
	sudo cat /root/.p10k5.zsh | sudo sed "s/asdf                    # asdf/#asdf                    # asdf/" > /root/.p10k6.zsh
	sudo cat /root/.p10k6.zsh | sudo sed "s/virtualenv              # python/#virtualenv              # python/" > /root/.p10k7.zsh
	sudo cat /root/.p10k7.zsh | sudo sed "s/anaconda                # conda/#anaconda                # conda/" > /root/.p10k8.zsh
	sudo cat /root/.p10k8.zsh | sudo sed "s/pyenv                   # python/#pyenv                   # python/" > /root/.p10k9.zsh
	sudo cat /root/.p10k9.zsh | sudo sed "s/goenv                   # go/#goenv                   # go/" > /root/.p10k10.zsh
	sudo cat /root/.p10k10.zsh | sudo sed "s/nodenv                  # node.js/#nodenv                  # node.js/" > /root/.p10k11.zsh
	sudo cat /root/.p10k11.zsh | sudo sed "s/nvm                     # node.js/#nvm                     # node.js/" > /root/.p10k12.zsh
	sudo cat /root/.p10k12.zsh | sudo sed "s/nodeenv                 # node.js/#nodeenv                 # node.js/" > /root/.p10k13.zsh
	sudo cat /root/.p10k13.zsh | sudo sed "s/rbenv                   # ruby/#rbenv                   # ruby/" > /root/.p10k14.zsh
	sudo cat /root/.p10k14.zsh | sudo sed "s/rvm                     # ruby/#rvm                     # ruby/" > /root/.p10k15.zsh
	sudo cat /root/.p10k15.zsh | sudo sed "s/fvm                     # flutter/#fvm                     # flutter/" > /root/.p10k16.zsh
	sudo cat /root/.p10k16.zsh | sudo sed "s/luaenv                  # lua/#luaenv                  # lua/" > /root/.p10k17.zsh
	sudo cat /root/.p10k17.zsh | sudo sed "s/jenv                    # java/#jenv                    # java/" > /root/.p10k18.zsh
	sudo cat /root/.p10k18.zsh | sudo sed "s/plenv                   # perl/#plenv                   # perl/" > /root/.p10k19.zsh
	sudo cat /root/.p10k19.zsh | sudo sed "s/phpenv                  # php/#phpenv                  # php/" > /root/.p10k20.zsh
	sudo cat /root/.p10k20.zsh | sudo sed "s/scalaenv                # scala/#scalaenv                # scala/" > /root/.p10k21.zsh
	sudo cat /root/.p10k21.zsh | sudo sed "s/haskell_stack           # haskell/#haskell_stack           # haskell/" > /root/.p10k22.zsh
	sudo cat /root/.p10k22.zsh | sudo sed "s/kubecontext             # current/#kubecontext             # current/" > /root/.p10k23.zsh
	sudo cat /root/.p10k23.zsh | sudo sed "s/terraform               # terraform/#terraform               # terraform/" > /root/.p10k24.zsh
	sudo cat /root/.p10k24.zsh | sudo sed "s/aws                     # aws/#aws                     # aws/" > /root/.p10k25.zsh
	sudo cat /root/.p10k25.zsh | sudo sed "s/aws_eb_env              # aws/#aws_eb_env              # aws/" > /root/.p10k26.zsh
	sudo cat /root/.p10k26.zsh | sudo sed "s/azure                   # azure/#azure                   # azure/" > /root/.p10k27.zsh
	sudo cat /root/.p10k27.zsh | sudo sed "s/gcloud                  # google/#gcloud                  # google/" > /root/.p10k28.zsh
	sudo cat /root/.p10k28.zsh | sudo sed "s/google_app_cred         # google/#google_app_cred         # google/" > /root/.p10k29.zsh
	sudo cat /root/.p10k29.zsh | sudo sed "s/context                 # user@hostname/#context                 # user@hostname/" > /root/.p10k30.zsh
	sudo cat /root/.p10k30.zsh | sudo sed "s/nordvpn                 # nordvpn/#nordvpn                 # nordvpn/" > /root/.p10k31.zsh
	sudo cat /root/.p10k31.zsh | sudo sed "s/ranger                  # ranger/#ranger                  # ranger/" > /root/.p10k32.zsh
	sudo cat /root/.p10k32.zsh | sudo sed "s/nnn                     # nnn/#nnn                     # nnn/" > /root/.p10k33.zsh
	sudo cat /root/.p10k33.zsh | sudo sed "s/vim_shell               # vim/#vim_shell               # vim/" > /root/.p10k34.zsh
	sudo cat /root/.p10k34.zsh | sudo sed "s/midnight_commander      # midnight/#midnight_commander      # midnight/" > /root/.p10k35.zsh
	sudo cat /root/.p10k35.zsh | sudo sed "s/nix_shell               # nix/#nix_shell               # nix/" > /root/.p10k36.zsh
	sudo cat /root/.p10k36.zsh | sudo sed "s/vi_mode                 # vi/#vi_mode                 # vi/" > /root/.p10k37.zsh
	sudo cat /root/.p10k37.zsh | sudo sed "s/todo                    # todo/#todo                    # todo/" > /root/.p10k38.zsh
	sudo cat /root/.p10k38.zsh | sudo sed "s/timewarrior             # timewarrior/#timewarrior             # timewarrior/" > /root/.p10k39.zsh
	sudo cat /root/.p10k39.zsh | sudo sed "s/taskwarrior             # taskwarrior/#taskwarrior             # taskwarrior/" > /root/.p10k40.zsh
	sudo cat /root/.p10k40.zsh | sudo sed "s/vcs                     # git status/vcs                     # git status\n    status\n    command_execution_time\n    context/" > /root/.p10k41.zsh
	sudo cat /root/.p10k41.zsh | sudo sed "s/typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='.*'/typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE=''/" > /root/.p10k42.zsh
	sudo cat /root/.p10k42.zsh | sudo sed "s/typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'/#typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'/" > /root/.p10k43.zsh
	sudo cat /root/.p10k43.zsh | sudo sed "s/typeset -g POWERLEVEL9K_CONTEXT_PREFIX='.*'/#typeset -g POWERLEVEL9K_CONTEXT_PREFIX='with '/" > /root/.p10k44.zsh
	for (( i=0; i < 44; i++ )); do
    	rm /root/.p10k$i.zsh 2>/dev/null
	done
	mv /root/.p10k44.zsh /root/.p10k.zsh
	echo -e "${yellow}\n[*] Ajustando algunas configuraciones...\n${end}"
	sudo rm /root/.zshrc
	sudo rm /home/$username/.zshrc
	cd /home/$username && wget https://raw.githubusercontent.com/LevisWings/Auto_WE/main/zshrc_config
	cat /home/$username/zshrc_config | sed "s/user_name/$username/" > /home/$username/.zshrc
	sudo chown $username:$username /home/$username/.zshrc 
	rm /home/$username/zshrc_config
	sudo ln -s -f /home/$username/.zshrc /root/.zshrc
	sudo usermod --shell /usr/bin/zsh $username 2>/dev/null
	sudo usermod --shell /usr/bin/zsh root 2>/dev/null
	echo -e "\n${yellow}[*] Instalando lsd...${end}\n"
	cd /opt && sudo wget https://github.com/Peltoche/lsd/releases/download/0.18.0/lsd_0.18.0_amd64.deb
	sudo dpkg -i lsd_0.18.0_amd64.deb && sleep 1 && sudo rm lsd_0.18.0_amd64.deb
	echo -e "\n${yellow}[*] Instalando bat...${end}\n"
	sudo wget https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb
	sudo dpkg -i bat_0.17.1_amd64.deb && sleep 1 && sudo rm bat_0.17.1_amd64.deb
}

function plugins(){
	echo -e "${yellow}[*] Instalando plugins...\n${end}"
	sudo apt install zsh-syntax-highlighting zsh-autosuggestions -y
	cd /usr/share && sudo mkdir zsh-sudo && cd zsh-sudo && sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
	chmod +x sudo.plugin.zsh
	cd /usr/share && sudo chown $username:$username -R zsh-*
}

function fzf_username(){
	echo -e "${yellow}[*] Instalando fzf...\n${end}"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

function fzf_root(){
	echo -e "${yellow}[*] Instalando fzf para el usuario root...\n${end}"
	sudo git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
	/root/.fzf/install
}

if [ $# -eq 1 ]; then
	if [[ $1 == 1 ]];then
		if [[ "$(whoami)" != "root" ]]; then
			clear
			banner
			echo
			updates_directories_dependencies
			clear
			banner
			echo
			bspwm_and_sxhkd
			clear
			banner
			echo
			compton_and_feh
			clear
			banner
			echo
			font
			option4=0
			while [ $option4 != 1 ]; do
				clear
				banner
				echo
				echo -e "${cyan}\n[+] Actualizaciones, dependencias, programas y utilidades instalados exitosamente. Se procederá a reiniciar la sesión${end}"
				echo -e "${red}\n[!] Logearse indicando bspwm y ejecutar el script nuevamente para el paso 2...${end}"
				echo -ne "${red}\n[!] Presione la tecla [${end}${yellow}1${end}${red}] para confirmar: ${end}"
				read option4
			done
			echo -e "${cyan}\n[*] Reiniciando sesión${end}"
			echo -e "${red}\n[!] Logearse indicando bspwm y ejecutar el script nuevamente pero para el paso 2...${end}"
			sleep 10
			kill -9 -1
		else
			banner
			echo
			echo -e "${red}\n[!] Ejecutar este paso como un usuario normal...\n${end}"
			echo -e "\n\t - ${cyan}./Auto-PWE.sh 1${end}"

		fi
	elif [[ $1 == 2 ]];then
		if [[ "$(whoami)" != "root" ]]; then
			$username=$(whoami)
			clear
			banner
			echo
			polybar
			clear
			banner
			echo
			powerlevel10k_zsh_username
		else
			banner
			echo
			echo -e "${red}\n[!] Ejecutar este paso como un usuario normal...\n${end}"
			echo -e "\n\t - ${cyan}./Auto-PWE.sh 2\n${end}"
		fi
	elif [[ $1 == 3 ]];then
		if [[ "$(whoami)" != "root" ]]; then
			clear
			banner
			echo
			powerlevel10k_zsh_username_config
			clear
			banner
			echo
			echo
			fzf_username
		else
			banner
			echo
			echo -e "${red}\n[!] Ejecutar este paso como un usuario normal...\n${end}"
			echo -e "\n\t - ${cyan}./Auto-PWE.sh 3\n${end}"
		fi
	elif [[ $1 == 4 ]];then
		if [[ "$(whoami)" == "root" ]]; then
			clear
			banner
			echo
			powerlevel10k_zsh_root
		else
			banner
			echo
			echo -e "${red}\n[!] Ejecutar este paso como root...\n${end}"
			echo -e "\n\t - ${cyan}sudo ./Auto-PWE.sh 4\n${end}"
		fi
	elif [[ $1 == 5 ]];then
		if [[ "$(whoami)" == "root" ]]; then
			clear
			banner
			echo
			echo -ne "${yellow}[*] Ingrese su nombre de usuario (no root): ${end}"
			read username
			grep $username /etc/passwd >/dev/null 2>&1
			if [[ "$(echo $?)" == "0" ]]; then
				echo -ne "${red}[?] Usted ha introducido al siguiente usuario: ${end}${cyan}$username${end}${red}\n[?] Presione la tecla [${end}${yellow}1${end}${red}] para confirmar (o cualquier tecla para cancelar): ${end}"
				read option3
				if [ $option3 == 1 ]; then
					clear
					banner
					echo
					powerlevel10k_zsh_root_config
					clear
					banner
					echo
					plugins
					clear
					banner
					echo
					fzf_root
					option5=0
					while [ $option5 != 1 ]; do
						clear
						banner
						echo
						echo -e "${cyan}\n[+] Powerlevel10k, plugins, zsh y fzf instalada y configurada correctamente${end}"
						echo -e "${red}\n[!] Se procederá a reiniciar el equipo para aplicar todos los cambios${end}"
						echo -ne "${red}\n[!] Presione la tecla [${end}${yellow}1${end}${red}] para confirmar: ${end}"
						read option5
					done
					shutdown -r 0
				else
					exit 1
				fi
			else
				echo -e "${red}\n[!] El usuario $username no existe\n${end}"
				exit 1
			fi
		else
			echo -e "${red}\n[!] Ejecutar este paso como root...\n${end}"
			echo -e "\n\t - ${cyan}sudo ./Auto-PWE.sh 5\n${end}"
		fi
	else
		banner
		echo -e "${red}\n[!] Número incorrecto\n${end}"
		help
	fi
else
	clear
	banner
	echo
	echo -e "${red}[!] Cantidad de parámetros incorrectos..${end}"
	help
fi
