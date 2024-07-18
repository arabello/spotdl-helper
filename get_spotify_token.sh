#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <client_id> <client_secret>"
  exit 1
fi

client_id=$1
client_secret=$2

response=$(curl -s -X POST "https://accounts.spotify.com/api/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=$client_id&client_secret=$client_secret")

token=$(echo "$response" | jq -r '.access_token')

echo "$token"
