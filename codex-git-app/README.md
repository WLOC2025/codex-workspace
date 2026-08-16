# Codex Git App

PowerShell menu apps for Git pull, commit, and push workflows.

## Apps

- `codex-workspace-app.ps1`: fixed app for `E:\dev\codex`.
- `git-current-folder-app.ps1`: general app that uses the current PowerShell folder.
- `run-git-current-folder-app.bat`: double-click helper for the general app.

## Fixed Codex Workspace App

```powershell
powershell -ExecutionPolicy Bypass -File .\codex-workspace-app.ps1
```

Menu:

```text
1. Status
2. Start work: git pull
3. Finish work: add, commit, push
4. Exit
```

## General Current-Folder App

Run it from the folder you want to manage:

```powershell
Set-Location C:\dev\test
powershell -ExecutionPolicy Bypass -File C:\path\to\git-current-folder-app.ps1
```

Menu:

```text
1. Status
2. Start work: git pull
3. Finish work: add, commit, push
4. Initial setup: init, first commit, first push
5. Connect existing repo and first pull
6. Exit
```

You can also copy these two files into any Git project folder and double-click the `.bat` file:

```text
git-current-folder-app.ps1
run-git-current-folder-app.bat
```
