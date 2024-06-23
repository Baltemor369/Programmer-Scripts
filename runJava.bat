@echo off

IF "%~1"=="-help" GOTO helper

SET name=App

IF "%~1"=="-n" (
    SET name=%~2
)

setlocal enabledelayedexpansion
set CLASSPATH=.;%CLASSPATH%
for /R %%f in (*.java) do set JAVAFILES=!JAVAFILES! %%f

echo project compilation in bin\
javac -d bin !JAVAFILES!

echo launch App
java -cp bin %name%
endlocal

:helper
echo NOM 
echo    runJava : compile and run a Java project.
echo.
echo SYNTAXE
echo    runJava [-OPTION] [args]
echo.
echo OPTION
echo    -n : program name which start your app [OPTIONAL] (Default:App).
echo    -h : the helper.