create user 'dbaa'@'localhost' identified by 'dbaa';

create role dbaadmin;

grant all 
on *.*
to dbaadmin;

grant dbaadmin to 'dba'@'localhost';

select * from mysql.user;
show grants for 'dba'@'localhost';

select user dba;

flush privileges;

SHOW GRANTS FOR CURRENT_USER();
