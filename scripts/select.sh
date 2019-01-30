#!/bin/bash

database=$1
table=$2
columns=$3

# If 3 parameters are not provided, throw an error
if [ $# -lt 2 ]; then
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

# Create variables needed later
first_tuple_value=`echo $3 | cut -d"," -f1`
second_tuple_value=`echo $3 | cut -d"," -f2`
number_schema_cols=`head -1 $database/$table | tr "," " " | wc -w`

# If no columns are specified, print all columns
if ! [ $# -eq 3 ]; then
    response="start_result"
    response+=' '
    response+=`cat $database/$table`
    response+=' '
    response+="end_result"
    echo $response
    # Critical section end
    ./V.sh $database
    exit 0
fi

# Else, check that the columns exist in the table
IFS=', ' read -r -a colArray <<< "$columns"
IFS=$'\n'
maxCol=$(echo "${colArray[*]}" | sort -nr | head -1)
minCol=$(echo "${colArray[*]}" | sort -n | head -1)

if [ ! $maxCol -gt $number_schema_cols ] && [ $minCol -gt 0 ]; then
    response="start_result"
    response+=' '
    response+=`cut -d',' -f$3 $database/$table`
    response+=' '
    response+="end_result"
    echo $response
    # Critical section end
    ./V.sh $database
    exit 0
else
    echo "Error: column does not exist"
    # Critical section end
    ./V.sh $database
    exit 1
fi

