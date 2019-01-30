#!/bin/bash

database=$1

if [ $# -eq 0 ]; then
    echo "Error: no parameter"
    exit 1
fi

if [ $# -gt 1 ]; then
    echo "Error: only one parameter accepted"
    exit 1
fi

# Check if a database with the same name already exists

# Critical section start
./P.sh $0
if [ -d $database ]; then
    echo "Error: DB already exists"
    # Critical section ends
    ./V.sh $0
    exit 1
fi

mkdir $database
echo "OK: database created"
# Critical section ends
./V.sh $0
exit 0