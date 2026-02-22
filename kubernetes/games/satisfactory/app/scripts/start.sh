#!/bin/bash

set -e

# By default, the save games are deep in ~/.local.
mkdir -p .config/Epic/FactoryGame/Saved
mkdir -p FactoryGame/Saved/SaveGames
ln -sf .config/Epic/FactoryGame/Saved/SaveGames /game/FactoryGame/Saved/SaveGames

exec ./FactoryServer.sh
