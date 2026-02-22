#!/bin/bash

set -e

if [ ! -e eula.txt ] ; then
  if [ "${EULA}" != "true" ]; then
    echo ""
    echo "You must accept the Minecraft EULA in order to proceed."
    echo ""
    echo "You can find the EULA at:"
    echo "  https://account.mojang.com/documents/minecraft_eula"
    echo ""
    echo "After, set the environment variable EULA=true to continue."
    echo ""
    exit 1
  fi

  printf "# Generated via Docker\n#$(date)\neula=${EULA}\n" > eula.txt
fi

exec java -Xms128M -XX:MaxRAMPercentage=95.0 -jar server.jar
