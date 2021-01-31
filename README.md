# Auto-PWE
Auto-PWE (Auto Professional Work Environment) es un script en bash que te permite convertir una distribución de Linux en un entorno de trabajo profesional de manera automática (style s4vitar). Sin embargo, este script también te permite personalizar varias utilidades como el estilo del powerlevel10k, el tema de la polybar, etc., de manera que no se configure todo en un solo estilo, sino que el usuario elija ciertas configuraciones según sus preferencias.
## Testeado en las siguientes distribuciones de Linux:
- Kali Linux 2020.4
- Parrot Security 4.10
## Instalación:
> Se recomienda hacer la instalación en una nueva ISO. Si esto no es posible, es decir, si está usando una máquina virtual usada, clonada o preconfigurada, recomiendo hacer una snapshot (instántanea) del estado de la máquina, debido a que puede generar problemas y/o conflitos en el transcurso de la instalación. La solución a esto está fuera de mi alcance.

**1)** Clonamos el repositorio:
```
git clone https://github.com/LevisWings/Auto-PWE
cd Auto-PWE
```
**2)** Ejecutamos y veremos los comandos a ejecutar:
```
./Auto-PWE.sh
```
**3)** Se deberá ejecutar todos los 5 pasos de manera ordenada.

**4)** Disfruta.
## Vista general
[![Professional Work Environment](https://github.com/LevisWings/Auto-PWE/blob/main/GeneralView/WorkEnvironment.png?raw=true "Professional Work Environment")](https://github.com/LevisWings/Auto-PWE/blob/main/GeneralView/WorkEnvironment.png?raw=true "Professional Work Environment")
[![Professional Work Environment](https://github.com/LevisWings/Auto-PWE/blob/main/GeneralView/Overview.png?raw=true "Overview")](https://github.com/LevisWings/Auto-PWE/blob/main/GeneralView/Overview.png?raw=true "Overview")
## Utilidades:
- bspwm: Tiling Window Manager (administrador de ventanas en mosaico). Autor: [baskerville](https://github.com/baskerville)
- zsh: Shell.
- powerlevel10k: Tema de la zsh. Autor: [romkatv](https://github.com/romkatv)
- sxhkd: Es un "demonio" que escucha los eventos del teclado y ejecuta comandos. Autor: [baskerville](https://github.com/baskerville)
- polybar: Herramienta rápida y fácil de usar para crear barras de estado.
- polybar-themes : Temas para la polybar. Autor: [adi1090x](https://github.com/adi1090x)
- compton: Es un compositor para X y una bifurcación de xcompmgr-dana. Autor: [chjj](https://github.com/chjj)
- rofi: Selector de ventana y lanzador de aplicaciones.
- feh: Visor de imágenes ligero, configurable y versátil.
- Hack Nerd Font: Fuente.
- fzf: Buscador difuso de línea de comandos de propósito general. Autor: [junegunn](https://github.com/junegunn)
## Uso general
<kbd>Windows</kbd> + <kbd>Enter</kbd> : Abrir la consola (gnome-terminal).  
<kbd>Windows</kbd> + <kbd>W</kbd> : Cerrar la ventana actual.  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>R</kbd> : Reiniciar la configuración del bspwm.  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>Q</kbd> : Cerrar sesión.  
<kbd>Windows</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Moverse por las ventanas en la workspace actual.  
<kbd>Windows</kbd> + <kbd>D</kbd> : Abrir el Rofi. <kbd>Esc</kbd> para salir.  
<kbd>Windows</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Cambiar el workspace.  
<kbd>Windows</kbd> + <kbd>T</kbd> : Cambiar la ventana actual a modo "terminal" (normal). Nos sirve cuando la ventana está en modo pantalla completa o flotante.  
<kbd>Windows</kbd> + <kbd>M</kbd> : Cambiar la ventana actual a modo "completo" (no ocupa la polybar). Presione la mismas teclas para volver a modo "terminal" (normal).  
<kbd>Windows</kbd> + <kbd>F</kbd> : Cambiar la ventana actual a modo pantalla completa (ocupa todo incluyendo la polybar).  
<kbd>Windows</kbd> + <kbd>S</kbd> : Cambiar la ventana actual a modo "flotante".  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Mover la ventana actual a otro workspace.  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Cambiar el tamaño de la ventana actual (solo funciona si está en modo terminal o flotante).  
<kbd>Windows</kbd> + <kbd>Ctrl</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Cambiar la posición de la ventana actual (solo funciona en modo flotante).  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd> : Abrir Google Chrome (es necesario instalarlo primero).  
<kbd>Windows</kbd> + <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Mostrar una preselección para luego abrir una ventana (una terminal, Google Chrome, un archivo, etc.). <kbd>Windows</kbd> + <kbd>Ctrl</kbd> + <kbd>Space</kbd> para deshacer la preselección.

> Tenga en cuenta que cuando nos referimos a la tecla <kbd>Windows</kbd>, esta puede cambiar dependiendo del pointer_modifier seleccionado, que se encuentra en el archivo ~/.config/bspwm/bspwmrc

## Configuración manual:
- Video by s4vitar: https://www.youtube.com/watch?v=66IAhBI0bCM
## Créditos
- Autor: leviswings
- Inspirado en s4vitar
- Especial gracias a Marcelo Vazquez (alias s4vitar), Antonio Sarosi y Heath Adams (alias TheCyberMentor)
