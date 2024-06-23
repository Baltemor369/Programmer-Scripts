$env:MYPATH = $env:userprofile+'\Desktop\Coding\'

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
        Write-Host create gitignore
        New-Item .gitignore -type file
        return
    }

    $current_branch = & git rev-parse --abbrev-ref HEAD

    if ($current_branch -eq $branchName) {
        git checkout $branchName
        if ($LASTEXITCODE -ne 0) { Write-Host "git checkout failed"; return }
        git add $files
        if ($LASTEXITCODE -ne 0) { Write-Host "git add failed"; return }
        git commit -m $message
        if ($LASTEXITCODE -ne 0) { Write-Host "git commit failed"; return }
        git push -u origin $branchName
        if ($LASTEXITCODE -ne 0) { Write-Host "git push failed"; return }

    } else {
        Write-Host "Error : remote repository branch '$current_branch' and your current push branch '$branchName' are different."

        $user_input = Read-Host "Do you want to push to the current branch '$current_branch'? (yes/no)"

        if ($user_input -eq "y" -or $user_input -eq "yes") {
            git checkout $current_branch
            if ($LASTEXITCODE -ne 0) { Write-Host "git checkout failed"; return }
            git add $files
            if ($LASTEXITCODE -ne 0) { Write-Host "git add failed"; return }
            git commit -m $message
            if ($LASTEXITCODE -ne 0) { Write-Host "git commit failed"; return }
            git push -u origin $current_branch
            if ($LASTEXITCODE -ne 0) { Write-Host "git push failed"; return }
        }
    }
    
}

function init {
    param (
        [string]$remote,
        [string]$branchName = "main",
        [string]$commitMessage = "first commit"
    )

    if (!(Test-Path .gitignore)) {
        Write-Host Create empty gitignore
        New-Item .gitignore -type file
        return
    }

    if (!$remote) {
        Write-Host "check argument -remote."
        return
    }

    git init
    if ($LASTEXITCODE -ne 0) { Write-Host "git init failed"; return }

    git add .
    if ($LASTEXITCODE -ne 0) { Write-Host "git add failed"; return }

    git commit -m $commitMessage
    if ($LASTEXITCODE -ne 0) { Write-Host "git commit failed"; return }

    git branch -m $branchName
    if ($LASTEXITCODE -ne 0) { Write-Host "git branch rename failed"; return }

    git remote add origin $remote
    if ($LASTEXITCODE -ne 0) { Write-Host "git remote add failed"; return }

    git push -u origin $branchName
    if ($LASTEXITCODE -ne 0) { Write-Host "git push failed"; return }
}

function updatePip {
    & python -m pip install --upgrade pip
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

function runPython {
    param (
        [string]$name = "main.py"
    )

    if (!(Test-Path .env)) {
        python -m venv .env
        & .env\Scripts\activate
        pip install -r requirements.txt
    }else {
        & .env\Scripts\activate
    }
    & python $name
}

function run {
    $current_path = Get-Location
    $batch_file_path = Join-Path -Path $current_path -ChildPath "run.bat"

    if (Test-Path $batch_file_path) {
        & $batch_file_path
    } else {
        Write-Host "Error : file 'run.bat' not found."
    }
}

function help {
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