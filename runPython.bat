@echo off

IF "%~1"=="-help" GOTO helper

SET name=main.py

IF "%~1"=="-n" (
    SET name=%~2
)

python name

:helper
echo.
echo NOM 
echo    runPython : run a Python project.
echo.
echo SYNTAXE
echo    runPython [-OPTION] [args]
echo.
echo OPTION
echo    -n : program name which start your app [OPTIONAL] (Default:main.py).
echo    -h : the helper.