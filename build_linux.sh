#!/bin/bash

# Create build directory if it doesn't exist
mkdir -p build/linux_debug

# Build the project
odin build sauce -debug -collection:bald=sauce/bald -collection:user=sauce -out:build/linux_debug/game

# Make the output executable
chmod +x build/linux_debug/game
