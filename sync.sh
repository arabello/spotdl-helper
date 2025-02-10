#!/bin/bash

# Check if all required arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <cookie-file>"
    exit 1
fi

COOKIE_FILE=$1

# Find the first .sync.spotdl file
SYNC_FILE=$(find . -name "*.sync.spotdl" -type f | head -n 1)
if [ -z "$SYNC_FILE" ]; then
    echo "Error: No .sync.spotdl file found"
    exit 1
fi

# Get Spotify authentication token if not already set
if [ -z "$SPOTIFY_AUTH_TOKEN" ]; then
    source /Users/pelle/workspace/personal/spotdl-helper/get_spotify_token.sh
fi

# Run spotdl sync with provided arguments
spotdl sync "$SYNC_FILE" \
--threads 8 \
--cookie-file "$COOKIE_FILE" \
--use-cache-file \
--auth-token "$SPOTIFY_AUTH_TOKEN"
