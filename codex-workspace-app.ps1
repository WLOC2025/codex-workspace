$ErrorActionPreference = "Stop"

$Workspace = "E:\dev\codex"

function Enter-Workspace {
    if (-not (Test-Path -LiteralPath $Workspace)) {
        throw "Workspace not found: $Workspace"
    }

    Set-Location -LiteralPath $Workspace
}

function Show-WorkspaceStatus {
    Enter-Workspace

    Write-Host ""
    Write-Host "Codex workspace: $Workspace" -ForegroundColor Cyan
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

function Start-CodexWork {
    Enter-Workspace

    Write-Host ""
    Write-Host "Pulling latest changes..." -ForegroundColor Cyan
    git status --short
    git pull

    Write-Host ""
    Write-Host "Ready to work." -ForegroundColor Green
}

function Finish-CodexWork {
    Enter-Workspace

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
    $message = Read-Host "Commit message. Leave blank for timestamp message"
    if (-not $message) {
        $message = "Update codex workspace $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    }

    Write-Host ""
    Write-Host "Adding files..." -ForegroundColor Cyan
    git add .

    Write-Host ""
    Write-Host "Committing: $message" -ForegroundColor Cyan
    git commit -m $message

    Write-Host ""
    Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
    git push

    Write-Host ""
    Write-Host "Workspace pushed successfully." -ForegroundColor Green
}

function Show-Menu {
    Clear-Host
    Write-Host "Codex Workspace Git App" -ForegroundColor Cyan
    Write-Host "Workspace: $Workspace"
    Write-Host ""
    Write-Host "1. Status"
    Write-Host "2. Start work: git pull"
    Write-Host "3. Finish work: add, commit, push"
    Write-Host "4. Exit"
    Write-Host ""
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Choose 1-4"

    try {
        switch ($choice) {
            "1" { Show-WorkspaceStatus }
            "2" { Start-CodexWork }
            "3" { Finish-CodexWork }
            "4" { break }
            default { Write-Host "Please choose 1, 2, 3, or 4." -ForegroundColor Red }
        }
    }
    catch {
        Write-Host ""
        Write-Host $_.Exception.Message -ForegroundColor Red
    }

    if ($choice -ne "4") {
        Write-Host ""
        Read-Host "Press Enter to return to menu"
    }
}
