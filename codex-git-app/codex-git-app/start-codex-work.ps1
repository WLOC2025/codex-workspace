$ErrorActionPreference = "Stop"

$Workspace = "E:\dev\codex"

if (-not (Test-Path -LiteralPath $Workspace)) {
    throw "Workspace not found: $Workspace"
}

Set-Location -LiteralPath $Workspace

Write-Host ""
Write-Host "Pulling latest changes for Codex workspace..." -ForegroundColor Cyan
Write-Host $Workspace
Write-Host ""

git status --short
git pull

Write-Host ""
Write-Host "Ready to work." -ForegroundColor Green
