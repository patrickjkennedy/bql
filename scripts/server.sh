#!/bin/bash

# Checks to see what mode the server is running in. Default is production, passing 'DEBUG' as the first parameter
# enables verbose server logs.  
mode=${1:-PROD}

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    rm server.pipe
    echo "Server shutdown..."
    exit 0
}

# Define a timestamp function (used in DEBUG mode)
function timestamp() {
  date +"%T"
}

# Print server startup message
echo "Server started..."

# Create the server pipe
mkfifo server.pipe

while true; do

    # Read input from the server pipe
    if read input < server.pipe; then

        # Split input into an array of strings
        input_array=($input)
        cmd=${input_array[0]}
        client_id=${input_array[1]}
        database=${input_array[2]}
        table=${input_array[3]}
        tuple=${input_array[4]}
        client=$client_id.pipe

        # Server Log (if debug mode is set, print to the server)
        if [ $mode = "DEBUG" ]; then
            echo "`timestamp` | Read from server.pipe: $input"
        fi

        case $cmd in
            create_database) ./create_database.sh $database > "$client" & ;;
            create_table) ./create_table.sh $database $table $tuple > "$client" & ;;
            insert) ./insert.sh $database $table $tuple > "$client" & ;;
            select) ./select.sh $database $table $tuple > "$client" & ;;
            shutdown) ctrl_c ;;
            delete_database) ./delete_database.sh $database > "$client" & ;;
            delete_table) ./delete_table.sh $database $table > "$client" & ;;
            *) echo "Error: bad request" > "$client" & ;;
        esac
    fi
done