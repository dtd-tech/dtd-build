@ECHO OFF

REM Windows Bat File to start DTD live environment for Windows.

REM First check if this is a resh build.

IF EXIST tmp\fresh_install.txt (
  ECHO This is a fresh install.
  GOTO Init
)

:Start
REM Regular start of Apache and MySQL.
ECHO Starting Apache and MySQL.
UniController.exe start_both
ECHO Started.
GOTO:eof

:Init
REM Routine to import the databases.
ECHO Starting MySQL database.
UniController.exe start_mysql

REM Set root password.
core\mysql\bin\mysqladmin.exe -u root --password=root password _DTD_PASSWORD_

REM Add path to site alias drushrc files
REN core\drush\aliases\aliases.drushrc.php aliases.tmp
ECHO ^<?php > core\drush\aliases\aliases.drushrc.php
ECHO $dtd_root='%CD%'; >> core\drush\aliases\aliases.drushrc.php
TYPE core\drush\aliases\aliases.tmp >> core\drush\aliases\aliases.drushrc.php
DEL core\drush\aliases\aliases.tmp
