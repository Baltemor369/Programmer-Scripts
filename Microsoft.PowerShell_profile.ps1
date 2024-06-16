# $env:MYPATH = $env:userprofile+'\Desktop\Coding\'

function lab {
    param (
        [string]$location,
        [string]$set,
        [switch]$get
    )
    if ($get) {
        Write-Host "Current path: $env:MYPATH"
        return
    }

    if ($location -eq "ls") {
        Get-ChildItem -Path $env:MYPATH | Format-Table
        return
    }
    
    if ($location) {
        $newPath = $env:MYPATH+$location
        if (Test-Path ($newPath)) {
            Set-Location -Path $newPath
        } else {
            Write-Host "Path '$newPath' does not exist."
        }
        return
    }
    
    if ($set) {
        $newPath = $env:userprofile + "\" + $set
        if (Test-Path -Path $newPath) {
            $env:MYPATH = $newPath
            Write-Host new path : $env:MYPATH
        } else {
            Write-Host "Path '$newPath' does not exist."
        }
        return
    }
    Set-Location -Path $env:MYPATH
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
    git commit -m $message
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

function updatePip {
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
    Write-Host "mangatek : launch mangatek app"
    Write-Host ""
    Write-Host "lab : change directory to the mainPath : $USER\Desktop\Coding\"
    Write-Host "    [param]"
    Write-Host "        -location (path): use to go to in a specific folder in your lab.(Default:'')"
    Write-Host "            -ls: list the contents of the lab directory"
    Write-Host "        -set (newPath): change the mainPath"
    Write-Host "        -get: display the current mainPath"
    Write-Host ""
    Write-Host "push : push on github"
    Write-Host "    [param]"
    Write-Host "        -files (path): files to push(Default:.)"
    Write-Host "        -branchName (name): branch name(Default: main)"
    Write-Host "        -message (text): your commit message(Default: Update)"
    Write-Host ""
    Write-Host "init : init .git "
    Write-Host "    [param]"
    Write-Host "        -remote (url): the HTTP url of the git repository"
    Write-Host "        -branchName (name): branch name(Default: main)"
    Write-Host "        -message (text): your commit message(Default:first commit)"
    Write-Host ""
    Write-Host "updatePip : upgrade your pip"
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