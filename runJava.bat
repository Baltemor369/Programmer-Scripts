@echo off

IF "%~1"=="-help" GOTO helper

SET name=App

IF "%~1"=="-n" (
    SET name=%~2
)

setlocal enabledelayedexpansion
set CLASSPATH=.;%CLASSPATH%
for /R %%f in (*.java) do set JAVAFILES=!JAVAFILES! %%f
javac -d bin !JAVAFILES!
java -cp bin %name%
endlocal
exit

:helper
echo NOM 
echo    runJava
echo.
echo SYNTAXE
echo    runJava [OPTION]
echo.
echo OPTION
echo    -n : program name which start your app [OPTIONAL] (Default:App).
