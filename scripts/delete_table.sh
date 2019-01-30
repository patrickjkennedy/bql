#!/bin/bash

database=$1
table=$2

if [ $# -gt 2 ]; then
    echo "Error: parameters problem"
    exit 1
fi

# If database doesn't exist, throw an error
# Critical section start
./P.sh $database
if ! [ -d $database ]; then
    echo "Error: DB does not exist"
    ./V.sh $database 
    exit 1
fi

# If table doesn't exist, throw an error
if ! [ -f $database/$table ]; then
    echo "Error: table does not exist"
    ./V.sh $database
    exit 1
fi

rm $database/$table
echo "OK: table deleted"
# Critical section end
./V.sh $database
exit 0