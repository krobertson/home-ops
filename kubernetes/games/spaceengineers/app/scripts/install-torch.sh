#!/bin/bash

set -e

## Download Torch and unpack
if [ ! -e Torch.Server.exe ]; then
  (
    echo ''
    echo 'Installing Space Engineers Torch...'
    echo ''
    cd /tmp
    curl -sSL -o torch-server.zip https://build.torchapi.com/job/Torch/job/master/lastSuccessfulBuild/artifact/bin/torch-server.zip
    unzip -o torch-server.zip -d /game/
    rm torch-server.zip
  )
fi
