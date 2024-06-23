@echo off

IF "%~1"=="-help" GOTO helper

IF NOT EXIST requirements.txt (
    echo no requirements.txt found.
    pause
    exit /b 0
)

SET name=main.py

IF "%~1"=="-n" (
    SET name=%~2
)

IF NOT EXIST .env (
    python -m venv .env
    cd .env\Scripts
    call activate
    cd ../..
    pip install -r requirements.txt
) ELSE (
    cd .env\Scripts
    call activate
    cd ../..
)
python main.py
exit /b 0


:helper
echo.
echo NOM 
echo    runPython : run a Python project. need a requirements.txt.
echo.
echo SYNTAXE
echo    runPython [-OPTION] [args]
echo.
echo OPTION
echo    -n : program name which start your app [OPTIONAL] (Default:main.py).
echo    -h : the helper.