#!/bin/bash

# Set FMOD library path
export LD_LIBRARY_PATH=/opt/fmodengine/api/core/lib/x86_64:/opt/fmodengine/api/studio/lib/x86_64:$LD_LIBRARY_PATH

# Run the game
./build/linux_debug/game
