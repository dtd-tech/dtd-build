@ECHO OFF
REM Simple script to start Portable Chromium with the right proxy url.

REM Modify the url below if Apache is running on a different port.
REM Example: SET DTDPROXY=http://localhost:8080/dtd.pac.php

SET DTDPROXY=http://localhost/dtd.pac.php

start ChromiumPortable\ChromiumPortable.exe /proxy-pac-url=%DTDPROXY% http://dtd2016.dtd/
