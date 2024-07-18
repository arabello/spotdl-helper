echo "spotdl sync <playlist-url> --save-file <playlist-name>.sync.spotdl \\
--threads 16 \\
--cookie-file <cookie-file> \\
--use-cache-file \\
--auth-token \$(./get_spotify_token.sh <client_id> <client_secret>)"

echo 
echo "for syncing remove <playlist-url> and --save-file"
