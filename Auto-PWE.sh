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
ruta_actual=""

function update_rutes(){
    clear && banner
    echo && sudo whoami > /dev/null 2>&1;
    clear && banner
    echo -e "\n${yellow}[*] Actualizando rutas del sistema...\n${end}"
    sudo updatedb # Actualizar rutas
    ruta_actual=$(locate Auto-PWE.sh | sed "s/\/Auto-PWE.sh//")
    if [[ "$(echo $?)" == "0" ]]; then
        if [[ "$(echo $ruta_actual | wc -l)" == 1 ]]; then
		    : # Rutas actualizadas con exito
        else
            echo -e "${red}\n[!] Al paracer hay más de 1 archivo llamado \"Auto-PWE.sh\"${end}"
            echo -e "${red}[!] Asegúrese de tener 1 solo archivo con ese nombre!${end}"
            exit 1
        fi
	else
		echo -e "${red}\n[!] No se encontró ningún archivo llamado \"Auto-PWE.sh\".${end}"
        echo -e "${red}[!] Renombre el archivo con el nombre especificado anteriormente, y asegúrese de que se encuentre en el mismo directorio donde se encuentran los otros archivos de configuración.${end}"
		exit 1
	fi
}; update_rutes

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
		echo -e "\n${purple}[?] ¿Ves que falta actualizar el sistema?${end}"
        echo -ne "${red}[!] Si ha actualizado el sistema anteriormente y hay menos de 50 paquetes por instalar, puede proseguir tranquilamente con la instalación.${end}\n\n\t - [${yellow}1${end}] Si\n\t - [${yellow}2${end}] No\n\t - Opción: "
		read option
		if [[ $option == 1 ]]; then
			while true;do
				echo -e "${red}\n[?] Indique cual es la distribución de Linux que está usando:\n${end}"
				echo -e "${blue}\t - ${end}${yellow}[1]${end}${blue} Kali Linux${end}"
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
    sudo apt purge redshift redshift-gtk -y > /dev/null 2>&1
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
	cp $ruta_actual/bspwmrc ~/.config/bspwm/
	cat ~/.config/bspwm/bspwmrc | sed "s/username/$(whoami)/g" > ~/.config/bspwm/bspwmrc
	chmod u+x ~/.config/bspwm/bspwmrc
	rm ~/.config/sxhkd/sxhkdrc
    cp $ruta_actual/sxhkdrc ~/.config/sxhkd/
	cat ~/.config/sxhkd/sxhkdrc | sed "s/username/$(whoami)/g" > ~/.config/sxhkd/sxhkdrc
	cp $ruta_actual/bspwm_resize ~/.config/bspwm/scripts/ && chmod +x ~/.config/bspwm/scripts/bspwm_resize
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
	cp $ruta_actual/FondoDePantalla.jpg ~/Wallpapers/ ; comprobacion
	echo -e "${yellow}\n [*] Realizando algunas configuraciones\n${end}"
	cp $ruta_actual/compton.conf ~/.config/compton/ ; comprobacion
}

