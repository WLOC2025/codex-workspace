param(
    [string]$Message
)

$ErrorActionPreference = "Stop"

$Workspace = "E:\dev\codex"

if (-not (Test-Path -LiteralPath $Workspace)) {
    throw "Workspace not found: $Workspace"
}

Set-Location -LiteralPath $Workspace

Write-Host ""
Write-Host "Checking Codex workspace..." -ForegroundColor Cyan
Write-Host $Workspace
Write-Host ""

$status = git status --porcelain

if (-not $status) {
    Write-Host "No changes to commit." -ForegroundColor Green
    git status
    exit 0
}

if (-not $Message) {
    $Message = "Update codex workspace $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
}

Write-Host "Changes:" -ForegroundColor Yellow
git status --short

Write-Host ""
Write-Host "Adding files..." -ForegroundColor Cyan
git add .

Write-Host ""
Write-Host "Committing:" $Message -ForegroundColor Cyan
git commit -m $Message

Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
git push

Write-Host ""
Write-Host "Workspace pushed successfully." -ForegroundColor Green
