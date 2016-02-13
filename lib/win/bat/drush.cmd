@ECHO off

title "Drush: Drupal Shell"
set "dtddir=%cd%"

SET PATH=%PATH%;%dtddir%\core\mysql\bin

doskey drush=%dtddir%\core\php55\php.exe %dtddir%\core\drush\drush --alias-path=%dtddir%\core\drush\aliases $*
cd workshops
ECHO DTD-Drush command line
ECHO Aliases:
%dtddir%\core\php55\php.exe %dtddir%\core\drush\drush --alias-path=%dtddir%\core\drush\aliases site-alias
ECHO Examples:
ECHO drush help
ECHO drush @dtd2016 status
