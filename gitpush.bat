@echo off

IF "%~1"=="-help" GOTO helper

SET branchName=main
SET commitMessage=Update

:parse
IF "%~1"=="" GOTO endparse
IF "%~1"=="-b" (
    SET "branchName=%~2"
    SHIFT
)
IF "%~1"=="-m" (
    SET "commitMessage=%~2"
    SHIFT
)
SHIFT
GOTO parse

:endparse
git add *
git commit -m "%commitMessage%"
git push -u origin %branchName%
exit /b

:helper
echo NOM 
echo    gitpush
echo.
echo SYNTAXE
echo    gitpush [OPTION1] [OPTION2]
echo.
echo OPTION
echo    -b : name of the branch [OPTIONAL] (Default:main).
echo    -m : the commit message [OPTIONAL] (Default:Update).
