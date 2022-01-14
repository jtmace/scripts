#!/bin/bash
# Hopefully I never need this again. Recursively convert all mp4 files to mp3 (in order id3 info to play nicely with Android VLC). 
IFS=$'\n'; set -f;
for f in $(find . -name '*.mp4'); do ffmpeg -i "${f%.*}.mp4"  -vn -acodec libmp3lame -ac 2 -qscale:a 4 -ar 48000 "${f%.*}.mp3";
done;unset IFS; set +f
