#!/bin/bash

#If it is the first init of the container, DO
if [ ! -e /home/steam/enshrouded/enshrouded_server.json ]; then

echo " ----- Begining Init process -----"

#Create server properties file from the template or given model
echo "Creating server properties file."
touch /home/steam/enshrouded/enshrouded_server.json
cat << EOF >> /home/steam/enshrouded/enshrouded_server.json
{

                "name": "$(echo $ENSHROUDED_SERVER_NAME)",

                "password": "$(echo $ENSHROUDED_SERVER_PASSWORD)",

                "saveDirectory": "$(echo $ENSHROUDED_SERVER_SAVEDIRECTORY)",

                "logDirectory": "$(echo $ENSHROUDED_SERVER_LOGDIRECTORY)",

                "ip": "0.0.0.0",

                "gamePort": 15636,

                "queryPort": 15637,

                "slotCount": $(echo $ENSHROUDED_SERVER_MAXPLAYERS)

}
EOF
echo "enshrouded_server.json created."

#Adjust Server properties (via sed, cat or other, : guess we will see ;D)

#Do other init stuff

echo " ----- Init process finished -----"

else

echo " ----- Init process already performed -----"

fi

#Upgrade server
su steam -c "./steamcmd +@sSteamCmdForcePlatformType $STEAMCMD_INSTALL_PLATFORM +force_install_dir /home/steam/enshrouded +login $STEAMCMD_PUBLIC_ID +app_update $STEAM_APP_ID +quit"
echo "server updated"

#Launch server with wine
su steam -c "xvfb-run --auto-servernum wine64 /home/steam/enshrouded/enshrouded_server.exe"
echo "Server Launched. Enjoy ;)"