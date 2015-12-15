#!/bin/sh
set -e
me="$(whoami)"
ss=/tmp/"$me"_screens.png
bg=/tmp/"$me"_lock_background.png
# Don't let other users access a screenshot of your system
umask 066
scrot "$ss"
# Use ffmpeg instead of convert/mogrify because it uses these crazy things
# called threads (and gives you finer control over the scaling).
ffmpeg -y -v error -i "$ss" -vf "scale=0.1*in_w:-1:flags=area,scale=10*in_w:-1:flags=neighbor" "$bg"
i3lock -i "$bg"
rm "$ss" "$bg"
