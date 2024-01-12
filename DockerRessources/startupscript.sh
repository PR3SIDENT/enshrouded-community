#!/bin/bash

#If it is the first init of the container, DO
if [ ! -e /Enshrouded/<configfilehere> ]; then

echo " ----- Begining Init process -----"

#Create server properties file from the template or given model

#Adjust Server properties (via sed, cat or other, : guess we will see ;D)

#Do other init stuff

echo " ----- Init process finished -----"

else

echo " ----- Init process already performed -----"

fi

#Start the server (still need to determine if i'll make it a service or launch cmd directly)
