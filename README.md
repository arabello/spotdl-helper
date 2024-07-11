Here's the `README.md` with everything wrapped in markdown code blocks for easy copying:

# Playlist Downloader Script

This script automates the creation of a folder structure and the downloading of Spotify playlists based on a YAML configuration file. The playlists are managed using `spotdl`.

## Prerequisites

- [spotdl](https://github.com/spotDL/spotify-downloader) - A command-line tool for downloading Spotify songs.
- `yq` - A command-line YAML processor.

To install `yq`, use the following command:

```sh
sudo apt-get install yq
```

## Configuration File

The configuration file is a YAML file that defines the folder structure and playlists. The file should have an arbitrary number of nested folders, with Spotify playlist links as leaves.

### Example Configuration File (`user.yml`)

```yaml
Music Library:
  Pop:
    Pop Hits: "https://open.spotify.com/playlist/playlist_id_1"
    Pop Classics: "https://open.spotify.com/playlist/playlist_id_2"
  Rock:
    Rock Hits: "https://open.spotify.com/playlist/playlist_id_3"
    Classic Rock:
      70s Rock: "https://open.spotify.com/playlist/playlist_id_4"
      80s Rock: "https://open.spotify.com/playlist/playlist_id_5"
  Jazz: "https://open.spotify.com/playlist/playlist_id_6"
```

## Script Usage

### Login with Spotify

Before executing the script, you need to login with Spotify using the following command:

```sh
spotdl --user-auth
```

This will prompt you to authorize the script to access your Spotify account.

### Download Script (`download_tracks.sh`)

This script reads the YAML configuration file, creates the necessary folder structure, and downloads the specified playlists. The script will use a top-level folder named after the configuration file (without the `.yml` extension).

### How to Run the Script

1. **Make the script executable**:

```sh
chmod +x download_tracks.sh
```

2. **Run the script with a specific configuration file**:

```sh
./download_tracks.sh user.yml
```

### Script Behavior

- The script will create a top-level folder named after the configuration file (without the `.yml` extension).
- It will recursively create folders as specified in the configuration file.
- For each playlist link, it will check if a sync file (`{folder}.sync.spotdl`) exists in the corresponding folder.
  - If the sync file does not exist, it will initialize the sync by running `spotdl sync <playlist_link> --save-file <folder>.sync.spotdl`.
  - If the sync file exists, it will synchronize the playlist by running `spotdl sync <folder>.sync.spotdl`.

## Example

Given the configuration file `user.yml`, the script will create the following folder structure:

```
user
├── Music Library
│   ├── Pop
│   │   ├── Pop Hits
│   │   └── Pop Classics
│   ├── Rock
│   │   ├── Rock Hits
│   │   └── Classic Rock
│   │       ├── 70s Rock
│   │       └── 80s Rock
│   └── Jazz
```

Each folder containing a playlist link will have a corresponding `.sync.spotdl` file to manage the playlist synchronization.

## Notes

- Ensure that `spotdl` is installed and configured correctly on your system.
- The script assumes that the configuration file is in the current directory. If it is located elsewhere, provide the relative or absolute path to the configuration file when running the script.
- The script checks for the existence of `yq` and `spotdl` before proceeding. Make sure both are installed and available in your PATH.
