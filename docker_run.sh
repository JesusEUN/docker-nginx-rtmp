#!/bin/bash
docker run  -d -i -t \
            -p 80:80 \
            -p 1935:1935 \
            -v /var:/var/log/nginx \
            -v /var:/home/nginx/html \
            -e EXEC_PUSH="exec_push /bin/ffmpeg -loglevel verbose -re -i rtmp://localhost/src/srcstream -vcodec libx264 -vprofile baseline -acodec libfdk_aac -ar 44100 -ac 1 -f flv rtmp://localhost/dash/movie -vcodec libx264 -vprofile baseline -acodec libfdk_aac -ar 44100 -ac 1 -f flv rtmp://localhost/hls/movie 2>>/var/log/nginx/ffmpeg-stream.log" \
            -e HLS_PATH="/tmp/hls" \
            -e HLS_FRAGMENT="3s" \
            -e DASH_PATH="/tmp/dash" \
            -e DASH_FRAGMENT="3s" \
            -e DASH_PLAYLIST_LENGTH="9s" \
            -e HLS_ACCESS_CONTROL_ALLOW_ORIGIN="*" \
            -e DASH_ACCESS_CONTROL_ALLOW_ORIGIN="*" \
konwilms/docker-nginx-rtmp
