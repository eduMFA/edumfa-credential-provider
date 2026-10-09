<#
.SYNOPSIS
    Sets up the third-party dependencies required to build the eduMFA Credential Provider.

.PARAMETER SolutionDir
    Path to the solution root (the directory containing EduMFA-CredentialProvider.sln).
    Defaults to the repository root (the parent of this script's directory).
    In CI, pass $env:GITHUB_WORKSPACE.
#>

[CmdletBinding()]
param(
    [string]
    $SolutionDir
)

$ErrorActionPreference = "Stop"

# Resolve the solution directory: explicit param, else GITHUB_WORKSPACE, else repo root.
if (-not $SolutionDir) {
    if ($env:GITHUB_WORKSPACE) {
        $SolutionDir = $env:GITHUB_WORKSPACE
    }
    else {
        $SolutionDir = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
    }
}

if (-not (Test-Path (Join-Path $SolutionDir "EduMFA-CredentialProvider.sln"))) {
    Write-Error "SolutionDir does not contain EduMFA-CredentialProvider.sln: $SolutionDir"
    exit 1
}

Write-Host "Using SolutionDir: $SolutionDir"

# ---------------------------------------------------------------------------
# Step 1: libfido2 1.15.0
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "=== Step 1/2: libfido2 1.15.0 ==="

$libfido2Url = "https://developers.yubico.com/libfido2/Releases/libfido2-1.15.0-win.zip"
$libfido2ZipPath = Join-Path $env:TEMP "libfido2-1.15.0-win.zip"
$libfido2ExtractDir = Join-Path $env:TEMP "libfido2-1.15.0_extract"
$libfido2DestDir = Join-Path $SolutionDir "libfido2-1.15.0-nfc-enabled"

Write-Host "Downloading libfido2 from: $libfido2Url"
Invoke-WebRequest -Uri $libfido2Url -OutFile $libfido2ZipPath

# Clean any previous extraction directory before expanding.
if (Test-Path $libfido2ExtractDir) {
    Remove-Item $libfido2ExtractDir -Recurse -Force -ErrorAction SilentlyContinue
}
Expand-Archive -Path $libfido2ZipPath -DestinationPath $libfido2ExtractDir -Force

$srcStatic = Join-Path $libfido2ExtractDir "libfido2-1.15.0-win\Win64\Release\v143\static"
$srcInclude = Join-Path $libfido2ExtractDir "libfido2-1.15.0-win\include"

if (-not (Test-Path $srcStatic)) {
    Write-Error "libfido2 static lib directory not found in archive: $srcStatic"
    exit 1
}
if (-not (Test-Path $srcInclude)) {
    Write-Error "libfido2 include directory not found in archive: $srcInclude"
    exit 1
}

$destStatic = Join-Path $libfido2DestDir "static"
$destInclude = Join-Path $libfido2DestDir "include"
New-Item -ItemType Directory -Force -Path $destStatic | Out-Null
New-Item -ItemType Directory -Force -Path $destInclude | Out-Null

Copy-Item "$srcStatic\*" -Destination $destStatic -Recurse -Force
Copy-Item "$srcInclude\*" -Destination $destInclude -Recurse -Force

Remove-Item $libfido2ExtractDir -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item $libfido2ZipPath -Force -ErrorAction SilentlyContinue

Write-Host "Installed libfido2 to: $libfido2DestDir"
Get-ChildItem -Path $libfido2DestDir -Recurse | ForEach-Object { Write-Host "  $($_.FullName.Substring($libfido2DestDir.Length))" }

# ---------------------------------------------------------------------------
# Step 2: nlohmann/json v3.12.0
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "=== Step 2/2: nlohmann/json v3.12.0 ==="

$jsonUrl = "https://github.com/nlohmann/json/releases/download/v3.12.0/json.hpp"
$jsonDestDir = Join-Path $SolutionDir "CppClient\CppClient\nlohmann"
$jsonDestPath = Join-Path $jsonDestDir "json.hpp"

New-Item -ItemType Directory -Force -Path $jsonDestDir | Out-Null

Write-Host "Downloading nlohmann/json from: $jsonUrl"
Invoke-WebRequest -Uri $jsonUrl -OutFile $jsonDestPath

Write-Host "Installed json.hpp to: $jsonDestPath"

# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "All dependencies set up successfully."
