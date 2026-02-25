#!/bin/bash

set -e

## If env has a URL to a save to restore, do it if no existing configs are present.
if [ ! -z "${RESTORE_URL}" ] && [ ! -e Torch.cfg ] && [ ! -e Instance/SpaceEngineers-Dedicated.cfg ]; then
  echo ''
  echo 'Restoring existing configuration...'
  echo ''
  curl -sSL -o /tmp/restore.zip ${RESTORE_URL}
  unzip -o /tmp/restore.zip -d /game/
  rm /tmp/restore.zip
fi

## Workaround mod issues
cp DedicatedServer64/steamclient64.dll .
cp DedicatedServer64/tier0_s64.dll .
cp DedicatedServer64/vstdlib_s64.dll .

## Download Torch and unpack
if [ ! -e Torch.Server.exe ]; then
  echo ''
  echo 'Installing Space Engineers Torch...'
  echo ''
  curl -sSL -o /tmp/torch-server.zip https://build.torchapi.com/job/Torch/job/master/lastSuccessfulBuild/artifact/bin/torch-server.zip
  unzip -o /tmp/torch-server.zip -d /game/
  rm /tmp/torch-server.zip
fi

## Copy initial configuration files
if [ ! -e Torch.cfg ]; then
  echo 'Copying default Torch.cfg...'
  cp /opt/default/Torch.cfg Torch.cfg
fi
mkdir -p Instance
if [ ! -e Instance/SpaceEngineers-Dedicated.cfg ]; then
  echo 'Copying default SpaceEngineers-Dedicated.cfg...'
  cp /opt/default/Dedicated.cfg Instance/SpaceEngineers-Dedicated.cfg
fi
