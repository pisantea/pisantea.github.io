#!/bin/bash

DOWNLOAD_URL=$(curl -s https://mc-bds-helper.vercel.app/api/latest)
DOWNLOAD_FILE=$(echo ${DOWNLOAD_URL} | cut -d"/" -f5) # Retrieve archive name

# Minecraft CDN Akamai blocks script user-agents
RANDVERSION=$(echo $((1 + $RANDOM % 4000)))

if [ -e $DOWNLOAD_FILE ]
then
    echo "Version is latest."
    ./bedrock_server
else
    echo "Version is not latest."
    curl -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RANDVERSION.212 Safari/537.36" -H "Accept-Language: en" -o $DOWNLOAD_FILE $DOWNLOAD_URL

    unzip -o $DOWNLOAD_FILE
    rm $DOWNLOAD_FILE
    find . -type f -name '*bedrock-server-*' -delete
    echo "" > $DOWNLOAD_FILE
    ./bedrock_server
fi
