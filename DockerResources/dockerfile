#Starting FROM
FROM ubuntu:22.04

#Define General vars
ENV DEBIAN_FRONTEND "noninteractive"

#Define Wine ENV
ENV WINEPREFIX "/home/steam/.enshrouded_prefix"
ENV WINEARCH "win64"
ENV WINEDEBUG "-all"

#Define specifics env variables
ENV ENSHROUDED_SERVER_NAME "myenshroudedserver"
ENV ENSHROUDED_SERVER_PASSWORD ""
ENV ENSHROUDED_SERVER_MAXPLAYERS "16"

#Install base packages
RUN set -x \
&& apt update \
&& apt install -y \
    vim \
    wget \
    software-properties-common

#Install steamCMD with prerequisites
RUN add-apt-repository -y multiverse \
&& dpkg --add-architecture i386 \
&& apt update \
&& echo steam steam/question select "I AGREE" | debconf-set-selections && echo steam steam/license note '' | debconf-set-selections \
&& apt install -y \
    lib32z1 \
    lib32gcc-s1 \
    lib32stdc++6 \
    steamcmd \
&& groupadd steam \
&& useradd -m steam -g steam \
&& passwd -d steam \
&& chown -R steam:steam /usr/games \
&& ln -s /usr/games/steamcmd /home/steam/steamcmd

#Install wine, winetricks and prerequisites
RUN dpkg --add-architecture amd64 \
&& mkdir -pm755 /etc/apt/keyrings \
&& wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
&& wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources \
&& apt update \
&& apt install -y --install-recommends \
    winehq-staging \
&& apt install -y --allow-unauthenticated \
    cabextract \
    winbind \
    screen \
    xvfb \
&& wget -O /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
&& chmod +x /usr/local/bin/winetricks

#Create the winetrick script
RUN echo '#!/bin/bash\n\
export DISPLAY=:1.0\n\
Xvfb :1 -screen 0 1024x768x16 &\n\
env WINEDLLOVERRIDES="mscoree=d" wineboot --init /nogui\n\
winetricks corefonts\n\
winetricks sound=disabled\n\
winetricks -q --force vcrun2022\n\
wine winecfg -v win10\n\
rm -rf /home/steam/.cache\n\
' > /home/steam/winetricks.sh

#Prepare for user environment & server build
RUN chmod +x /home/steam/winetricks.sh \
&& mkdir /home/steam/.enshrouded_prefix \
&& mkdir /home/steam/enshrouded \
&& mkdir /home/steam/enshrouded/savegame \
&& mkdir /home/steam/enshrouded/logs \
&& chown -R steam:steam /home/steam

#Add the startupscript and set execution mode
ADD ./entrypoint.sh /home/steam/entrypoint.sh
RUN chmod +x /home/steam/entrypoint.sh

#build environment
USER steam
RUN /home/steam/steamcmd +quit \
&& /home/steam/winetricks.sh

WORKDIR /home/steam

#Map volume
VOLUME /home/steam/enshrouded

#Expose ports
EXPOSE 15636 15637

#Use entrypoint or CMD
ENTRYPOINT [ "/home/steam/entrypoint.sh" ]
