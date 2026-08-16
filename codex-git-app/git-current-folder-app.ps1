$ErrorActionPreference = "Stop"

$Workspace = (Get-Location).Path

function Enter-Workspace {
    if (-not (Test-Path -LiteralPath $Workspace)) {
        throw "Workspace not found: $Workspace"
    }

    Set-Location -LiteralPath $Workspace
}

function Assert-GitRepository {
    Enter-Workspace

    $isRepo = git rev-parse --is-inside-work-tree 2>$null
    if ($LASTEXITCODE -ne 0 -or $isRepo -ne "true") {
        throw "This folder is not a Git repository: $Workspace"
    }
}

function Test-GitRepository {
    Enter-Workspace

    $isRepo = git rev-parse --is-inside-work-tree 2>$null
    return ($LASTEXITCODE -eq 0 -and $isRepo -eq "true")
}

function Initialize-GitWorkspace {
    Enter-Workspace

    Write-Host ""
    Write-Host "Initial setup for current folder:" -ForegroundColor Cyan
    Write-Host $Workspace
    Write-Host ""

    if (Test-GitRepository) {
        Write-Host "This folder is already a Git repository." -ForegroundColor Yellow
        Write-Host ""
        git status
        return
    }

    $remoteUrl = Read-Host "GitHub repository URL"
    if (-not $remoteUrl) {
        Write-Host "Canceled. GitHub repository URL is required." -ForegroundColor Yellow
        return
    }

    $message = Read-Host "Initial commit message. Leave blank for 'Initial commit'"
    if (-not $message) {
        $message = "Initial commit"
    }

    Write-Host ""
    Write-Host "This will run:" -ForegroundColor Yellow
    Write-Host "git init"
    Write-Host "git branch -M main"
    Write-Host "git remote add origin $remoteUrl"
    Write-Host "git add ."
    Write-Host "git commit -m `"$message`""
    Write-Host "git push -u origin main"
    Write-Host ""

    $confirm = Read-Host "Press Y to initialize and push. Press Enter to cancel"
    if ($confirm -notin @("Y", "y")) {
        Write-Host "Canceled. No Git setup was changed." -ForegroundColor Yellow
        return
    }

    git init
    git branch -M main
    git remote add origin $remoteUrl
    git add .
    git commit -m $message
    git push -u origin main

    Write-Host ""
    Write-Host "Initial setup and first push completed." -ForegroundColor Green
}

function Connect-ExistingRemote {
    Assert-GitRepository

    Write-Host ""
    Write-Host "Connect this folder to an existing remote repository." -ForegroundColor Cyan
    Write-Host $Workspace
    Write-Host ""

    $remoteUrl = Read-Host "GitHub repository URL"
    if (-not $remoteUrl) {
        Write-Host "Canceled. GitHub repository URL is required." -ForegroundColor Yellow
        return
    }

    $hasOrigin = git remote get-url origin 2>$null
    if ($LASTEXITCODE -eq 0 -and $hasOrigin) {
        Write-Host ""
        Write-Host "Existing origin:" -ForegroundColor Yellow
        Write-Host $hasOrigin
        $confirmReplace = Read-Host "Press Y to replace origin URL. Press Enter to cancel"
        if ($confirmReplace -notin @("Y", "y")) {
            Write-Host "Canceled. Origin was not changed." -ForegroundColor Yellow
            return
        }

        git remote set-url origin $remoteUrl
    }
    else {
        git remote add origin $remoteUrl
    }

    git branch -M main
    git pull -u origin main

    Write-Host ""
    Write-Host "Remote connected and initial pull completed." -ForegroundColor Green
}

function Show-WorkspaceStatus {
    Assert-GitRepository

    Write-Host ""
    Write-Host "Git workspace: $Workspace" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Branch:" -ForegroundColor Yellow
    git branch --show-current

    Write-Host ""
    Write-Host "Remote:" -ForegroundColor Yellow
    git remote -v

    Write-Host ""
    Write-Host "Status:" -ForegroundColor Yellow
    git status

    Write-Host ""
    Write-Host "Recent commits:" -ForegroundColor Yellow
    git log --oneline -5
}

function Start-GitWork {
    Assert-GitRepository

    Write-Host ""
    Write-Host "Pulling latest changes..." -ForegroundColor Cyan
    git status --short
    git pull

    Write-Host ""
    Write-Host "Ready to work." -ForegroundColor Green
}

function Finish-GitWork {
    Assert-GitRepository

    Write-Host ""
    Write-Host "Checking changes..." -ForegroundColor Cyan
    $status = git status --porcelain

    if (-not $status) {
        Write-Host "No changes to commit." -ForegroundColor Green
        git status
        return
    }

    Write-Host ""
    Write-Host "Changes:" -ForegroundColor Yellow
    git status --short

    Write-Host ""
    $message = Read-Host "Commit message"
    if (-not $message) {
        Write-Host "Canceled. Commit message is required." -ForegroundColor Yellow
        return
    }

    Write-Host ""
    Write-Host "Commit message:" -ForegroundColor Yellow
    Write-Host $message
    Write-Host ""
    $confirm = Read-Host "Press Y to add, commit, and push. Press Enter to cancel"

    if ($confirm -notin @("Y", "y")) {
        Write-Host "Canceled. No files were added, committed, or pushed." -ForegroundColor Yellow
        return
    }

    Write-Host ""
    Write-Host "Adding files..." -ForegroundColor Cyan
    git add .

    Write-Host ""
    Write-Host "Committing: $message" -ForegroundColor Cyan
    git commit -m $message

    Write-Host ""
    Write-Host "Pushing to remote..." -ForegroundColor Cyan
    git push

    Write-Host ""
    Write-Host "Workspace pushed successfully." -ForegroundColor Green
}

function Show-Menu {
    Clear-Host
    Write-Host "Git Current Folder App" -ForegroundColor Cyan
    Write-Host "Workspace: $Workspace"
    Write-Host ""
    Write-Host "1. Status"
    Write-Host "2. Start work: git pull"
    Write-Host "3. Finish work: add, commit, push"
    Write-Host "4. Initial setup: init, first commit, first push"
    Write-Host "5. Connect existing repo and first pull"
    Write-Host "6. Exit"
    Write-Host ""
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Choose 1-6"

    try {
        switch ($choice) {
            "1" { Show-WorkspaceStatus }
            "2" { Start-GitWork }
            "3" { Finish-GitWork }
            "4" { Initialize-GitWorkspace }
            "5" { Connect-ExistingRemote }
            "6" { break }
            default { Write-Host "Please choose 1, 2, 3, 4, 5, or 6." -ForegroundColor Red }
        }
    }
    catch {
        Write-Host ""
        Write-Host $_.Exception.Message -ForegroundColor Red
    }

    if ($choice -ne "6") {
        Write-Host ""
        Read-Host "Press Enter to return to menu"
    }
}
