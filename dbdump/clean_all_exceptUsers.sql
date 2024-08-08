
--clean database except users 
--psql  -d trocalodb -a -f ../backend_trocalo/dbdump/clean_all_exceptUsers.sql 

TRUNCATE user_object ; 
TRUNCATE invitation ; 
TRUNCATE proposal ; 
TRUNCATE session ;
TRUNCATE invitation ;
TRUNCATE user_creation ;
TRUNCATE user_created ;
TRUNCATE session ; 

