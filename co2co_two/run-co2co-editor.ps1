$ErrorActionPreference = "Stop"

$ProjectFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$EditorName = "co2co_editor_v5.html"
$Port = 8765
$EditorUrl = "http://127.0.0.1:$Port/co2co_editor_v5.html"

Set-Location -LiteralPath $ProjectFolder

try {
    $Server = Start-Process -FilePath "py" -ArgumentList @("-m", "http.server", $Port, "--bind", "127.0.0.1") -WorkingDirectory $ProjectFolder -PassThru -WindowStyle Hidden
    Start-Sleep -Milliseconds 900

    if ($Server.HasExited) {
        throw "Co2Co local server could not start. Port $Port may already be in use."
    }

    Start-Process $EditorUrl
    Write-Host ""
    Write-Host "Co2Co editor is running safely for YouTube playback." -ForegroundColor Green
    Write-Host "Editor: $EditorName"
    Write-Host "Close this window when you finish editing." -ForegroundColor Yellow
    Write-Host ""
    Wait-Process -Id $Server.Id
}
finally {
    if ($Server -and -not $Server.HasExited) {
        Stop-Process -Id $Server.Id -Force
    }
}
