#!/bin/bash

database=$1
table=$2
tuple=$3

if ! [ $# -eq 3 ]; then
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

# Get number of columns in schema and tuple
schema_cols=`head -1 $database/$table | tr "," " " | wc -w` 
tuple_cols=`echo $tuple | tr "," " " | wc -w`

# Check if number of columns in tuple matches table schema
if [ $tuple_cols -ne $schema_cols ]; then
    echo "Error: number of columns in tuple does not match schema"
    ./V.sh $database
    exit 1
fi

echo $3 >> $1/$2
echo "OK: tuple inserted"
# Critical section end
./V.sh $database
exit 0