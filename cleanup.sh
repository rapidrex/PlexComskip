#!/bin/sh

echo "Starting cleanup of Y&R at $(date)" >> /opt/PlexComskip/cleanup.txt
find "/mnt/6tbTV/downloads/tv/The Young and the Restless (1973)" -type f -mtime +14 -name '*.mp4' >> /opt/PlexComskip/cleanup.txt
find "/mnt/6tbTV/downloads/tv/The Young and the Restless (1973)" -type f -mtime +14 -name '*.mp4' -delete
echo "Ending cleanup of Y&R at $(date)" >> /opt/PlexComskip/cleanup.txt


echo "Starting cleanup of B&B at $(date)" >> /opt/PlexComskip/cleanup.txt
find "/mnt/6tbTV/downloads/tv/The Bold and the Beautiful (1987)" -type f -mtime +14 -name '*.mp4' >> /opt/PlexComskip/cleanup.txt
find "/mnt/6tbTV/downloads/tv/The Bold and the Beautiful (1987)" -type f -mtime +14 -name '*.mp4' -delete
echo "Ending cleanup of B&B at $(date)" >> /opt/PlexComskip/cleanup.txt
