@ECHO off
title "Drush: Drupal Shell"
set "dtddir=%cd%"

doskey drush=%dtddir%\core\php55\php.exe %dtddir%\core\drush\drush.php --alias-path=%dtddir\core\drush\aliases $*
cd tracks
