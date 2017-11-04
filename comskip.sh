#!/bin/bash
BASEPATH=$(dirname "$1")
BASEFILE=$(basename "$1")
FILENAME="${BASEFILE%%.*}"
FILE_SIZE=$(wc -c < "$1")
FILE_SIZE=$(echo "${FILE_SIZE}" | awk '{ split( "B KB MB GB TB PB" , v ); s=1; while( $1>1000 ){ $1/=1000; s++ } printf "%.2f %s", $1, v[s] }')
counter=0

echo "Starting $BASEFILE at $(date) with file size $FILE_SIZE" > /opt/PlexComskip/"$BASEFILE".txt

while 
	pgrep HandBrakeCLI > /dev/null && isHBrunning="Running"
	pgrep HandBrakeCLI > /dev/null || isHBrunning="Not Running"
	echo "HandBrake is $isHBrunning ... $(date +%r) | counter = $counter" >> /opt/PlexComskip/"$BASEFILE".txt
	if [[ "$counter" -ne 0 ]]
	then
		sleep 2m
	fi
	counter=$((counter+1))
	[[ "$isHBrunning" == "Running" ]]
do
    :
done

/usr/bin/python /opt/PlexComskip/PlexComskip.py "$1" >> /opt/PlexComskip/"$BASEFILE".txt 2>&1

echo "HandBrake encode starting at $(date) " >> /opt/PlexComskip/"$BASEFILE".txt
echo "-------------------------------------" >> /opt/PlexComskip/"$BASEFILE".txt
echo "-------------------------------------" >> /opt/PlexComskip/"$BASEFILE".txt
echo "-------------------------------------" >> /opt/PlexComskip/"$BASEFILE".txt


if [[ "$BASEFILE" == *"The Bold and the Beautiful"* ]]
then
	HandBrakeCLI --preset-import-file "/opt/PlexComskip/480p30 RF20.json" -Z "480p30 RF20" -i "$1" -o "$1".mp4 >> /opt/PlexComskip/"$BASEFILE".txt 2>&1
elif [[ "$BASEFILE" == *"The Young and the Restless"* ]]
then
	HandBrakeCLI --preset-import-file "/opt/PlexComskip/480p30 RF20.json" -Z "480p30 RF20" -i "$1" -o "$1".mp4 >> /opt/PlexComskip/"$BASEFILE".txt 2>&1
elif [[ "$BASEFILE" == *"Dateline NBC"* ]]
then
	HandBrakeCLI --preset-import-file "/opt/PlexComskip/480p30 RF20.json" -Z "480p30 RF20" -i "$1" -o "$1".mp4 >> /opt/PlexComskip/"$BASEFILE".txt 2>&1
else
	HandBrakeCLI --preset-import-file "/opt/PlexComskip/720p30 5.1 RF21.json" -Z "720p30 5.1 RF21" -i "$1" -o "$1".mp4 >> /opt/PlexComskip/"$BASEFILE".txt 2>&1
fi

echo "HandBrake encode finished at $(date) " >> /opt/PlexComskip/"$BASEFILE".txt
echo "-------------------------------------" >> /opt/PlexComskip/"$BASEFILE".txt
echo "-------------------------------------" >> /opt/PlexComskip/"$BASEFILE".txt
echo "-------------------------------------" >> /opt/PlexComskip/"$BASEFILE".txt

\cp -v -f "$1".mp4 /mnt/6tbTV/downloads/temp/temp/ >> /opt/PlexComskip/"$BASEFILE".txt
sleep 10

rm -f "$1"

chmod 777 "$1".mp4 

FILE_SIZE=$(wc -c < "$1".mp4)
FILE_SIZE=$(echo "${FILE_SIZE}" | awk '{ split( "B KB MB GB TB PB" , v ); s=1; while( $1>1000 ){ $1/=1000; s++ } printf "%.2f %s", $1, v[s] }')
echo "Ended $BASEFILE at $(date) with file size $FILE_SIZE" >> /opt/PlexComskip/"$BASEFILE".txt
