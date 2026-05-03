# Lyneetra's Flow File Operation for Windows

Modern Windows File CLI  
Clean. Fast. Focused.

## Features

- Single progress bar (no terminal spam)
- Copy, move, and delete in one tool
- Wildcard support (`*`, `*.png`, etc.)
- Multi-file and folder operations
- Interactive shell (`flow>`)
- Smart conflict handling (overwrite / skip / rename)
- Recycle Bin or permanent delete
- Lightweight and fast

---

## Quick Start

After downloading:

1. Extract `flow.zip' or Run 
2. Place it in any folder
3. (Optional) Add the folder to PATH

## Download Latest Version

https://github.com/lyneetrastudio/lyneetra_flow_file_operations/releases

## Powershell Installations
```

$installDir = "$env:USERPROFILE\.flow\bin"
$tempZip = "$env:TEMP\flow_install.zip"
$url = "https://github.com/lyneetrastudio/lyneetra_flow_file_operations/releases/download/Windows/Lyneetra.s.Flow.File.Operation.for.Windows.zip"

New-Item -ItemType Directory -Force -Path $installDir | Out-Null
Invoke-WebRequest -Uri $url -OutFile $tempZip
Expand-Archive -Path $tempZip -DestinationPath $installDir -Force
Remove-Item $tempZip -Force

$exe = Get-ChildItem -Path $installDir -Recurse -Filter *.exe | Select-Object -First 1
Move-Item $exe.FullName "$installDir\flow.exe" -Force

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$installDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$installDir", "User")
```

Copyright (c) 2026 Lyneetra Studio

## All rights reserved.

This software is provided as a compiled binary only.

You may:
- Use the software for personal or commercial use

You may NOT:
- Modify, reverse engineer, or decompile the software
- Redistribute, sublicense, or resell the software
- Use the software in any unlawful way

The author is not liable for any damages or data loss.

Use at your own risk.
