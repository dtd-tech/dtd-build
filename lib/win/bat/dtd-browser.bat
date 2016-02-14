@ECHO OFF
REM Simple script to start Portable Chromium with the right proxy url.

REM Modify the url below if Apache is running on a different port.
REM Example: SET DTDPROXY=http://localhost:8080/dtd.pac.php

SET DTDPROXY=http://localhost/dtd.pac.php

REM Environment settings to avoid Googe API key warnings
setx GOOGLE_API_KEY "no"
setx GOOGLE_DEFAULT_CLIENT_ID "no"
setx GOOGLE_DEFAULT_CLIENT_SECRET "no"

ChromiumPortable\ChromiumPortable.exe /proxy-pac-url=%DTDPROXY% /disable-translate http://dtd2016.dtd/
