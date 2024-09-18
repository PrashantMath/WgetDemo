set PATH=C:\Polyspace\PolyspaceServer\R2024a\polyspace\bin;%PATH%
set ps_helper_access=polyspace-access -host demo-polyspace-review.gnb.mathworks.com -port 9443 -protocol http -credentials-file c:\Polyspace\PolyspaceServer\myCredentials.txt
set RESULT=ResultBF
set PROG=WgetCI
set PARENT_PROJECT_ON_ACCESS=public/pmathapa
set WSP=%WORKSPACE%\Wget
rd /S /Q Notification && md Notification

polyspace-configure -allow-overwrite -prog "%PROG%" -output-options-file "%WSP%\PSOpts.opts" make

polyspace-bug-finder-server.exe -options-file "%WSP%\PSOpts.opts" -results-dir "%WSP%\R_BF_%BUILD_NUMBER%"   ||  EXIT /B 200

%ps_helper_access% -create-project %PARENT_PROJECT_ON_ACCESS%    ||  EXIT /B 200

%ps_helper_access% -upload "%WSP%\R_BF_%BUILD_NUMBER%" -parent-project %PARENT_PROJECT_ON_ACCESS% -project "%PROG%_%BUILD_NUMBER%"	||  EXIT /B 200

%ps_helper_access% -export %PARENT_PROJECT_ON_ACCESS%/%PROG%_%BUILD_NUMBER% -output Results_All.tsv -defects High    ||  EXIT /B 200

exit 0
 

