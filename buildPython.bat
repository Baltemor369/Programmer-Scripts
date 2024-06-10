@echo off

IF "%~1"=="-help" GOTO helper

IF NOT EXIST setup.py (
    echo Error: no setup.py file detected.
    exit /b 1
)

python setup.py build
exit /b 0

:helper
echo NOM 
echo    buildPython : build a exe of a Python project.
echo.
echo SYNTAXE
echo    gitpush [OPTION1]
echo.
echo OPTION
echo    -h : the helper.