#!/bin/bash

# Source environment variables
source /Users/pelle/workspace/personal/spotdl-helper/.env.local

# Check if required environment variables are set
if [ -z "$SP_CLIENT_ID" ] || [ -z "$SP_CLIENT_SECRET" ]; then
    echo "Error: SP_CLIENT_ID and SP_CLIENT_SECRET must be set"
    exit 1
fi

response=$(curl -s -X POST "https://accounts.spotify.com/api/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=$SP_CLIENT_ID&client_secret=$SP_CLIENT_SECRET")

export SPOTIFY_AUTH_TOKEN=$(echo "$response" | jq -r '.access_token')
