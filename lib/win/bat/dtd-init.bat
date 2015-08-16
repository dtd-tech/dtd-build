@ECHO OFF
REM This is a template to be used on all databases.

ECHO Creating database _DTD_DB_
core\mysql\bin\mysql.exe -u root --password=_DTD_PASSWORD_ -e "CREATE DATABASE _DTD_DB_ CHARACTER SET utf8 COLLATE utf8_general_ci;"

ECHO Granting permissions to user _DTD_USER_
core\mysql\bin\mysql.exe -u root --password=_DTD_PASSWORD_ -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES ON _DTD_DB_.* TO '_DTD_USER_'@'localhost' IDENTIFIED BY '_DTD_PASSWORD_';"

ECHO Import database _DTD_DB_
core\mysql\bin\mysql.exe -u _DTD_USER_ --password=_DTD_PASSWORD_ _DTD_DB_ < _DTD_DB_DUMP_ 
