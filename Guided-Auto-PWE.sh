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
file=$(readlink -f $0)
current_path=$(dirname $file)
info_path=$current_path/info

function help(){
	echo -e "${cyan}\n$(cat $info_path/$info_lang | awk 'NR==14')${end}"
	echo -e "\n\t- ${yellow}./Guided-Auto-PWE.sh 1${end} $(cat $info_path/$info_lang | awk 'NR==15')"
	echo -e "\t- ${yellow}./Guided-Auto-PWE.sh 2${end} $(cat $info_path/$info_lang | awk 'NR==16')"
	echo -e "\t- ${yellow}./Guided-Auto-PWE.sh 3${end} $(cat $info_path/$info_lang | awk 'NR==17')"
	echo -e "\t- ${yellow}sudo ./Guided-Auto-PWE.sh 4${end} $(cat $info_path/$info_lang | awk 'NR==18')"
	echo -e "\t- ${yellow}sudo ./Guided-Auto-PWE.sh 5${end} $(cat $info_path/$info_lang | awk 'NR==19')"
	echo -e "${cyan}\n$(cat $info_path/$info_lang | awk 'NR==110')${end}"
	echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==21')${end}"
	echo; exit 1
}

function check(){
	if [[ "$(echo $?)" == "0" ]]; then
		echo -e "${cyan}\n$(cat $info_path/$info_lang | awk 'NR==24')\n${end}"
	else
		echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==25')\n${end}"
		exit 1
	fi
}

function press_key(){
	echo -e "\n${red}$(cat $info_path/$info_lang | awk 'NR==28')${end}" && read
}

function updates_and_dependencies(){
	# Actualizando el sistema
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==31')\n${end}"
	while true; do
		sudo apt update; check
		echo -e "\n${purple}$(cat $info_path/$info_lang | awk 'NR==32')${end}"
		echo -e "${red}$(cat $info_path/$info_lang | awk 'NR==33')${end}"
		echo -ne "\n\t - [${yellow}1${end}] $(cat $info_path/$info_lang | awk 'NR==2')\n\t - [${yellow}2${end}] $(cat $info_path/$info_lang | awk 'NR==3')\n\t $(cat $info_path/$info_lang | awk 'NR==4') "
		read option
		if [[ $option == 1 ]]; then
			while true;do
				echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==34')\n${end}"
				echo -e "${blue}\t - ${end}${yellow}[1]${end}${blue} Kali Linux${end}"
				echo -ne "${green}\t - ${end}${yellow}[2]${end}${green} Parrot${end}\n\t $(cat $info_path/$info_lang | awk 'NR==4') "
				read linux_distribution
				if [ $linux_distribution == 1 ];then
					echo -ne "${red}\n$(cat $info_path/$info_lang | awk 'NR==7') ${end}${cyan}\"Kali Linux\"${end}.\n${red}$(cat $info_path/$info_lang | awk 'NR==8')${end}${yellow}1${end}${red}$(cat $info_path/$info_lang | awk 'NR==9') ${end}"
					read confirm_kali
					if [ $confirm_kali == 1 ]; then
						echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==35')\n${end}"
						echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}sudo apt upgrade${end}"; press_key
						sudo apt upgrade -y; check
						break
					else
						:
					fi
				elif [ $linux_distribution == 2 ];then
					echo -ne "${red}\n$(cat $info_path/$info_lang | awk 'NR==7') ${end}${green}\"Parrot\"${end}.\n${red}$(cat $info_path/$info_lang | awk 'NR==8')${end}${yellow}1${end}${red}$(cat $info_path/$info_lang | awk 'NR==9') ${end}"
					read confirm_parrot
					if [ $confirm_parrot == 1 ]; then
						echo -e "${yellow}\n\$(cat $info_path/$info_lang | awk 'NR==36')n${end}"
						echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2')${end}${yellow}sudo parrot-upgrade${end}"; press_key
						sudo parrot-upgrade -y; check
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
			echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==37')${end}"
		fi
	done
	clear && banner && echo
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==38')\n${end}"
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==7')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk 'NR==8')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==9')${end}"; press_key
	sudo apt-get install libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev -y; check
	clear && banner && echo
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==12')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk 'NR==13')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==14')${end}"; press_key
	sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev -y; check
	clear && banner && echo
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==17')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk 'NR==18')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==19')${end}"; press_key
	sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y; check
	sudo apt purge redshift redshift-gtk -y > /dev/null 2>&1 # Eliminar problema de redshift
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
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==41')\n${end}"
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==22')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk 'NR==23')"; press_key
	sudo apt install bspwm rofi gnome-terminal dunst scrub xclip -y
	# Instalación de bspwm y sxhkd
	echo && echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==26')${end}"
	for i in $(seq 27 30); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==31')${end}"; press_key
	cd && git clone https://github.com/baskerville/bspwm.git
	git clone https://github.com/baskerville/sxhkd.git
	cd bspwm && make && sudo make install
	cd ../sxhkd && make && sudo make install
	# Configuracion y ejecución de bspwm
	#cd && cp /usr/local/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
	#cp /usr/local/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
	echo && echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==32')${end}"
	for i in $(seq 33 38); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==39')${end}"; press_key
	mkdir -p ~/.config/{bspwm,sxhkd}
	mkdir ~/.config/bspwm/scripts
	rm ~/.config/bspwm/bspwmrc 2>/dev/null
	cp $current_path/bspwmrc ~/.config/bspwm/
	cat ~/.config/bspwm/bspwmrc | sed "s/username/$(whoami)/g" > ~/.config/bspwm/bspwmrc
	chmod u+x ~/.config/bspwm/bspwmrc
	rm ~/.config/sxhkd/sxhkdrc 2>/dev/null
	cp $current_path/sxhkdrc ~/.config/sxhkd/
	cat ~/.config/sxhkd/sxhkdrc | sed "s/username/$(whoami)/g" > ~/.config/sxhkd/sxhkdrc
	cp $current_path/bspwm_resize ~/.config/bspwm/scripts/ && chmod +x ~/.config/bspwm/scripts/bspwm_resize
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==40')${end}"
	for i in $(seq 41 42); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done; press_key
	touch ~/.xinitrc
	echo -e "sxhkd &\nexec bspwm" > ~/.xinitrc
}

