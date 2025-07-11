#!/bin/bash

# Check if SPOTDL_HELPER_PATH is set
if [ -z "$SPOTIFY_AUTH_TOKEN" ]; then
    echo "Error: SPOTIFY_AUTH_TOKEN environment variable is not set"
    echo "Please run the get_token.sh script to set the SPOTIFY_AUTH_TOKEN environment variable"
    exit 1
fi

# Find the first .sync.spotdl file
SYNC_FILE=$(find . -name "*.sync.spotdl" -type f | head -n 1)
if [ -z "$SYNC_FILE" ]; then
    # Check if required arguments are provided
    if [ "$#" -lt 2 ]; then
        echo "Usage: $0 <playlist-url> <playlist-name>"
        exit 1
    fi

    PLAYLIST_URL=$1
    PLAYLIST_NAME=$2

    # Build the spotdl command
    CMD="spotdl sync \"$PLAYLIST_URL\" --save-file \"$PLAYLIST_NAME.sync.spotdl\" --threads 8 --use-cache-file --auth-token \"$SPOTIFY_AUTH_TOKEN\""

    # Execute the command
    eval "$CMD"
else
    # Build the spotdl command
    CMD="spotdl sync \"$SYNC_FILE\" --threads 8 --use-cache-file --auth-token \"$SPOTIFY_AUTH_TOKEN\""

    # Execute the command
    eval "$CMD"
fi

