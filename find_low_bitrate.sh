#!/bin/bash

# Show usage information
usage() {
    echo "Usage: $0 <directory> <minimum_bitrate_kbps> [-r|--remove]"
    echo "Example: $0 /path/to/music 128 --remove"
    echo ""
    echo "Options:"
    echo "  -r, --remove    Remove files without confirmation"
    echo "  -h, --help      Show this help message"
    exit 1
}

# Check minimum number of arguments
if [ $# -lt 2 ]; then
    usage
fi

directory="$1"
min_bitrate="$2"
remove_files=false
shift 2

# Parse optional arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -r|--remove)
            remove_files=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Check if directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist"
    exit 1
fi

# Check if min_bitrate is a number
if ! [[ "$min_bitrate" =~ ^[0-9]+$ ]]; then
    echo "Error: Minimum bitrate must be a number"
    exit 1
fi

# Find all MP3 and M4A files and check their bitrate
while IFS= read -r file; do
    # Get bitrate in kb/s using ffmpeg
    bitrate=$(ffmpeg -i "$file" 2>&1 | grep -i "audio:" | grep -o "[0-9]* kb/s" | cut -d' ' -f1)
    
    if [ -n "$bitrate" ] && [ "$bitrate" -lt "$min_bitrate" ]; then
        if [ "$remove_files" = true ]; then
            echo "Removing low bitrate file ($bitrate kb/s): $file"
            rm "$file"
        else
            echo "Found low bitrate file ($bitrate kb/s): $file"
        fi
    fi
done < <(find "$directory" -type f \( -name "*.mp3" -o -name "*.m4a" \))

echo "Finished processing files." 
