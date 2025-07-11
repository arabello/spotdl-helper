#!/bin/bash

# Check if SPOTDL_HELPER_PATH is set
if [ -z "$SPOTDL_HELPER_PATH" ]; then
    echo "Error: SPOTDL_HELPER_PATH environment variable is not set"
    echo "Please set SPOTDL_HELPER_PATH to the path of the spotdl-helper directory"
    exit 1
fi

# Check if required arguments are provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <env-file-path>"
    exit 1
fi

# Source environment variables
source $1

# Check if required environment variables are set
if [ -z "$SP_CLIENT_ID" ] || [ -z "$SP_CLIENT_SECRET" ]; then
    echo "Error: SP_CLIENT_ID and SP_CLIENT_SECRET must be set"
    exit 1
fi

response=$(curl -s -X POST "https://accounts.spotify.com/api/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=$SP_CLIENT_ID&client_secret=$SP_CLIENT_SECRET")

SPOTIFY_AUTH_TOKEN=$(echo "$response" | jq -r '.access_token')
export SPOTIFY_AUTH_TOKEN
echo "$SPOTIFY_AUTH_TOKEN"
