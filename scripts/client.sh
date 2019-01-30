#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 accepts one parameter (client ID)."
    exit 1
fi

# Print welcome message
echo "Connected to BQL Server. Type 'help' for more information."
echo "Please enter your commands below: "

# Get the Client ID provided
client_id=$1

# Create the client pipe
mkfifo $client_id.pipe
client=$client_id.pipe

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    rm $client_id.pipe
    exit 0
}

while true; do

    # Accept a request from the user
    read -p ">>> " input

    # Split input into array
    input_array=($input)
    cmd=${input_array[0]}
    input_count=`echo $input | wc -w`

    if [ $input_count -eq 1 ]; then

        # Check if the exit command has been given
        if [ "$cmd" = "exit" ]; then
            echo "Shutting down client..."
            echo "Have a nice day."
            ctrl_c

        # Check if the shutdown command has been given
        elif [ "$cmd" = "shutdown" ]; then
            echo "shutdown" > server.pipe
            echo "Server shutdown..."
        
        # Check if the help command has been given
        elif [ "$cmd" = "help" ]; then
            less ../README.txt

        else
            echo "Client request must be of the form: req args"
        fi
    
    # We want to check that the request is in the form 'req args' - i.e. has at least two parameters
    elif [ $input_count -lt 2 ]; then
        echo "Client request must be of the form: req args"

    else
        # Create the client output string
        output="$cmd $client_id"
        for ((x=1; x<=${#input_array[@]}; x++)); do
            output+=" ${input_array[$x]}"
        done

        # Direct the request to the server pipe
        echo $output > server.pipe

        # Read server's response from the client pipe
        read resp < "$client"

        # Split response into array of strings
        resp_array=($resp)

        # Check if resp is a select statement
        if [ ${resp_array[0]} = "start_result" ]; then
            echo "$resp" | tr " " "\n"
        
        # Print the response from the server (if resp != "start_result")
        elif [ ${resp_array[0]} != "start_result" ]; then
            echo "$resp"
        fi
    fi
done