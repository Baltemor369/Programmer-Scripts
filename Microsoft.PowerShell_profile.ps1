function lab { 
    param (
        [string]$location=""
    )
    $path = $env:userprofile+'\Desktop\Coding\'
    if ($location -eq "ls") {
        Get-ChildItem ($path) | Format-Table
        return
    }
    $path = $path + $location
    if (!(Test-Path ($path))) {

        Write-Host "Path doesn't exist : "$path
    }else{
        Set-Location ($path)
    }
}

function push {
    param (
        [string]$files = ".",
        [string]$branchName = "main",
        [string]$message = "Update"
    )

    if (!(Test-Path .gitignore)) {
        New-Item .gitignore -type file
        return
    }

    git checkout $branchName
    git add $files
    git commit -m $commitMessage
    git push -u origin $branchName
}

function init {
    param (
        [string]$remote,
        [string]$branchName = "main",
        [string]$commitMessage = "first commit"
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
    git commit -m $commitMessage
    git branch -m $branchName
    git remote add origin $remote
    git push -u origin $branchName
}

function update-pip {
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
    Write-Host "    [param]"
    Write-Host "        -location : use to go to in a specific folder in your lab.(Default:'')"
    Write-Host "        -ls : list the contents of the lab directory"
    Write-Host ""
    Write-Host "push : push on github"
    Write-Host "    [param]"
    Write-Host "        -files (Default:.)"
    Write-Host "        -branchName (Default: main)"
    Write-Host "        -commitMessage (Default: Update)"
    Write-Host ""
    Write-Host "init : init .git "
    Write-Host "    [param]"
    Write-Host "        -remote"
    Write-Host "        -branchName (Default: main)"
    Write-Host "        -commitMessage (Default: first commit)"
    Write-Host ""
    Write-Host "pip-upgrade : upgrade your pip"
    Write-Host ""
    Write-Host "runPython : run normally python project"
    Write-Host "    [param]"
    Write-Host "        -name (Default:main.py)"
    Write-Host ""
    Write-Host "runJava : compile and run a java project"
    Write-Host "    [param]"
    Write-Host "        -name (Default:App)"
    Write-Host ""
    Write-Host "envPython : create env for python install requirements and run"
    Write-Host "    [param]"
    Write-Host "        -name (Default:main.py)"
    Write-Host ""
}