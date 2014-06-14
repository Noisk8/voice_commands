#!/bin/bash

# Written by Rodrigo Esteves baitsart@gmail.com www.youtube.com/user/baitsart 
# GNU License. You are free to modify and redistribute   # 

if 
echo $USER | grep -x "root"
then
zenity --warning --text="Para instalar no debes ser root\nteclea exit y luego correr el instalador"
exit 0
fi
if [ -d ~/.voice_commands ]
then
zenity --warning --text="Para instalar debes antes borrar\n $HOME/.voice_commands\nO ejecuta éste comando:\nsh ~/.voice_commands/uninstall.sh\ny luego correr el instalador"
exit 0
fi
PKG_PATH=$(dirname "$(readlink -f "$0")")
cp -R "${PKG_PATH}"/voice_commands ~/.voice_commands
idioma=$(echo $LANG | cut -d'.' -f1)
sed -i 's|es_UY|'$idioma'|g' ~/.voice_commands/voice-commands.desktop
sed -i 's|/home/pc|'$HOME'|' ~/.voice_commands/voice-commands.desktop
mv ~/.voice_commands/voice-commands.desktop  ~/.local/share/applications/voice-commands.desktop
if [ -d ~/.gnome2/nautilus-scripts ]
then
echo "#!/bin/bash
sh  ~/.voice_commands/play_stop.sh
exit 0;" > ~/.gnome2/nautilus-scripts/"Comandos de Voz"
chmod +x ~/.gnome2/nautilus-scripts/"Comandos de Voz"
fi
if [ -d ~/.local/share/nautilus/scripts ]
then
echo "#!/bin/bash
sh  ~/.voice_commands/play_stop.sh
exit 0;" > ~/.local/share/nautilus/scripts/"Comandos de Voz"
chmod +x ~/.local/share/nautilus/scripts/"Comandos de Voz"
fi
cp "${PKG_PATH}"/LÉEME.md ~/.voice_commands/
echo "Instalación completa"



