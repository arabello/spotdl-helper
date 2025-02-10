#!/bin/bash

# Check if all required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <playlist-url> <playlist-name> <cookie-file>"
    exit 1
fi

PLAYLIST_URL=$1
PLAYLIST_NAME=$2
COOKIE_FILE=$3

# Get Spotify authentication token if not already set
if [ -z "$SPOTIFY_AUTH_TOKEN" ]; then
    source ./get_spotify_token.sh
fi

# Run spotdl sync with provided arguments
spotdl sync "$PLAYLIST_URL" --save-file "$PLAYLIST_NAME.sync.spotdl" \
--threads 8 \
--cookie-file "$COOKIE_FILE" \
--use-cache-file \
--auth-token "$SPOTIFY_AUTH_TOKEN"
