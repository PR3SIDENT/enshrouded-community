#!/bin/bash

#If it is the first init of the container, DO
if [ ! -e /home/steam/enshrouded/enshrouded_server.json ]; then

echo " ----- Begining Init process -----"

#Create wine context file.
echo "Creating whine context file."

touch /home/steam/winetricks.sh
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

echo "Wine whine context file created."

#Apply wine environment.
su steam -c '/home/steam/winetricks.sh'

#Create server properties file from the template or given model.
echo "Creating server properties file."

touch /home/steam/enshrouded/enshrouded_server.json
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

echo "Enshrouded_server.json created."

#Adjust Server properties (via sed, cat or other, : guess we will see ;D)

#Do other init stuff

echo " ----- Init process finished -----"

else

echo " ----- Init process already performed -----"

fi

#Upgrade server
su steam -c "./steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /home/steam/enshrouded +login anonymous +app_update 2278520 +quit"
echo "server updated."

# Wine talks too much and it's annoying
export WINEDEBUG=-all

#Launch server with wine
su steam -c "xvfb-run --auto-servernum wine64 /home/steam/enshrouded/enshrouded_server.exe"
echo "Server Launched. Enjoy ;)"