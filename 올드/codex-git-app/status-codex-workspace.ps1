$ErrorActionPreference = "Stop"

$Workspace = "E:\dev\codex"

if (-not (Test-Path -LiteralPath $Workspace)) {
    throw "Workspace not found: $Workspace"
}

Set-Location -LiteralPath $Workspace

Write-Host ""
Write-Host "Codex workspace:" $Workspace -ForegroundColor Cyan
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
