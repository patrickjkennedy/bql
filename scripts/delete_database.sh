#!/bin/bash

database=$1

if [ $# -eq 0 ]; then
    echo "Error: no database provided."

elif [ $# -gt 1 ]; then
    echo "Error: only one parameter accepted"
    exit 1

# Critical section start
./P.sh $0
elif ! [ -d $database ]; then
    echo "Error: DB does not exist"
    # Critical section stop
    ./V.sh $0
    exit 1

else
    rm -rf $database
    echo "OK: database deleted"
    # Critical section stop
    ./V.sh $0
    exit 0
fi
