# Codex Git App

Small PowerShell helpers for the shared workspace at `E:\dev\codex`.

## Files

- `codex-workspace-app.ps1`: one menu app for status, pull, commit, and push.
- `status-codex-workspace.ps1`: show Git status, branch, remote, and recent commits.
- `start-codex-work.ps1`: pull the latest changes before working.
- `finish-codex-work.ps1`: add, commit, and push changes after working.

## Usage

Open PowerShell and run:

```powershell
powershell -ExecutionPolicy Bypass -File .\codex-workspace-app.ps1
```

You can still run each helper directly:

```powershell
powershell -ExecutionPolicy Bypass -File .\status-codex-workspace.ps1
powershell -ExecutionPolicy Bypass -File .\start-codex-work.ps1
powershell -ExecutionPolicy Bypass -File .\finish-codex-work.ps1 -Message "작업 내용 메모"
```

If you omit `-Message`, `finish-codex-work.ps1` creates a timestamped commit message.
