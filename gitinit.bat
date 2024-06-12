@echo off

IF "%~1"=="-help" GOTO helper

setlocal enabledelayedexpansion

SET remote=
SET branchName=main
SET message=first commit

IF NOT EXIST .gitignore GOTO errorGitignore

IF "%~1"=="" (
    :url
    set /p remote="Enter the url of your git :"
    IF "!remote!"=="" GOTO url

    :branch
    set /p branchName="Enter the branch name :"
    IF "!branchName!"=="" GOTO branch

    :text
    set /p message="Enter your commit message :"
    IF "!message!"=="" GOTO text
@REM else param given
) ELSE (
    IF NOT "%~1"=="" (
        :parse
        IF "%~1"=="" GOTO endparse
        IF "%~1"=="-o" (
            SET remote=%~2
            SHIFT
        )
        IF "%~1"=="-b" (
            SET branchName=%~2
            SHIFT
        )
        IF "%~1"=="-m" (
            SET message=%~2
            SHIFT
        )
        SHIFT
        GOTO parse
    )
)

:endparse
IF "%remote%"=="" GOTO errorOrigin

git init
git add *
git commit -m "%message%"
git branch -m %branchName%
git remote add origin %remote%
git push -u origin %branchName%
pause
exit /b 0

:errorGitignore
echo you should create a .gitignore before launch this script.
pause
exit /b 1

:errorOrigin
echo check your argument -o.
pause
exit /b 1

:helper
echo NOM 
echo    gitinit : init the local git repository with the remote repository.
echo.
echo SYNTAXE
echo    gitinit -option args [-OPTION] [args]
echo.
echo OPTION
echo    -o : the HTTPS url of the remote git repository.
echo    -b : the name of the branch [OPTIONAL] (Default:main).
echo    -m : the commit message [OPTIONAL] (Default:first commit).
echo    -h : the helper.