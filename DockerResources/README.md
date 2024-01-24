# 1. Quick Description

Here you will find some files<br>
    1 - Dockerfile is raw file used to generate docker image<br>
    2 - Startup script.sh is image embended file that will be used to initialize container and launch/update service<br>
    3 - both yaml files are to be used with COMPOSE to create stack.<br>
<br>
NOTE : you can use ONE of the file. As the standalone is made for simple docker install and the swarm is used... well, for swarm ;)<br>
<br>

Also you need to redirect the following ports :<br>

| Game port |  Query port  |
|-----------|--------------|
|   15636   |     15637    |
 
# 2. How to Deploy

Method with docker run : <br>
```bash
docker run -d --name enshroudeddedi --restart=always -p 15636:15636 -p 15637:15667 \
-v enshrouded_data:/home/steam/enshrouded/savegame -v enshrouded_logs:/home/steam/enshrouded/logs \
-e ENSHROUDED_SERVER_NAME=myenshroudedserver \
-e ENSHROUDED_SERVER_PASSWORD=<insertpasswordhere> \
-e ENSHROUDED_SERVER_MAXPLAYERS=16
```
<br>

Method with compose  (swarm):<br>
```bash
wget https://github.com/PR3SIDENT/enshrouded-server/blob/main/DockerRessources/enshrouded_swarm.yaml
docker compose --compose-file enshrouded_swarm.yaml EnshroudedDedi
```
<br>

TODO Method with compose (standalone):<br>
```bash
wget https://github.com/PR3SIDENT/enshrouded-server/blob/main/DockerRessources/enshrouded_standalone.yaml
docker compose --compose-file enshrouded_swarm.yaml EnshroudedDedi
```
<br>

# FAQ

Q: why a network is declared in compose if you still bind the ports ?<br>
A: Beceause if we want to make a compose file including other services like Console, Backup management or web interface to manage service,
it will be more easier (and secure) to add other container in a backend isolated network.
