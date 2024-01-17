# Deploy the container

Method with compose  (swarm):<br>
```bash
wget https://github.com/PR3SIDENT/enshrouded-server/blob/main/DockerRessources/enshrouded_swarm.yaml
docker compose --compose-file enshrouded_swarm.yaml EnshroudedDedi
```
<br>

Method with compose (standalone):<br>
```bash
wget https://github.com/PR3SIDENT/enshrouded-server/blob/main/DockerRessources/enshrouded_swarm.yaml
docker compose --compose-file enshrouded_swarm.yaml EnshroudedDedi
```
# Quick Description

Here you will find some files<br>
    1 - Dockerfile is raw file used to generate docker image<br>
    2 - Startup script.sh is image embended file that will be used to initialize container and launch/update service<br>
    3 - both yaml files are to be used with COMPOSE to create stack.<br>
<br>
NOTE : you can use ONE of the file. As the standalone is made for simple docker install and the swarm is used... well, for swarm ;)<br>
<br>

# Status

For now, all files are under DEV and not usable 'as is'.<br>
It will be upgraded since release.<br>

# How to use

Those are the variable you can custom with their defaults values.<br>
<br>
ENSHROUDED_SERVER_NAME="myenshroudedserver"<br>
ENSHROUDED_SERVER_PASSWORD=""<br>
ENSHROUDED_SERVER_SAVEDIRECTORY="./savegame"<br>
ENSHROUDED_SERVER_LOGDIRECTORY="./logs"<br>
ENSHROUDED_SERVER_MAXPLAYERS="16"<br>

# FAQ

Q: why a network is declared in compose if you still bind the ports ?<br>
A: Beceause if we want to make a compose file including other services like Console, Backup management or web interface to manage service,
it will be more easier (and secure) to add other container in a backend isolated network.