function compton_and_feh(){
	# Eliminando existencias
	rm -f -r ~/.config/compton 2>/dev/null
	# Instalando compton
	mkdir ~/.config/compton
	mkdir -p ~/Wallpapers 2>/dev/null
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==44')\n${end}"
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==45')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk 'NR==46')${end}"; press_key
	sudo apt install compton feh -y; check
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==45')\n${end}"
	cp $current_path/FondoDePantalla.jpg ~/Wallpapers/ ; check
	cp $current_path/compton.conf ~/.config/compton/ ; check
}

function scripts(){
	# Eliminando existencias
	rm -f -r ~/.config/bin 2>/dev/null
	# Añadiendo scripts
	mkdir ~/.config/bin; check
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==48')\n${end}"
	#cd ~/.config/bin
	cp $current_path/hackthebox.sh ~/.config/bin/ && chmod +x ~/.config/bin/hackthebox.sh
	cp $current_path/ethernet_status.sh ~/.config/bin/ && chmod +x ~/.config/bin/ethernet_status.sh
	echo -e '#!/bin/bash\n\necho -e "%{F#FF0000} %{F#e2ee6a}$(whoami)%{u-}"' > ~/.config/bin/$(whoami).sh && chmod +x ~/.config/bin/$(whoami).sh
	#while true; do
		#echo -e "${purple}[?] ¿Tienes netbook o notebook?${end}\n${red}[!] Esta pregunta es para instalar un módulo sobre la batería${end}"
		#echo -ne "\t- [${yellow}1${end}] Si\n\t- [${yellow}2${end}] No\n\t- Opción: "
		#read check_battery
		#if [ $check_battery == 1 ]; then
			#cp $current_path/battery.sh ~/.config/bin/
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
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==51')${end}"
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==49')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk 'NR==50')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==51')${end}"; press_key
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
	sudo whoami > /dev/null 2>&1; check
	while true; do
		clear
		banner
		echo -e "\n${purple}$(cat $info_path/$info_lang | awk 'NR==54')${end}\n\n\t - [${yellow}1${end}] $(cat $info_path/$info_lang | awk 'NR==55')\n\t - [${yellow}2${end}] $(cat $info_path/$info_lang | awk 'NR==56')"
		echo -e "\n${red}$(cat $info_path/$info_lang | awk 'NR==57')${end}"
		echo -ne "\n\t$(cat $info_path/$info_lang | awk 'NR==4') "
		read opcion_polybar
		if [ $opcion_polybar == 1 ]; then
			sudo rm -f -r /opt/polybar/ 2>/dev/null # Eliminar existencia
			echo -e "\n${yellow}$(cat $info_path/$info_lang | awk 'NR==58')\n${end}"
			cd /opt
			sudo rm -f /opt/polybar-3.4.3.tar 2>/dev/null # Eliminar existencia
			echo && echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==54')${end}"
			echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk 'NR==55')${end}"
			echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==56')${end}"; press_key
			sudo wget https://github.com/polybar/polybar/releases/download/3.4.3/polybar-3.4.3.tar; check
			sudo tar -xf polybar-3.4.3.tar; check
			sudo rm -f /opt/polybar-3.4.3.tar
			echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==57')${end}"
			for i in $(seq 58 61); do
				echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
			done
			echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==62')${end}"; press_key
			cd /opt/polybar && sudo mkdir build && cd build
			sudo cmake .. ; check
			sudo make -j$(nproc); check
			sudo make install; check
			break
		elif [ $opcion_polybar == 2 ]; then
			# Eliminar existencia
			sudo rm -f -r /opt/polybar/ 2>/dev/null
			echo -e "\n${yellow}$(cat $info_path/$info_lang | awk 'NR==58')\n${end}"
			echo -e "${cyan}$(cat $info_path/$guide_lang | awk 'NR==2')${end}${yellow}$(cat $info_path/$guide_lang | awk 'NR==63')${end}"; press_key
			sudo apt install polybar -y; check
			break
		else
			:
		fi
	done
	echo -e "\n${cyan}$(cat $info_path/$info_lang | awk 'NR==59')${end}"
	num_theme=0
	option=0
	key=0
	while [ $key != 1 ]; do
		clear && banner && echo
		echo -e "${purple}$(cat $info_path/$info_lang | awk 'NR==60') Hack Nerd Font - Hack Nerd Font Mono Regular\n${end}"
		echo -e "${cyan}\t$(cat $info_path/$info_lang | awk 'NR==61')${end}"
		echo -e "${green}\t$(cat $info_path/$info_lang | awk 'NR==62')${end}"
		echo -e "${purple}\t$(cat $info_path/$info_lang | awk 'NR==63')${end}\n"
		echo -ne "${purple}\t$(cat $info_path/$info_lang | awk 'NR==10')${end}${yellow}1${end}${purple}$(cat $info_path/$info_lang | awk 'NR==11') ${end}"
		read key
	done
	clear && banner && echo
	echo -e "\n${yellow}$(cat $info_path/$info_lang | awk 'NR==64')\n${end}"
	cp -r $current_path/polybar-themes/ ~/
	while true; do
		echo -ne "\n${purple}$(cat $info_path/$info_lang | awk 'NR==65')${end}\n${cyan}$(cat $info_path/$info_lang | awk 'NR==66')${end}\n\t$(cat $info_path/$info_lang | awk 'NR==67') "
		read num_theme
		if (($num_theme >= 1 && $num_theme <= 13)); then
			echo && echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==66')${end}"
			for i in $(seq 67 74); do
				echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
			done
			echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==4') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==75')${end}"; press_key
			rm ~/.config/polybar/launch.sh 2>/dev/null
			cd ~/polybar-themes/polybar-$num_theme
			mkdir -p ~/.local/share/fonts
			cp -r fonts/* ~/.local/share/fonts
			fc-cache -v
			sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf 2>/dev/null
			cp -r * ~/.config/polybar
			~/.config/polybar/launch.sh 2>/dev/null
			while [ 0 = 0 ]; do
				echo -e "\n${yellow}$(cat $info_path/$info_lang | awk 'NR==68')${end}"
				echo -ne "\n${purple}$(cat $info_path/$info_lang | awk 'NR==69')${end}\n\n\t - [${yellow}1${end}] $(cat $info_path/$info_lang | awk 'NR==2')\n\t - [${yellow}2${end}] $(cat $info_path/$info_lang | awk 'NR==3')\n\t$(cat $info_path/$info_lang | awk 'NR==4') "
				read option
				if [[ $option == 1 ]]; then
					echo -e "\n${cyan}$(cat $info_path/$info_lang | awk 'NR==70')${end}"
					break
				elif [[ $option == 2 ]]; then
					break
				else
					:
				fi
			done
		else
			echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==71')${end}"
		fi
		if [ $option == 1 ];then
			break
		fi
	done
	if [ $num_theme == 11 ];then
		while true; do
			echo -ne "${purple}\n$(cat $info_path/$info_lang | awk 'NR==72')${end}\n\n\t - [${yellow}1${end}] $(cat $info_path/$info_lang | awk 'NR==2')\n\t - [${yellow}2${end}] $(cat $info_path/$info_lang | awk 'NR==3')\n\t$(cat $info_path/$info_lang | awk 'NR==4') "
			read option2
			if [[ $option2 == 1 ]]; then
				echo -e "\n${yellow}$(cat $info_path/$info_lang | awk 'NR==73')${end}"
				rm -f -r ~/.config/polybar 2>/dev/null
				tar -xf $current_path/Comprimido.tar -C ~/.config/ 
				rm ~/.config/polybar/launch.sh
				rm ~/.config/polybar/config.ini
				cp $current_path/launch.sh ~/.config/polybar/ && sleep 1 && chmod +x ~/.config/polybar/launch.sh
				cp $current_path/config.ini ~/.config/polybar/
				cat ~/.config/polybar/config.ini | sed "s/username/$(whoami)/g" > ~/.config/polybar/config.ini
				scripts
				sleep 1
				~/.config/polybar/launch.sh 2>/dev/null ;check
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
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==76') $(whoami)${end}\n"
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==78')${end}"
	for i in $(seq 79 80); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==81')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==82') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==83')${end}"; press_key
	cd && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k; check
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc; check
	echo -e "${purple}\n$(cat $info_path/$info_lang | awk 'NR==77') $(whoami)\n${end}"
	sleep 5
	zsh
}

function powerlevel10k_zsh_root(){
	# Eliminar existencias
	sudo rm -f -r /root/powerlevel10k 2>/dev/null
	sudo rm -f /root/.zshrc 2>/dev/null
	# Instalando powerlevel10k
	sudo echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==76') root${end}\n"
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==86')${end}"
	for i in $(seq 87 88); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==3') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==89')${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==137') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==138')${end}"; press_key
	sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k; check
	sudo echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> /root/.zshrc; check
	echo -e "${purple}\n$(cat $info_path/$info_lang | awk 'NR==77') root\n${end}"
	sleep 5
	sudo zsh
}

function powerlevel10k_zsh_username_config(){
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==80') $(whoami)...\n${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==4') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==92')${end}"; press_key
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
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==80') $(whoami)\n${end}"
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==4') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==95')${end}"; press_key
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
	echo -e "${yellow}\n$(cat $info_path/$info_lang | awk 'NR==81')\n${end}"
	# Eliminando existencias
	sudo rm /root/.zshrc
	sudo rm /home/$username/.zshrc
	echo -e "${cyan}$(cat $info_path/$info_lang | awk 'NR==82')${end}"
	cp $current_path/zshrc_config /home/$username/
	sed -i "s/user_name/$username/" /home/$username/zshrc_config && mv /home/$username/zshrc_config /home/$username/.zshrc
	sudo chown $username:$username /home/$username/.zshrc
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk 'NR==98')${end}"; press_key
	sudo ln -s -f /home/$username/.zshrc /root/.zshrc
	echo -e "\n${cyan}$(cat $info_path/$info_lang | awk 'NR==83')${end}\n"
	for i in $(seq 101 102); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done; press_key
	sudo usermod --shell /usr/bin/zsh $username 2>/dev/null
	sudo usermod --shell /usr/bin/zsh root 2>/dev/null
	echo -e "\n${yellow}$(cat $info_path/$info_lang | awk 'NR==84')${end}\n"
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==105')${end}"
	for i in $(seq 106 107); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==108') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==109')${end}"; press_key
	cd /opt && sudo wget https://github.com/Peltoche/lsd/releases/download/0.18.0/lsd_0.18.0_amd64.deb
	sudo dpkg -i lsd_0.18.0_amd64.deb && sleep 1 && sudo rm lsd_0.18.0_amd64.deb
	echo -e "\n${yellow}$(cat $info_path/$info_lang | awk 'NR==85')${end}\n"
	echo -e "${blue}$(cat $info_path/$guide_lang | awk 'NR==112')${end}"
	for i in $(seq 113 114); do
    	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done
	echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==108') ${end}${purple}$(cat $info_path/$guide_lang | awk 'NR==115')${end}"; press_key
	sudo wget https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb
	sudo dpkg -i bat_0.17.1_amd64.deb && sleep 1 && sudo rm bat_0.17.1_amd64.deb
}

function plugins(){
	echo -e "${yellow}$(cat $info_path/$info_lang | awk 'NR==88')\n${end}"
	for i in $(seq 118 120); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done
	for i in $(seq 121 124); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done
	for i in $(seq 125 126); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==108') ${end}${purple}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done; press_key
	sudo apt install zsh-syntax-highlighting zsh-autosuggestions -y
	cd /usr/share && sudo mkdir zsh-sudo && cd zsh-sudo && sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
	chmod +x /usr/share/zsh-sudo/sudo.plugin.zsh
	cd /usr/share && sudo chown $username:$username -R zsh-*
}

function fzf_username(){
	sudo rm -f -r /home/$username/.fzf 2>/dev/null # Eliminar existencia
	echo -e "${yellow}$(cat $info_path/$info_lang | awk 'NR==91') $(whoami)...\n${end}"
	for i in $(seq 129 130); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done; press_key
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

function fzf_root(){
	sudo rm -f -r /root/.fzf 2>/dev/null # Eliminar existencia
	echo -e "${yellow}$(cat $info_path/$info_lang | awk 'NR==91') $(whoami)...\n${end}"
	for i in $(seq 133 134); do
		echo -e "\t${cyan}$(cat $info_path/$guide_lang | awk 'NR==2') ${end}${yellow}$(cat $info_path/$guide_lang | awk "NR==$i")${end}"
	done; press_key
	sudo git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
	/root/.fzf/install
}

function select_language(){
	while true; do
		clear && banner && echo
		echo -e "\n${cyan}[*] Select language / Seleccione el idioma:${end}"
		echo -e "\t${yellow}[1] Spanish / Español${end}"
		echo -e "\t${yellow}[2] English / Inglés${end}"
		echo -ne "\t${yellow}[?] Option/Opción [1/2]: ${end}"
		read lang
		case $lang in
			1) info_lang="info_es.txt"
			guide_lang="guide_mode_es.txt"
			break;;
			2) info_lang="info_en.txt"
			guide_lang="guide_mode_en.txt"
			break;;
			*) echo -e "${red}\n[-] Wrong number / Número incorrecto${end}"
			exit 1;;
		esac
	done
}; select_language

if [[ $# -eq 1 ]]; then
	sudo whoami > /dev/null 2>&1
	if [[ $1 == 1 ]];then
		if [[ "$(whoami)" != "root" ]]; then
			clear; banner; echo
			updates_and_dependencies
			clear; banner; echo
			bspwm_and_sxhkd
			clear; banner; echo
			compton_and_feh
			clear; banner; echo
			font
			option4=0
			while [ $option4 != 1 ]; do
				clear; banner; echo
				echo -e "${cyan}$(cat $info_path/$info_lang | awk 'NR==94')${end}"
				echo -e "${red}$(cat $info_path/$info_lang | awk 'NR==95')${end}"
				echo -ne "${red}$(cat $info_path/$info_lang | awk 'NR==10')${end}${yellow}1${end}${red}$(cat $info_path/$info_lang | awk 'NR==11') ${end}"
				read option4
			done
			echo -e "${cyan}\n$(cat $info_path/$info_lang | awk 'NR==96')${end}"
			echo -e "${red}$(cat $info_path/$info_lang | awk 'NR==95')${end}"
			kill -9 -1
		else
			clear; banner; echo
			echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==97')\n${end}"
			echo -e "\n\t - ${yellow}./Auto-PWE.sh 1${end}"
			echo -e "\t - ${yellow}./Guided-Auto-PWE.sh 1${end} ${gray}$(cat $info_path/$info_lang | awk 'NR==98')${end}"

		fi
	elif [[ $1 == 2 ]];then
		if [[ "$(whoami)" != "root" ]]; then
			username=$(whoami)
			clear; banner; echo
			polybar
			clear; banner; echo
			powerlevel10k_zsh_username
		else
			clear; banner; echo
			echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==97')\n${end}"
			echo -e "\n\t - ${yellow}./Auto-PWE.sh 2${end}"
			echo -e "\t - ${yellow}./Guided-Auto-PWE.sh 2${end} ${gray}$(cat $info_path/$info_lang | awk 'NR==98')${end}"
		fi
	elif [[ $1 == 3 ]];then
		if [[ "$(whoami)" != "root" ]]; then
			username=$(whoami)
			clear; banner; echo
			powerlevel10k_zsh_username_config
			clear; banner; echo
			fzf_username
		else
			clear; banner; echo
			echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==97')\n${end}"
			echo -e "\n\t - ${yellow}./Auto-PWE.sh 3${end}"
			echo -e "\t - ${yellow}./Guided-Auto-PWE.sh 3${end} ${gray}$(cat $info_path/$info_lang | awk 'NR==98')${end}"
		fi
	elif [[ $1 == 4 ]];then
		if [[ "$(whoami)" == "root" ]]; then
			clear; banner; echo
			powerlevel10k_zsh_root
		else
			clear; banner; echo
			echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==99')${end}"
			echo -e "\n\t - ${yellow}sudo ./Auto-PWE.sh 4\n${end}"
			echo -e "\t - ${yellow}sudo ./Guided-Auto-PWE.sh 4${end} ${gray}$(cat $info_path/$info_lang | awk 'NR==98')${end}"
		fi
	elif [[ $1 == 5 ]];then
		if [[ "$(whoami)" == "root" ]]; then
			clear; banner; echo
			echo -ne "${yellow}$(cat $info_path/$info_lang | awk 'NR==100') ${end}"
			read username
			grep $username /etc/passwd >/dev/null 2>&1
			if [[ "$(echo $?)" == "0" ]]; then
				echo -ne "${red}$(cat $info_path/$info_lang | awk 'NR==101') ${end}${cyan}$username${end}${red}\n$(cat $info_path/$info_lang | awk 'NR==8')${end}${yellow}1${end}${red}$(cat $info_path/$info_lang | awk 'NR==9') ${end}"
				read option3
				if [ $option3 == 1 ]; then
					clear; banner; echo
					powerlevel10k_zsh_root_config
					clear; banner; echo
					plugins
					clear; banner; echo
					fzf_root
					option5=0
					while [ $option5 != 1 ]; do
						clear; banner; echo
						echo -e "${cyan}\n$(cat $info_path/$info_lang | awk 'NR==102')${end}"
						echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==103')${end}"
						echo -ne "${red}\n$(cat $info_path/$info_lang | awk 'NR==10')${end}${yellow}1${end}${red}$(cat $info_path/$info_lang | awk 'NR==11') ${end}"
						read option5
					done
					shutdown -r 0
				else
					exit 1
				fi
			else
				echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==104') $username $(cat $info_path/$info_lang | awk 'NR==105')\n${end}"
				exit 1
			fi
		else
			clear; banner; echo
			echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==99')\n${end}"
			echo -e "\n\t - ${yellow}sudo ./Auto-PWE.sh 5${end}"
			echo -e "\t - ${yellow}sudo ./Guided-Auto-PWE.sh 5${end} ${gray}$(cat $info_path/$info_lang | awk 'NR==98')${end}"
		fi
	else
		clear
		banner
		echo -e "${red}\n$(cat $info_path/$info_lang | awk 'NR==106')\n${end}"
		help
	fi
else
	clear
	banner
	echo
	echo -e "${red}$(cat $info_path/$info_lang | awk 'NR==107')${end}"
	help
fi
