###############################################################################
# Techla Kit - One-line bootstrap installer (Windows PowerShell)
###############################################################################
# Cách dùng:
#   iwr -useb https://raw.githubusercontent.com/techlaaidev/techla-kit/main/bootstrap.ps1 | iex
#
# Tùy chọn (set env vars trước):
#   $env:TK_DIR = "$HOME\dev\techla-kit"; iwr ... | iex
#   $env:TK_MODE = "minimal"; iwr ... | iex
#   $env:TK_BRANCH = "dev"; iwr ... | iex
###############################################################################

# UTF-8 cho Vietnamese + emoji (PS 5.1 default cp1252)
try {
    [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
    chcp 65001 > $null 2>&1
} catch {}

$ErrorActionPreference = "Stop"

$RepoUrl    = if ($env:TK_REPO)   { $env:TK_REPO }   else { "https://github.com/techlaaidev/techla-kit.git" }
$InstallDir = if ($env:TK_DIR)    { $env:TK_DIR }    else { Join-Path $HOME ".techla-kit" }
$Branch     = if ($env:TK_BRANCH) { $env:TK_BRANCH } else { "main" }
$Mode       = if ($env:TK_MODE)   { $env:TK_MODE }   else { "full" }

function Write-Say($t)  { Write-Host "ℹ️  $t" -ForegroundColor Blue }
function Write-Ok($t)   { Write-Host "✅ $t" -ForegroundColor Green }
function Write-Warn($t) { Write-Host "⚠️  $t" -ForegroundColor Yellow }
function Write-Step($t) { Write-Host "▶ $t" -ForegroundColor Cyan }

Write-Host ""
Write-Host ("━" * 50) -ForegroundColor Cyan
Write-Host "  Techla Kit - One-line Bootstrap" -ForegroundColor Cyan
Write-Host ("━" * 50) -ForegroundColor Cyan
Write-Host ""
Write-Host "Repo:   $RepoUrl"
Write-Host "Branch: $Branch"
Write-Host "Đến:    $InstallDir"
Write-Host "Mode:   $Mode"
Write-Host ""

# 1. Check git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Warn "Chưa thấy git. Cần cài git trước."
    Write-Say "Tải: https://git-scm.com/download/win"
    Write-Say "Hoặc: winget install Git.Git"
    exit 1
}
Write-Ok "git có sẵn"

# 2. Clone hoặc pull
if (Test-Path (Join-Path $InstallDir ".git")) {
    Write-Step "Repo đã tồn tại → cập nhật..."
    Set-Location $InstallDir
    git fetch origin $Branch
    git checkout $Branch
    git pull origin $Branch
    Write-Ok "Đã cập nhật repo"
} else {
    if (Test-Path $InstallDir) {
        Write-Warn "$InstallDir đã tồn tại nhưng không phải git repo → backup"
        $backup = "$InstallDir.bak-" + (Get-Date -Format "yyyyMMdd-HHmmss")
        Move-Item -Path $InstallDir -Destination $backup -Force
    }
    Write-Step "Cloning repo..."
    git clone --depth=1 --branch=$Branch $RepoUrl $InstallDir
    Write-Ok "Đã clone xong"
}

# 3. Chạy installer
Write-Step "Chạy installer ($Mode mode)..."
Set-Location $InstallDir

$installScript = Join-Path $InstallDir "install.ps1"
switch ($Mode) {
    "minimal" { & $installScript -Minimal }
    "full"    { & $installScript -Full }
    default   { & $installScript }
}

Write-Host ""
Write-Host ("━" * 50) -ForegroundColor Green
Write-Host "🎉 Hoàn tất bootstrap Techla Kit" -ForegroundColor Green
Write-Host ("━" * 50) -ForegroundColor Green
Write-Host ""
Write-Host "Repo lưu tại: $InstallDir"
Write-Host ""
Write-Host "Lần sau muốn cập nhật:" -ForegroundColor Cyan
Write-Host "  cd $InstallDir"
Write-Host "  git pull"
Write-Host "  .\install.ps1 -$($Mode.Substring(0,1).ToUpper() + $Mode.Substring(1))"
Write-Host ""
Write-Host "Mở Claude Code:" -ForegroundColor Cyan
Write-Host "  claude"
Write-Host ""
