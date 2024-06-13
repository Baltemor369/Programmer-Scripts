function lab { 
    $path = $env:userprofile + '\Desktop\Coding'
    Set-Location $path
}
function push {
    param (
        [string[]]$files = @("."),
        [string]$branch = "main",
        [string]$message = "Update"
    )

    if (!(Test-Path .gitignore)) {
        New-Item .gitignore -type file
        return
    }

    git checkout $branch
    git add $files
    git commit -m $message
    git push -u origin $branch
}

function init {
    param (
        [string]$remote,
        [string]$branch = "main",
        [string]$message = "first commit"
    )

    if (!(Test-Path .gitignore)) {
        New-Item .gitignore -type file
        return
    }

    if (!$remote) {
        Write-Host "check your argument -o."
        return
    }

    git init
    git add .
    git commit -m $message
    git branch -m $branch
    git remote add origin $remote
    git push -u origin $branch
}

function pip-upgrade {
    & python -m pip install --upgrade pip
}

function runPython {
    param (
        [string]$name = "main.py"
    )

    & python $name
}

function runJava {
    param (
        [string]$name = "App"
    )

    $env:CLASSPATH = ".;" + $env:CLASSPATH
    $javaFiles = Get-ChildItem -Recurse -Filter "*.java" | ForEach-Object { $_.FullName }
    & javac -d bin $javaFiles
    & java -cp bin $name
}

function envPython {
    param (
        [string]$name = "main.py"
    )

    if (!(Test-Path .env)) {
        python -m venv .env
        .env\Scripts\activate
        pip install -r requirements.txt
    }else {
        .env\Scripts\activate
    }
    & python $name
}

function help {
    Write-Host "lab : change directory to $USER\Desktop\Coding\"
    Write-Host ""
    Write-Host "push : push on github"
    Write-Host "    [param]"
    Write-Host "        -files : list of file to push seperate with ',' (Default:.)"
    Write-Host "        -branch : branch name(Default: main)"
    Write-Host "        -message : commit message(Default: Update)"
    Write-Host ""
    Write-Host "init : init .git "
    Write-Host "    [param]"
    Write-Host "        -remote : HTTPS url from your git repository"
    Write-Host "        -branch : branch name(Default: main)"
    Write-Host "        -message : commit message (Default: first commit)"
    Write-Host ""
    Write-Host "pip-upgrade : upgrade your pip"
    Write-Host ""
    Write-Host "runPython : run normally python project"
    Write-Host "    [param]"
    Write-Host "        -name : name of your mainfile(Default:main.py)"
    Write-Host ""
    Write-Host "runJava : compile and run a java project"
    Write-Host "    [param]"
    Write-Host "        -name : name of your mainfile(Default:App)"
    Write-Host ""
    Write-Host "envPython : create env for python install requirements and run"
    Write-Host "    [param]"
    Write-Host "        -name : name of your mainfile(Default:main.py)"
    Write-Host ""
}