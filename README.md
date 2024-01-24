# Enshrouded Community Hosting Resources
This repository serves as a guide for anyone looking to host their own Enshrouded server. It may link to other projects, repos, guides, etc.

If you'd like to rent a server from a provider, [we are also maintaining a list of those here.](https://github.com/PR3SIDENT/enshrouded-server/blob/main/Hosting%20Providers/hosting-providers.md)

# Official Server Guide (By Keen Games)
This contains server specs, FAQ, installation instructions, and beyond...

https://enshrouded.zendesk.com/hc/en-us/sections/16050842957085-Multiplayer-and-Server-Hosting

# SteamCMD
The SteamCMD tool is a complex tool that is provided by Steam for the purpose of installing game servers through more scripted methods.  There are both windows and linux versions of the SteamCMD tool, and it is beyond the scope of this FAQ to provide assistance on all of the features of this command.

That said, when executed, it will download all of the game files to the folder specified:

In general, the command works like this:

`steamcmd +force_install_dir <PATH TO INSTALL FOLDER> +login anonymous +app_update 2278520 validate +quit`

This will install the game server. From there, you might need to install VC2022 Redistributable (depending on your environment).

Last but not least Configure the Server Configuration File following the guide.

To start the server, simply run `enshrouded_server.exe`  or if running on Linux `wine64 ./enshrouded_server.exe` There are no command line arguments.

Dedicated Server Running Verification
The Server is running when you see ```HostOnline (Up!)``` message. 

# Docker
> Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers. The service has both free and premium tiers. The software that hosts the containers is called Docker Engine
- [DrSh4d0w's Container](https://github.com/PR3SIDENT/enshrouded-server/blob/main/DockerResources)
- [Sknnr's Container](https://github.com/jsknnr/enshrouded-server)

# Pterodactyl
> Pterodactyl® is a free, open-source game server management panel built with PHP, React, and Go. Designed with security in mind, Pterodactyl runs all game servers in isolated Docker containers while exposing a beautiful and intuitive UI to end users.
- [Official Egg](https://github.com/parkervcp/eggs/tree/master/game_eggs/steamcmd_servers/enshrouded)

# WindowsGSM
> WindowsGSM is a powerful tool to manage game servers. Equipped with a GUI for server admins to install, import, start, stop, restart, update, and automate multiple servers with a push of a button.
- [WindowsGSM.Enshrouded](https://github.com/ohmcodes/WindowsGSM.Enshrouded)

# AMP
> AMP (Application Management Panel) is a simple to use, self-hosted web control panel for game servers that runs on both Windows and Linux systems with a focus on ease of use through its intuitive user interface and simple setup process.
- [Greelan's Plugin](https://github.com/CubeCoders/AMPTemplates/pull/606)
  
# Windows Applications
- [Spaik's Server Manager](https://github.com/ISpaikI/Enshrouded-Server-Manager)
- TBD (In-Development)

# Linux - InstallServer.sh
> The script present here is an automated script to install the server,components and create a service so it can be managed more easier.
Make it executable with ```chmod +x InstallServer.sh``` and run it.<br>
<br>
Script tested on Ubuntu 22.04 (not sure that will work on older versions and alternatives distros)
