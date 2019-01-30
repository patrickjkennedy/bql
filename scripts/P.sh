#!/bin/bash

if [ -z "$1" ]; then
echo "Usage $0 mutex-name"
exit 1
elif [ ! -e "$1" ]; then
echo "Target for the lock must exist"
exit 2
else
while ! ln "$0" "$1-lock" 2>/dev/null; do
sleep 1
done
exit 0
fi