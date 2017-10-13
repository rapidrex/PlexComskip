#!/bin/sh
BASEPATH=$(dirname "$1")
BASEFILE=$(basename "$1")
FILENAME="${BASEFILE%%.*}"
FILE_SIZE=$(wc -c < "$1")
FILE_SIZE=$(echo "${FILE_SIZE}" | awk '{ split( "B KB MB GB TB PB" , v ); s=1; while( $1>1000 ){ $1/=1000; s++ } printf "%.2f %s", $1, v[s] }')

echo "Starting $BASEFILE at $(date) with file size $FILE_SIZE" >> /opt/PlexComskip/"$BASEFILE".txt

#/usr/bin/mkvpropedit "$1" --edit track:a1 --set language=eng --edit track:v1 --set language=eng >> /opt/PlexComskip/"$BASEFILE".txt 2>&1

#sleep 10

/usr/bin/python /opt/PlexComskip/PlexComskip.py "$1" >> /opt/PlexComskip/"$BASEFILE".txt 2>&1

#HandBrakeCLI -Z "Very Fast 720p30" -i "$1" -o "$1".mp4 >> /opt/PlexComskip/"$BASEFILE".txt 2>&1
HandBrakeCLI --preset-import-file /opt/PlexComskip/bab79.json -Z "BAB79" -i "$1" -o "$1".mp4 >> /opt/PlexComskip/"$BASEFILE".txt 2>&1
\cp -v -f "$1".mp4 /mnt/6tbTV/downloads/temp/complete/ >> /opt/PlexComskip/"$BASEFILE".txt
sleep 10

rm -f "$1"

FILE_SIZE=$(wc -c < "$1".mp4)
FILE_SIZE=$(echo "${FILE_SIZE}" | awk '{ split( "B KB MB GB TB PB" , v ); s=1; while( $1>1000 ){ $1/=1000; s++ } printf "%.2f %s", $1, v[s] }')
echo "Ended $BASEFILE at $(date) with file size $FILE_SIZE" >> /opt/PlexComskip/"$BASEFILE".txt

