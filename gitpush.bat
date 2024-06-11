@echo off

IF "%~1"=="-help" GOTO helper

SET branchName=main
SET commitMessage=Update
SET files=.

IF NOT EXIST .gitignore GOTO errorGitignore

:parse
IF "%~1"=="" GOTO endparse
IF "%~1"=="-f" (
    SET files=%~2
    SHIFT
)
IF "%~1"=="-b" (
    SET branchName=%~2
    SHIFT
)
IF "%~1"=="-m" (
    SET commitMessage=%~2
    SHIFT
)
SHIFT
GOTO parse

:endparse
git checkout %branchName%
git add %files%
git commit -m "%commitMessage%"
git push -u origin %branchName%
echo Git Command finished
pause
exit /b 0

:errorGitignore
echo you should create a .gitignore before launch this script.
pause
exit /b 1

:helper
echo NOM 
echo    gitpush : add, commit and push on github your project.
echo.
echo SYNTAXE
echo    gitpush [-OPTION] [args]
echo.
echo OPTION
echo    -f : file/folder path, if multiple, put in "double-quote" [OPTIONAL] (Default:.).
echo    -b : name of the branch [OPTIONAL] (Default:main).
echo    -m : the commit message [OPTIONAL] (Default:Update).
echo    -h : the helper.