#!/bin/sh
set -e
bg="/tmp/$(whoami)_lock_background.png"
umask 066
scrot "$bg"
mogrify -scale 10% -scale 1000% "$bg"
i3lock -i "$bg"
rm -v "$bg"