function scripts(){
	# Eliminando existencias
	rm -f -r ~/.config/bin 2>/dev/null
	# Añadiendo scripts
	mkdir ~/.config/bin; comprobacion
	echo -e "${yellow}\n[*] Añadiendo scripts...\n${end}"
	#cd ~/.config/bin
	cp $ruta_actual/hackthebox.sh ~/.config/bin/ && chmod +x ~/.config/bin/hackthebox.sh
	cp $ruta_actual/ethernet_status.sh ~/.config/bin/ && chmod +x ~/.config/bin/ethernet_status.sh
	echo -e '#!/bin/bash\n\necho -e "%{F#FF0000} %{F#e2ee6a}$(whoami)%{u-}"' > ~/.config/bin/$(whoami).sh && chmod +x ~/.config/bin/$(whoami).sh
    #while true; do
        #echo -e "${purple}[?] ¿Tienes netbook o notebook?${end}\n${red}[!] Esta pregunta es para instalar un módulo sobre la batería${end}"
        #echo -ne "\t- [${yellow}1${end}] Si\n\t- [${yellow}2${end}] No\n\t- Opción: "
        #read check_battery
        #if [ $check_battery == 1 ]; then
            #cp $ruta_actual/battery.sh ~/.config/bin/
            #sed -i 's/sep alsa sep/sep battery sep alsa sep/' ~/.config/polybar/config.ini
            #break
        #elif [ $check_battery == 2 ]; then
            #break
        #else
            #:
        #fi
    #done
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
		echo -e "\n${red}[!] Se recomienda usar las opciones de forma ordenada, es decir, primero el 1, y si nos da un error, probamos con el 2, y si este no funciona, probamos con el 3.${end}"
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
	cp -r $ruta_actual/polybar-themes/ ~/
	while true; do
		echo -ne "\n${purple}[?] Elija el tema a instalar${end}\n${cyan}[!] Se recomienda el número 11.${end}\n\t- Tema: "
		read num_theme
		if (($num_theme >= 1 && $num_theme <= 13)); then
			rm ~/.config/polybar/launch.sh 2>/dev/null
			cd ~/polybar-themes/polybar-$num_theme
			mkdir -p ~/.local/share/fonts
			cp -r fonts/* ~/.local/share/fonts
			fc-cache -v
			sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf 2>/dev/null
			cp -r * ~/.config/polybar
			~/.config/polybar/launch.sh 2>/dev/null
			while [ 0 = 0 ]; do
				echo -e "\n${yellow}[*] Presione las teclas: Windows + Alt + R para actualizar las configuraciones${end}"
				echo -ne "\n${purple}[?] ¿Estas conforme con el estilo de la polybar?${end}\n\n\t - [${yellow}1${end}] Si\n\t - [${yellow}2${end}] No\n\t - Opción: "
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
			echo -ne "${purple}\n[?] ¿Quieres instalar la configuración de s4vitar?${end}\n\n\t - [${yellow}1${end}] Si\n\t - [${yellow}2${end}] No\n\t - Opción: "
			read option2
			if [[ $option2 == 1 ]]; then
				echo -e "\n${yellow}[+] Instalando la configuración de s4vitar${end}"
				rm -f -r ~/.config/polybar 2>/dev/null
				tar -xf $ruta_actual/Comprimido.tar -C ~/.config/ 
				rm ~/.config/polybar/launch.sh
				rm ~/.config/polybar/config.ini
				cp $ruta_actual/launch.sh ~/.config/polybar/ && sleep 1 && chmod +x ~/.config/polybar/launch.sh
				cp $ruta_actual/config.ini ~/.config/polybar/
				cat ~/.config/polybar/config.ini | sed "s/username/$(whoami)/g" > ~/.config/polybar/config.ini
				scripts
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
	cd && git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
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
    sed -i "s/status                  # exit/#status                  # exit/" ~/.p10k.zsh
    sed -i "s/command_execution_time  # duration/#command_execution_time  # duration/" ~/.p10k.zsh
	sed -i "s/background_jobs         # presence/#background_jobs         # presence/" ~/.p10k.zsh
	sed -i "s/direnv                  # direnv/#direnv                  # direnv/" ~/.p10k.zsh
	sed -i "s/asdf                    # asdf/#asdf                    # asdf/" ~/.p10k.zsh
	sed -i "s/virtualenv              # python/#virtualenv              # python/" ~/.p10k.zsh
	sed -i "s/anaconda                # conda/#anaconda                # conda/" ~/.p10k.zsh
	sed -i "s/pyenv                   # python/#pyenv                   # python/" ~/.p10k.zsh
	sed -i "s/goenv                   # go/#goenv                   # go/" ~/.p10k.zsh
	sed -i "s/nodenv                  # node.js/#nodenv                  # node.js/" ~/.p10k.zsh
	sed -i "s/nvm                     # node.js/#nvm                     # node.js/" ~/.p10k.zsh
	sed -i "s/nodeenv                 # node.js/#nodeenv                 # node.js/" ~/.p10k.zsh
	sed -i "s/rbenv                   # ruby/#rbenv                   # ruby/" ~/.p10k.zsh
	sed -i "s/rvm                     # ruby/#rvm                     # ruby/" ~/.p10k.zsh
	sed -i "s/fvm                     # flutter/#fvm                     # flutter/" ~/.p10k.zsh
	sed -i "s/luaenv                  # lua/#luaenv                  # lua/" ~/.p10k.zsh
	sed -i "s/jenv                    # java/#jenv                    # java/" ~/.p10k.zsh
	sed -i "s/plenv                   # perl/#plenv                   # perl/" ~/.p10k.zsh
	sed -i "s/phpenv                  # php/#phpenv                  # php/" ~/.p10k.zsh
	sed -i "s/scalaenv                # scala/#scalaenv                # scala/" ~/.p10k.zsh
	sed -i "s/haskell_stack           # haskell/#haskell_stack           # haskell/" ~/.p10k.zsh
	sed -i "s/kubecontext             # current/#kubecontext             # current/" ~/.p10k.zsh
	sed -i "s/terraform               # terraform/#terraform               # terraform/" ~/.p10k.zsh
	sed -i "s/aws                     # aws/#aws                     # aws/" ~/.p10k.zsh
	sed -i "s/aws_eb_env              # aws/#aws_eb_env              # aws/" ~/.p10k.zsh
	sed -i "s/azure                   # azure/#azure                   # azure/" ~/.p10k.zsh
	sed -i "s/gcloud                  # google/#gcloud                  # google/" ~/.p10k.zsh
	sed -i "s/google_app_cred         # google/#google_app_cred         # google/" ~/.p10k.zsh
	sed -i "s/context                 # user@hostname/#context                 # user@hostname/" ~/.p10k.zsh
	sed -i "s/nordvpn                 # nordvpn/#nordvpn                 # nordvpn/" ~/.p10k.zsh
	sed -i "s/ranger                  # ranger/#ranger                  # ranger/" ~/.p10k.zsh
	sed -i "s/nnn                     # nnn/#nnn                     # nnn/" ~/.p10k.zsh
	sed -i "s/vim_shell               # vim/#vim_shell               # vim/" ~/.p10k.zsh
	sed -i "s/midnight_commander      # midnight/#midnight_commander      # midnight/" ~/.p10k.zsh
	sed -i "s/nix_shell               # nix/#nix_shell               # nix/" ~/.p10k.zsh
	sed -i "s/vi_mode                 # vi/#vi_mode                 # vi/" ~/.p10k.zsh
	sed -i "s/todo                    # todo/#todo                    # todo/" ~/.p10k.zsh
	sed -i "s/timewarrior             # timewarrior/#timewarrior             # timewarrior/" ~/.p10k.zsh
	sed -i "s/taskwarrior             # taskwarrior/#taskwarrior             # taskwarrior/" ~/.p10k.zsh
	sed -i "s/vcs                     # git status/vcs                     # git status\n    status\n    command_execution_time\n    context/" ~/.p10k.zsh
}

function powerlevel10k_zsh_root_config(){
	echo -e "${yellow}\n[*] Realizando algunas configuraciones para el usuario root...\n${end}"
    sudo sed -i "s/status                  # exit/#status                  # exit/" /root/.p10k.zsh
    sudo sed -i "s/command_execution_time  # duration/#command_execution_time  # duration/" /root/.p10k.zsh
    sudo sed -i "s/background_jobs         # presence/#background_jobs         # presence/" /root/.p10k.zsh
    sudo sed -i "s/direnv                  # direnv/#direnv                  # direnv/" /root/.p10k.zsh
    sudo sed -i "s/asdf                    # asdf/#asdf                    # asdf/" /root/.p10k.zsh
    sudo sed -i "s/virtualenv              # python/#virtualenv              # python/" /root/.p10k.zsh
    sudo sed -i "s/anaconda                # conda/#anaconda                # conda/" /root/.p10k.zsh
    sudo sed -i "s/pyenv                   # python/#pyenv                   # python/" /root/.p10k.zsh
    sudo sed -i "s/goenv                   # go/#goenv                   # go/" /root/.p10k.zsh
    sudo sed -i "s/nodenv                  # node.js/#nodenv                  # node.js/" /root/.p10k.zsh
    sudo sed -i "s/nvm                     # node.js/#nvm                     # node.js/" /root/.p10k.zsh
    sudo sed -i "s/nodeenv                 # node.js/#nodeenv                 # node.js/" /root/.p10k.zsh
    sudo sed -i "s/rbenv                   # ruby/#rbenv                   # ruby/" /root/.p10k.zsh
    sudo sed -i "s/rvm                     # ruby/#rvm                     # ruby/" /root/.p10k.zsh
    sudo sed -i "s/fvm                     # flutter/#fvm                     # flutter/" /root/.p10k.zsh
    sudo sed -i "s/luaenv                  # lua/#luaenv                  # lua/" /root/.p10k.zsh
    sudo sed -i "s/jenv                    # java/#jenv                    # java/" /root/.p10k.zsh
    sudo sed -i "s/plenv                   # perl/#plenv                   # perl/" /root/.p10k.zsh
    sudo sed -i "s/phpenv                  # php/#phpenv                  # php/" /root/.p10k.zsh
    sudo sed -i "s/scalaenv                # scala/#scalaenv                # scala/" /root/.p10k.zsh
    sudo sed -i "s/haskell_stack           # haskell/#haskell_stack           # haskell/" /root/.p10k.zsh
    sudo sed -i "s/kubecontext             # current/#kubecontext             # current/" /root/.p10k.zsh
    sudo sed -i "s/terraform               # terraform/#terraform               # terraform/" /root/.p10k.zsh
    sudo sed -i "s/aws                     # aws/#aws                     # aws/" /root/.p10k.zsh
    sudo sed -i "s/aws_eb_env              # aws/#aws_eb_env              # aws/" /root/.p10k.zsh
    sudo sed -i "s/azure                   # azure/#azure                   # azure/" /root/.p10k.zsh
    sudo sed -i "s/gcloud                  # google/#gcloud                  # google/" /root/.p10k.zsh
    sudo sed -i "s/google_app_cred         # google/#google_app_cred         # google/" /root/.p10k.zsh
    sudo sed -i "s/context                 # user@hostname/#context                 # user@hostname/" /root/.p10k.zsh
    sudo sed -i "s/nordvpn                 # nordvpn/#nordvpn                 # nordvpn/" /root/.p10k.zsh
    sudo sed -i "s/ranger                  # ranger/#ranger                  # ranger/" /root/.p10k.zsh
    sudo sed -i "s/nnn                     # nnn/#nnn                     # nnn/" /root/.p10k.zsh
    sudo sed -i "s/vim_shell               # vim/#vim_shell               # vim/" /root/.p10k.zsh
    sudo sed -i "s/midnight_commander      # midnight/#midnight_commander      # midnight/" /root/.p10k.zsh
    sudo sed -i "s/nix_shell               # nix/#nix_shell               # nix/" /root/.p10k.zsh
    sudo sed -i "s/vi_mode                 # vi/#vi_mode                 # vi/" /root/.p10k.zsh
    sudo sed -i "s/todo                    # todo/#todo                    # todo/" /root/.p10k.zsh
    sudo sed -i "s/timewarrior             # timewarrior/#timewarrior             # timewarrior/" /root/.p10k.zsh
    sudo sed -i "s/taskwarrior             # taskwarrior/#taskwarrior             # taskwarrior/" /root/.p10k.zsh
    sudo sed -i "s/vcs                     # git status/vcs                     # git status\n    status\n    command_execution_time\n    context/" /root/.p10k.zsh
    sudo sed -i "s/typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='.*'/typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE=''/" /root/.p10k.zsh
    sudo sed -i "s/typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='.*'/#typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'/" /root/.p10k.zsh
    sudo sed -i "s/typeset -g POWERLEVEL9K_CONTEXT_PREFIX='.*'/#typeset -g POWERLEVEL9K_CONTEXT_PREFIX='with '/" /root/.p10k.zsh
	echo -e "${yellow}\n[*] Ajustando algunas configuraciones...\n${end}"
    # Eliminando existencias
	sudo rm /root/.zshrc
	sudo rm /home/$username/.zshrc
    cp $ruta_actual/zshrc_config /home/$username/
	sed -i "s/user_name/$username/" /home/$username/zshrc_config && mv /home/$username/zshrc_config /home/$username/.zshrc
	sudo chown $username:$username /home/$username/.zshrc 
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
	chmod +x /usr/share/zsh-sudo/sudo.plugin.zsh
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
            clear
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
            clear
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
            clear
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
            clear
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
            clear
            banner
			echo -e "${red}\n[!] Ejecutar este paso como root...\n${end}"
			echo -e "\n\t - ${cyan}sudo ./Auto-PWE.sh 5\n${end}"
		fi
	else
        clear
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
