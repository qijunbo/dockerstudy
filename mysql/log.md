log
==

```

set global general_log=on;

show variables like '%gener%';

show variables like 'log_output';
 show variables like 'log_output';
set global log_output='TABLE';

select thread_id,command_type,argument from mysql.general_log; 

select * from mysql.general_log; 

```