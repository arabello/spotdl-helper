#!/bin/bash

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "Usage: $0 <config_file> [cookie_file]"
  exit 1
fi

CONFIG_FILE=$1
COOKIE_FILE=$2
BASE_NAME=$(basename "$CONFIG_FILE" .yml)
ROOT_DIR="$BASE_NAME"

# Function to recursively process playlists
process_playlists() {
  local parent_dir=$1
  local yaml_content=$2

  for key in $(echo "$yaml_content" | yq eval 'keys | .[]' -); do
    value=$(echo "$yaml_content" | yq eval ".\"$key\"" -)
    folder="$parent_dir/$key"
    mkdir -p "$folder"

    # Check if value is a nested object
    if [ "$(echo "$value" | yq eval 'type' -)" = "!!map" ]; then
      process_playlists "$folder" "$value"
    else
      # It's a string, handle playlist based on the existence of the sync file
      pushd "$folder" > /dev/null
      sync_file="$key.sync.spotdl"
      spotdl_args=(--threads 8 --print-errors --format mp3)
      if [ -n "$COOKIE_FILE" ]; then
        echo "Using cookie file"
        spotdl_args+=(--cookie-file "$COOKIE_FILE")
      fi
      if [ ! -f "$sync_file" ]; then
        echo "Init "$folder""
        spotdl sync "$value" "${spotdl_args[@]}" --save-file "$sync_file"
      else
        echo "Sync "$folder""
        spotdl sync "$sync_file" "${spotdl_args[@]}" 
      fi
      popd > /dev/null
    fi
  done
}

# Check if yq is installed
if command -v yq &> /dev/null; then
  if [ -f "$CONFIG_FILE" ]; then
    # Read the top-level keys and start recursion
    root_dir="$ROOT_DIR"
    yaml_content=$(yq eval "." "$CONFIG_FILE")

    mkdir -p "$root_dir"
    process_playlists "$root_dir" "$yaml_content"
  else
    echo "Configuration file not found: $CONFIG_FILE"
    exit 1
  fi
else
  echo "Please install yq to parse the configuration file."
  exit 1
fi
