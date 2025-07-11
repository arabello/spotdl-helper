# spotdl-helper

## Pre-requisite

Before running any script, export the path to this local repository in you current shell:
```bash
export SPOTDL_HELPER_PATH=/absolute/path/to/spotdl-helper
```

Create or locate an existing `.env.local` file with the Spotify Web API credentials:
```bash
SP_CLIENT_ID=your_client_id
SP_CLIENT_SECRET=your_client_secret
```

Get a Spotify authentication token by running the following command. 
```bash
source $SPOTDL_HELPER_PATH/get_token.sh $SPOTDL_HELPER_PATH/.env.local
```
This will set the `SPOTIFY_AUTH_TOKEN` environment variable in your current shell.

## New playlist

To create a new playlist:
```bash
mkdir <playlist-name>
cd <playlist-name>
$SPOTDL_HELPER_PATH/sync.sh <playlist-url> <playlist-name>
```

Note that the playlist URL should not contain any special characters. When you copy the URL from Spotify, you should remove the `?si=` part.
```
wrong ❌ https://open.spotify.com/playlist/0NZR1Mk8V0YMdtrwzrFS0S?si=1dee86286c4047e7 

correct ✅ https://open.spotify.com/playlist/0NZR1Mk8V0YMdtrwzrFS0S
```

## Sync playlist
This command aligns the local files with the Spotify playlist: remove files that are not in the playlist and download files that are in the playlist.

To sync a playlist:
```bash
cd <playlist-name>
$SPOTDL_HELPER_PATH/sync.sh
```
