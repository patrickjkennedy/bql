#!/bin/bash

database=$1
table=$2

if ! [ $# -eq 3 ]; then
    echo "Error: parameters problem"
    exit 1
fi

# If database doesn't exist, throw an error
./P.sh $database
# Critical section start
if ! [ -d $database ]; then
    echo "Error: DB does not exist" 
    ./V.sh $database
    exit 1
fi

# If table already exists, throw an error
if [ -f $database/$table ]; then
    echo "Error: table already exists"
    ./V.sh $database
    exit 1
fi

echo $3 > $1/$2
echo "OK: table created"
# Critical section end
./V.sh $database
exit 0