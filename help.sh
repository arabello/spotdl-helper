echo "AUTH_TOKEN=\$(./get_spotify_token.sh \$SP_CLIENT_ID \$SP_CLIENT_SECRET)"

echo "spotdl sync <playlist-url> --save-file <playlist-name>.sync.spotdl \\
--threads 8 \\
--cookie-file <cookie-file> \\
--use-cache-file \\
--auth-token \$AUTH_TOKEN"

echo 
echo "for syncing remove <playlist-url> and --save-file"
