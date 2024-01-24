#!/bin/bash

############################
# intitial install section #
############################

#Switch to non-interactive mode (system will not ask for any confirmations)
export DEBIAN_FRONTEND "noninteractive"

#enable 'debug mode'. this will print every command as output, so you can follow the process ;)
set +x

#Update package list from repo
apt update

#Install basics packages without confirmation
#   vim is a text editor, wget is to download stuff, software-properties-common will be necessary to add and validate more repo.
apt install -y vim wget software-properties-common

############################
# steamcmd install section #
############################

#Add the multiverse repo (where steam cmd package is located)
add-apt-repository -y multiverse

#Change Architecture instructions to 32bits
dpkg --add-architecture i386

#again update repo packages list to have thoses presents on Multiverse repo
apt update

#Automatic answer to the questions during steam install
echo steam steam/question select "I AGREE" | debconf-set-selections && echo steam steam/license note '' | debconf-set-selections

#Install without prompting the libraries for steamcmd & steamcmd itself
apt install -y lib32z1 lib32gcc-s1 lib32stdc++6 steamcmd

#Create group steam
groupadd steam

#Create steam user, create his home dir & add it to steam group
useradd -m steam -g steam && passwd -d steam

#Change owner of steamcmd sh folder to the user/group
chown -R steam:steam /usr/games

#Create symlink to steamcmd in steam home directory
ln -s /usr/games/steamcmd /home/steam/steamcmd

#Execute steam update
su steam -c "/home/steam/steamcmd +quit"

########################
# wine install section #
########################

#Change architecture instructions to 64bits
dpkg --add-architecture amd64

#Create the local folder who will contain the repos keys
mkdir -pm755 /etc/apt/keyrings

#Add the repo key
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

#Add the repo
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

#Again update packages list
apt update

#Install wine
apt install -y --install-recommends winehq-staging

#Install the needed packages to make wine work
apt install -y --allow-unauthenticated cabextract winbind screen xvfb

#Get winetricks
wget -O /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks

#Make .sh executable
chmod +x /usr/local/bin/winetricks

#Create the init script of whinetricks
touch /home/steam/winetricks.sh

#Write the content of the file
cat << EOF >> /home/steam/winetricks.sh
#!/bin/bash
export DISPLAY=:1.0
Xvfb :1 -screen 0 1024x768x16 &
env WINEDLLOVERRIDES="mscoree=d" wineboot --init /nogui
winetricks corefonts
winetricks sound=disabled
winetricks -q --force vcrun2022
wine winecfg -v win10
rm -rf /home/steam/.cache
EOF

#Make it executable
chmod +x /home/steam/winetricks.sh

#Create Wineprefix directory
mkdir /home/steam/.enshrouded_prefix

########################
# Game Server  section #
########################

#Create enshrouded directories
mkdir -p /home/steam/enshrouded
mkdir -p /home/steam/enshrouded/savegame
mkdir -p /home/steam/enshrouded/logs

#Ask for values of the server name, password, number of players
read -p "What is the name of Enshrouded server ?" ENSHROUDED_SERVER_NAME
read -p "What is the password of Enshrouded server ?" ENSHROUDED_SERVER_PASSWORD
read -p "What is the player limit of Enshrouded server (max is 16) ?" ENSHROUDED_SERVER_MAXPLAYERS

#Create config file
touch /home/steam/enshrouded/enshrouded_server.json

#Write the configuration
cat << EOF >> /home/steam/enshrouded/enshrouded_server.json
{

    "name": "$(echo $ENSHROUDED_SERVER_NAME)",

    "password": "$(echo $ENSHROUDED_SERVER_PASSWORD)",

    "saveDirectory": "./savegame",

    "logDirectory": "./logs",

    "ip": "0.0.0.0",

    "gamePort": 15636,

    "queryPort": 15637,

    "slotCount": $(echo $ENSHROUDED_SERVER_MAXPLAYERS)

}
EOF


#Create service script
touch /home/steam/enshrouded/StartEnshroudedServer.sh

#write the startupscript
cat << EOF >> /home/steam/enshrouded/StartEnshroudedServer.sh
#!/bin/sh
export WINEARCH=win64
export WINEPREFIX=/home/steam/.enshrouded_prefix
export WINEDEBUG=-all
xvfb-run --auto-servernum wine64 /home/steam/enshrouded/enshrouded_server.exe
EOF

#Make it exectutable
chmod +x /home/steam/enshrouded/StartEnshroudedServer.sh

#Update owner of the steam home folder
chown -R steam:steam /home/steam/

#install server
sudo su steam -c "/home/steam/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /home/steam/enshrouded +login anonymous +app_update 2278520 +quit"

##########################
# Create service section #
##########################

#déclaration du service
touch /etc/systemd/system/enshrouded.service

cat << EOF >> /etc/systemd/system/enshrouded.service

[Unit]
Description=Enshrouded server - By Chevalier Pinard
After=syslog.target network.target
[Service]
ExecStart=/home/steam/enshrouded/StartEnshroudedServer.sh
User=steam
Type=simple
Restart=on-failure
RestartSec=50s
[Install]
WantedBy=multi-user.target
EOF

#actualisation des services
systemctl daemon-reload

#integration du service au démarrage et lancement du serveur
systemctl enable enshrouded.service
