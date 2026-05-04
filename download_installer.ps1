$ErrorActionPreference = "Stop"

# ===============================
# CONFIG
# ===============================
$repo = "lyneetrastudio/lyneetra_flow_file_operations"
$installDir = "$env:LOCALAPPDATA\Programs\Lyneetra Flow"
$tempDir = "$env:TEMP\flow_install"
$zipName = "flow.zip"

# ===============================
# UI
# ===============================
Write-Host ""
Write-Host "Lyneetra's Flow for Windows Installer" -ForegroundColor Cyan
Write-Host "--------------------------------------"
Write-Host ""

# ===============================
# PREPARE TEMP
# ===============================
if (Test-Path $tempDir) {
    Remove-Item $tempDir -Recurse -Force
}
New-Item -ItemType Directory -Path $tempDir | Out-Null

# ===============================
# GET LATEST RELEASE
# ===============================
Write-Host "Fetching latest release..." -ForegroundColor Yellow

$api = "https://api.github.com/repos/$repo/releases/latest"
$release = Invoke-RestMethod $api

$asset = $release.assets | Where-Object { $_.name -like "*.zip" } | Select-Object -First 1

if (-not $asset) {
    throw "No zip release found."
}

$downloadUrl = $asset.browser_download_url
$zipPath = Join-Path $tempDir $zipName

# ===============================
# DOWNLOAD
# ===============================
Write-Host "Downloading package..." -ForegroundColor Yellow
Invoke-WebRequest $downloadUrl -OutFile $zipPath

# ===============================
# EXTRACT
# ===============================
Write-Host "Extracting..." -ForegroundColor Yellow

if (Test-Path $installDir) {
    Remove-Item $installDir -Recurse -Force
}

New-Item -ItemType Directory -Path $installDir | Out-Null

Expand-Archive $zipPath -DestinationPath $installDir -Force

# ===============================
# ADD TO PATH
# ===============================
Write-Host "Updating PATH..." -ForegroundColor Yellow

$userPath = [Environment]::GetEnvironmentVariable("PATH", "User")

if ($userPath -notlike "*$installDir*") {
    [Environment]::SetEnvironmentVariable(
        "PATH",
        "$userPath;$installDir",
        "User"
    )
}

# ===============================
# CLEANUP
# ===============================
Remove-Item $tempDir -Recurse -Force

# ===============================
# VERIFY
# ===============================
Write-Host ""
Write-Host "Installation complete." -ForegroundColor Green
Write-Host ""

$flowExe = Join-Path $installDir "flow.exe"

if (Test-Path $flowExe) {
    Write-Host "Installed to:" $installDir
    Write-Host ""

    Write-Host "Run this command:" -ForegroundColor Cyan
    Write-Host "flow version"
} else {
    Write-Host "Warning: flow.exe not found after install." -ForegroundColor Red
}
