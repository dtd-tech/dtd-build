REM Template. To be added at the end of dtd-start.bat
ECHO Database import complete.
DEL tmp\fresh_install.txt
ECHO Starting Apache.
UniController.exe start_apache
GOTO:eof
