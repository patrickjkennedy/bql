
 .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. |
| |   ______     | || |    ___       | || |   _____      | |
| |  |_   _ \    | || |  .'   '.     | || |  |_   _|     | |
| |    | |_) |   | || | /  .-.  \    | || |    | |       | |
| |    |  __'.   | || | | |   | |    | || |    | |   _   | |
| |   _| |__) |  | || | \  `-'  \_   | || |   _| |__/ |  | |
| |  |_______/   | || |  `.___.\__|  | || |  |________|  | |
| |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------' 

Welcome to the README Help file for BQL - Bash Query Language.
You can find a list of commands you can use below.

Starting the Server
-------------------

To start the server, run the following command on your terminal from within ./scripts:
./server.sh

To start the server in DEBUG mode, with verbose logging type:
./server.sh DEBUG


Starting the Client
-------------------

To start the client, run the following command on your terminal from within ./scripts:
./client.sh id

where id is your unique client id.


Client commands
---------------

create_database dbname:
Creates a database named 'dbname'.

create_table dbname tablename column1,column2,column3:
Creates a table named 'tablename' in database 'dbname' with column headings column1, column2 and column3.

insert dbname tablename value1,value2,value3:
Inserts the data row value1,value2,value3 into table 'tablename' stored in database 'dbname'.

select dbname tablename:
Displays all the data from table 'tablename' stored in database 'dbname'.

select dbname tablename x[,y]:
Displays the given column number x from table 'tablename' stored in database 'dbname'. 
You can specify further columns by adding commas and valid column numbers. 

For example:
select dbname tablename 1,2,3
Shows:
start_result
column1,column2,column3
value1,value2,value3
end_result

delete_database dbname:
Checks if database 'dbname' exists, and if it does, deletes it.

delete_table dbname tablename:
Checks if the table 'tablename' exists in database 'dbname'. If it does, it deletes it.

shutdown:
Stops the server process.

exit:
Stops the client process.

help:
Opens the README.txt within the BQL client.

Created by Patrick Kennedy (18205918) as part of the individual project for COMP30640.
