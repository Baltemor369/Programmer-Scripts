@echo off

IF "%~1"=="-help" GOTO helper

python -m pip install --upgrade pip
exit /b 0

:helper
echo NOM 
echo    upgradePython : update your pip. 
echo.
echo SYNTAXE
echo    upgradePython [-OPTION]
echo.
echo OPTION
echo    -h : the helper.