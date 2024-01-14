# Quick Description

Here you will find some files\n
    1 - Dockerfile is raw file used to generate docker image
    2 - Startup script.sh is image embended file that will be used to initialize container and launch/update service
    3 - both yaml files are to be used with COMPOSE to create stack.

NOTE : you can use ONE of the file. As the standalone is made for simple docker install and the swarm is used... well, fo swarm ;)

# Status

WARNING : Due to lack of informations for now, this is still under construction.

# How to use

Image will probably be available here and also in dockerhub.
So you can pull it and use one of the yaml file with compose to initialise stack

# FAQ

Q: why a network is declared in compose if you still bind the ports ?
A: Beceause if we want to make a compose file including other services like Console, Backup management or web interface to manage service,
it will be more easier (and secure) to add other container in a backend isolated network.
