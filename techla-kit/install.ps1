###############################################################################
# Techla Kit Installer (Windows PowerShell)
###############################################################################
# Cách dùng:
#   .\install.ps1               # Cài tương tác
#   .\install.ps1 -Yes          # Cài tất cả không hỏi
#   .\install.ps1 -Minimal      # Chỉ cài SuperClaude
#   .\install.ps1 -Full         # Cài tất cả
#   .\install.ps1 -Uninstall    # Gỡ cài đặt
#   .\install.ps1 -ExportAgents -Tool codex -Output .\exports\codex
#   .\install.ps1 -InstallTool codex -TargetDir $HOME\.codex\techla-kit
#   .\install.ps1 -Help         # Trợ giúp
#
# Nếu gặp lỗi "running scripts is disabled":
#   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
###############################################################################

[CmdletBinding()]
param(
    [switch]$Yes,
    [switch]$Minimal,
    [switch]$Full,
    [switch]$Uninstall,
    [switch]$ExportAgents,
    [string]$Tool = "codex",
    [string]$Output = "exports/agents",
    [string]$InstallTool = "",
    [string]$TargetDir = "",
    [switch]$ListExportables,
    [switch]$Help
)

$ErrorActionPreference = "Stop"

# Force UTF-8 output for Vietnamese + emoji (PS 5.1 mặc định cp1252)
try {
    [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
    [Console]::InputEncoding  = [System.Text.UTF8Encoding]::new()
    $OutputEncoding = [System.Text.UTF8Encoding]::new()
    # Đổi codepage console sang 65001 (UTF-8) - silent
    chcp 65001 > $null 2>&1
} catch {
    # Bỏ qua nếu không set được (vd: PSReadLine cũ)
}

$ScriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeHome  = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $HOME ".claude" }
$BackupDir   = Join-Path $ClaudeHome (".techla-backup-" + (Get-Date -Format "yyyyMMdd-HHmmss"))
$Manifest    = Join-Path $ClaudeHome ".techla-installed.txt"

# Mode: Interactive | Yes | Minimal | Full | Uninstall
$Mode = "Interactive"
if ($Yes)       { $Mode = "Yes" }
if ($Minimal)   { $Mode = "Minimal" }
if ($Full)      { $Mode = "Full" }
if ($Uninstall) { $Mode = "Uninstall" }
if ($ExportAgents) { $Mode = "ExportAgents" }
if ($InstallTool) { $Mode = "InstallTool" }
if ($ListExportables) { $Mode = "ListExportables" }

###############################################################################
# UI helpers
###############################################################################
function Write-Title($text) {
    Write-Host ""
    Write-Host ("━" * 50) -ForegroundColor Cyan
    Write-Host "  $text" -ForegroundColor Cyan
    Write-Host ("━" * 50) -ForegroundColor Cyan
    Write-Host ""
}
function Write-Say($t)  { Write-Host "ℹ️  $t" -ForegroundColor Blue }
function Write-Ok($t)   { Write-Host "✅ $t" -ForegroundColor Green }
function Write-Warn($t) { Write-Host "⚠️  $t" -ForegroundColor Yellow }
function Write-Err($t)  { Write-Host "❌ $t" -ForegroundColor Red }
function Write-Step($t) { Write-Host "▶ $t" -ForegroundColor Cyan }

function Ask($prompt, $default = "y") {
    if ($Mode -in @("Yes","Minimal","Full")) { return $true }
    $hint = if ($default -eq "y") { "[Y/n]" } else { "[y/N]" }
    $response = Read-Host "$prompt $hint"
    if ([string]::IsNullOrWhiteSpace($response)) { $response = $default }
    return $response -match '^[Yy]'
}

function Show-Help {
    @"
Techla Kit Installer (Windows)

Cách dùng:
  .\install.ps1              Cài tương tác (chọn nhóm)
  .\install.ps1 -Yes         Cài tất cả không hỏi
  .\install.ps1 -Minimal     Chỉ SuperClaude (gọn nhẹ)
  .\install.ps1 -Full        Tất cả (SuperClaude + claude-skills)
  .\install.ps1 -Uninstall   Gỡ cài đặt
  .\install.ps1 -ExportAgents -Tool codex -Output .\exports\codex
  .\install.ps1 -InstallTool codex -TargetDir $HOME\.codex\techla-kit
  .\install.ps1 -ListExportables
  .\install.ps1 -Help        Trợ giúp

Script copy skills/agents/commands từ:
  - SuperClaude Framework
  - claude-skills (Alireza) - 315+ skills

Files cài vào: ~/.claude/{skills,agents,commands,modes,rules}/
Export agents: AGENTS.md bundle cho codex/opencode/pi
"@ | Write-Host
}

###############################################################################
# Tracking & helpers
###############################################################################
function Track($path) {
    Add-Content -Path $Manifest -Value $path
}

function Backup-IfExists($path) {
    if (Test-Path $path) {
        if (-not (Test-Path $BackupDir)) { New-Item -ItemType Directory -Path $BackupDir | Out-Null }
        $rel    = $path.Substring($ClaudeHome.Length).TrimStart('\','/')
        $target = Join-Path $BackupDir $rel
        $parent = Split-Path -Parent $target
        if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent | Out-Null }
        Copy-Item -Path $path -Destination $target -Recurse -Force
    }
}

function Copy-Tracked($src, $dst) {
    Backup-IfExists $dst
    Copy-Item -Path $src -Destination $dst -Recurse -Force
    Track $dst
}

function Test-Prerequisites {
    Write-Step "Kiểm tra môi trường..."
    if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
        Write-Warn "Chưa thấy lệnh 'claude' (Claude Code CLI)."
        Write-Say  "Cài Claude Code: https://docs.claude.com/en/docs/claude-code"
        if (-not (Ask "Vẫn tiếp tục?" "n")) { exit 1 }
    } else {
        Write-Ok "Claude Code đã cài."
    }
    if (-not (Test-Path $ClaudeHome)) { New-Item -ItemType Directory -Path $ClaudeHome -Force | Out-Null }
    Write-Ok "Thư mục Claude home: $ClaudeHome"
}

###############################################################################
# Install: SuperClaude
###############################################################################
function Install-SuperClaude {
    $scDir = Join-Path $ScriptDir "components\superclaude"
    if (-not (Test-Path $scDir)) {
        Write-Warn "Bỏ qua SuperClaude (không thấy $scDir)"
        return
    }
    Write-Title "Cài đặt SuperClaude Framework"

    # Agents, modes, rules: copy flat
    foreach ($pair in @(
        @{ Src="agents";   Dst="agents" },
        @{ Src="modes";    Dst="modes" },
        @{ Src="core";     Dst="rules" }
    )) {
        $src = Join-Path $scDir $pair.Src
        $dst = Join-Path $ClaudeHome $pair.Dst
        if (-not (Test-Path $src)) { continue }
        if (-not (Test-Path $dst)) { New-Item -ItemType Directory -Path $dst -Force | Out-Null }
        $n = 0
        Get-ChildItem -Path $src -Filter "*.md" -File | ForEach-Object {
            Copy-Tracked $_.FullName (Join-Path $dst $_.Name)
            $n++
        }
        Write-Ok "Đã cài $n $($pair.Dst) từ SuperClaude"
    }

    # Commands → subfolder tk/ để Claude Code namespace thành /tk:cmd (unified)
    # IMPORTANT: rewrite /sc: → /tk: trong NỘI DUNG file để namespace nhất quán
    $cmdSrc = Join-Path $scDir "commands"
    $cmdDst = Join-Path $ClaudeHome "commands\tk"
    if (Test-Path $cmdSrc) {
        if (-not (Test-Path $cmdDst)) { New-Item -ItemType Directory -Path $cmdDst -Force | Out-Null }
        $n = 0
        Get-ChildItem -Path $cmdSrc -Filter "*.md" -File | ForEach-Object {
            $target = Join-Path $cmdDst $_.Name
            Backup-IfExists $target
            # Replace /sc: → /tk: trong content (UTF-8)
            $content = Get-Content $_.FullName -Raw -Encoding UTF8
            $content = $content -replace '/sc:', '/tk:'
            Set-Content -Path $target -Value $content -Encoding UTF8 -NoNewline
            Track $target
            $n++
        }
        Write-Ok "Đã cài $n commands từ SuperClaude (truy cập qua /tk:tên-lệnh)"
    }

    # Skills (each in own dir)
    $skillsSrc = Join-Path $scDir "skills"
    $skillsDst = Join-Path $ClaudeHome "skills"
    if (Test-Path $skillsSrc) {
        if (-not (Test-Path $skillsDst)) { New-Item -ItemType Directory -Path $skillsDst -Force | Out-Null }
        $n = 0
        Get-ChildItem -Path $skillsSrc -Directory | ForEach-Object {
            Copy-Tracked $_.FullName (Join-Path $skillsDst $_.Name)
            $n++
        }
        Write-Ok "Đã cài $n skills từ SuperClaude"
    }
}

###############################################################################
# Install: claude-skills
###############################################################################
function Install-ClaudeSkills {
    $csDir = Join-Path $ScriptDir "components\claude-skills"
    if (-not (Test-Path $csDir)) {
        Write-Warn "Bỏ qua claude-skills (không thấy $csDir)"
        return
    }
    Write-Title "Cài đặt claude-skills (Alireza)"

    $skillsDst   = Join-Path $ClaudeHome "skills"
    $agentsDst   = Join-Path $ClaudeHome "agents"
    $commandsDst = Join-Path $ClaudeHome "commands\tk"
    foreach ($d in @($skillsDst, $agentsDst, $commandsDst)) {
        if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
    }

    $skillCount = 0; $agentCount = 0; $cmdCount = 0

    # Top-level commands → /tk: + rewrite /cs: → /tk: trong content
    $topCmds = Join-Path $csDir "_commands"
    if (Test-Path $topCmds) {
        Get-ChildItem -Path $topCmds -Filter "*.md" -File | ForEach-Object {
            $target = Join-Path $commandsDst $_.Name
            if (-not (Test-Path $target)) {
                $content = (Get-Content $_.FullName -Raw -Encoding UTF8) -replace '/cs:', '/tk:'
                Set-Content -Path $target -Value $content -Encoding UTF8 -NoNewline
                Track $target
                $cmdCount++
            }
        }
    }
    $topAgents = Join-Path $csDir "_agents"
    if (Test-Path $topAgents) {
        Get-ChildItem -Path $topAgents -Filter "*.md" -File -Recurse | ForEach-Object {
            $target = Join-Path $agentsDst $_.Name
            if (-not (Test-Path $target)) {
                Copy-Item -Path $_.FullName -Destination $target -Force
                Track $target
                $agentCount++
            }
        }
    }

    # Each domain → walk plugins
    Get-ChildItem -Path $csDir -Directory | Where-Object { $_.Name -notlike "_*" } | ForEach-Object {
        $domain = $_.FullName
        Get-ChildItem -Path $domain -Directory | ForEach-Object {
            $plugin = $_.FullName

            # Skills: {plugin}/skills/{skill-name}/SKILL.md
            $pluginSkills = Join-Path $plugin "skills"
            if (Test-Path $pluginSkills) {
                Get-ChildItem -Path $pluginSkills -Directory | ForEach-Object {
                    $target = Join-Path $skillsDst $_.Name
                    if (-not (Test-Path $target)) {
                        Copy-Item -Path $_.FullName -Destination $target -Recurse -Force
                        Track $target
                        $script:skillCount++
                    }
                }
            }

            # Agents
            $pluginAgents = Join-Path $plugin "agents"
            if (Test-Path $pluginAgents) {
                Get-ChildItem -Path $pluginAgents -Filter "*.md" -File | ForEach-Object {
                    $target = Join-Path $agentsDst $_.Name
                    if (-not (Test-Path $target)) {
                        Copy-Item -Path $_.FullName -Destination $target -Force
                        Track $target
                        $script:agentCount++
                    }
                }
            }

            # Commands → /tk: + rewrite /cs: → /tk:
            $pluginCmds = Join-Path $plugin "commands"
            if (Test-Path $pluginCmds) {
                Get-ChildItem -Path $pluginCmds -Filter "*.md" -File | ForEach-Object {
                    $target = Join-Path $commandsDst $_.Name
                    if (-not (Test-Path $target)) {
                        $content = (Get-Content $_.FullName -Raw -Encoding UTF8) -replace '/cs:', '/tk:'
                        Set-Content -Path $target -Value $content -Encoding UTF8 -NoNewline
                        Track $target
                        $script:cmdCount++
                    }
                }
            }
        }
    }

    Write-Ok "claude-skills: $skillCount skills, $agentCount agents, $cmdCount commands"
}

###############################################################################
# Install Techla custom (commands + skills riêng của Techla Kit)
###############################################################################
function Install-Techla {
    $tDir = Join-Path $ScriptDir "components\techla"
    if (-not (Test-Path $tDir)) {
        Write-Warn "Bỏ qua Techla custom (không thấy $tDir)"
        return
    }
    Write-Title "Cài đặt Techla custom (workflow brainstorm → plan → implement)"

    # Commands → subfolder commands/tk/ (unified)
    $cmdSrc = Join-Path $tDir "commands"
    $cmdDst = Join-Path $ClaudeHome "commands\tk"
    if (Test-Path $cmdSrc) {
        if (-not (Test-Path $cmdDst)) { New-Item -ItemType Directory -Path $cmdDst -Force | Out-Null }
        $n = 0
        Get-ChildItem -Path $cmdSrc -Filter "*.md" -File | ForEach-Object {
            Copy-Tracked $_.FullName (Join-Path $cmdDst $_.Name)
            $n++
        }
        Write-Ok "Đã cài $n commands Techla (gọi qua /tk:tên-lệnh)"
    }

    # Skills → flat
    $skillSrc = Join-Path $tDir "skills"
    $skillDst = Join-Path $ClaudeHome "skills"
    if (Test-Path $skillSrc) {
        if (-not (Test-Path $skillDst)) { New-Item -ItemType Directory -Path $skillDst -Force | Out-Null }
        $n = 0
        Get-ChildItem -Path $skillSrc -Directory | ForEach-Object {
            Copy-Tracked $_.FullName (Join-Path $skillDst $_.Name)
            $n++
        }
        Write-Ok "Đã cài $n skills Techla"
    }

    # Rules → ~/.claude/rules/
    $rulesSrc = Join-Path $tDir "rules"
    $rulesDst = Join-Path $ClaudeHome "rules"
    if (Test-Path $rulesSrc) {
        if (-not (Test-Path $rulesDst)) { New-Item -ItemType Directory -Path $rulesDst -Force | Out-Null }
        $n = 0
        Get-ChildItem -Path $rulesSrc -Filter "*.md" -File | ForEach-Object {
            Copy-Tracked $_.FullName (Join-Path $rulesDst $_.Name)
            $n++
        }
        Write-Ok "Đã cài $n workflow rules Techla"
    }
}

###############################################################################
# Install CLAUDE.md (global behavioral guidelines)
###############################################################################
function Install-ClaudeMd {
    $src = Join-Path $ScriptDir "CLAUDE.md"
    if (-not (Test-Path $src)) { return }

    $dst = Join-Path $ClaudeHome "CLAUDE.md"
    Backup-IfExists $dst
    Copy-Item -Path $src -Destination $dst -Force
    Track $dst
    Write-Ok "Đã cài CLAUDE.md vào $dst (toàn cục)"
}

###############################################################################
# Install hooks
###############################################################################
function Install-Hooks {
    $src = Join-Path $ScriptDir "components\superclaude\hooks\hooks.json"
    if (-not (Test-Path $src)) { return }
    if (-not (Ask "Cài hooks (auto-verify code sau Write/Edit)?")) { return }

    $settings = Join-Path $ClaudeHome "settings.json"
    if (Test-Path $settings) {
        Backup-IfExists $settings
        $altPath = Join-Path $ClaudeHome "techla-hooks.json"
        Copy-Item -Path $src -Destination $altPath -Force
        Write-Warn "settings.json đã tồn tại → hooks lưu ở $altPath"
        Write-Warn "Tự merge thủ công (xem docs\HUONG-DAN-SU-DUNG.md)"
        Track $altPath
    } else {
        Copy-Item -Path $src -Destination $settings -Force
        Track $settings
        Write-Ok "Đã tạo settings.json với hooks"
    }
}


###############################################################################
# Export agents to Codex/OpenCode/Pi
###############################################################################
function Invoke-AgentExport {
    $exporter = Join-Path $ScriptDir "scripts\export-agents.py"
    if (-not (Test-Path $exporter)) { Write-Err "Không thấy $exporter"; exit 1 }
    python $exporter --tool $Tool --output $Output --clean
}

function Install-ExportedTool {
    if ([string]::IsNullOrWhiteSpace($TargetDir)) { Write-Err "Cần -TargetDir khi dùng -InstallTool"; exit 1 }
    $script:Tool = $InstallTool
    $tmpDir = Join-Path ([System.IO.Path]::GetTempPath()) ("techla-agent-export-$InstallTool-" + [System.Guid]::NewGuid().ToString("N"))
    $script:Output = $tmpDir
    Invoke-AgentExport
    if (-not (Test-Path $TargetDir)) { New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null }
    Copy-Item -Path (Join-Path $tmpDir "*") -Destination $TargetDir -Recurse -Force
    Write-Ok "Đã migrate $InstallTool bundle vào $TargetDir"
}

###############################################################################
# Uninstall
###############################################################################
function Uninstall-All {
    Write-Title "Gỡ Techla Kit"
    if (-not (Test-Path $Manifest)) {
        Write-Err "Không thấy manifest $Manifest"
        exit 1
    }
    $items = Get-Content $Manifest
    if (-not (Ask "Chắc chắn gỡ $($items.Count) mục?" "n")) { Write-Say "Đã hủy"; exit 0 }

    $n = 0
    foreach ($p in $items) {
        if ([string]::IsNullOrWhiteSpace($p)) { continue }
        if (Test-Path $p) {
            Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue
            $n++
        }
    }
    Move-Item -Path $Manifest -Destination ("$Manifest.removed-" + (Get-Date -Format "yyyyMMdd-HHmmss")) -Force
    Write-Ok "Đã gỡ $n mục"
}

###############################################################################
# Interactive menu
###############################################################################
function Show-Menu {
    Write-Title "Chọn nhóm muốn cài"
    Write-Host "  1) Minimal  → Chỉ SuperClaude (~50 mục, gọn nhẹ)"
    Write-Host "  2) Full     → Tất cả (SuperClaude + claude-skills, 400+ mục)"
    Write-Host "  3) Custom   → Chọn từng nhóm"
    Write-Host ""
    $choice = Read-Host "Lựa chọn [1/2/3]"
    switch ($choice) {
        "1" { $script:Mode = "Minimal" }
        "2" { $script:Mode = "Full" }
        "3" { $script:Mode = "Custom" }
        default { Write-Err "Lựa chọn không hợp lệ"; exit 1 }
    }
}

###############################################################################
# Main
###############################################################################
if ($Help) { Show-Help; exit 0 }

Write-Title "Techla Kit Installer"
Write-Say "Phiên bản 1.0.0 - Toolkit Claude Code tổng hợp"
Write-Host ""

if ($Mode -eq "ListExportables") {
    python (Join-Path $ScriptDir "scripts\export-agents.py") --list-exportables
    exit 0
}

if ($Mode -eq "ExportAgents") {
    Invoke-AgentExport
    exit 0
}

if ($Mode -eq "InstallTool") {
    Install-ExportedTool
    exit 0
}

Test-Prerequisites

if ($Mode -eq "Uninstall") { Uninstall-All; exit 0 }

if ($Mode -eq "Interactive") { Show-Menu }

# Khởi tạo manifest mới
Set-Content -Path $Manifest -Value ""

switch ($Mode) {
    "Minimal" {
        Install-SuperClaude
        Install-Techla
        Install-ClaudeMd
        Install-Hooks
    }
    { $_ -in "Full","Yes" } {
        Install-SuperClaude
        Install-ClaudeSkills
        Install-Techla
        Install-ClaudeMd
        Install-Hooks
    }
    "Custom" {
        if (Ask "Cài SuperClaude?") { Install-SuperClaude }
        if (Ask "Cài claude-skills (315 skills)?") { Install-ClaudeSkills }
        if (Ask "Cài Techla custom (workflow brainstorm → plan → implement)?") { Install-Techla }
        if (Ask "Cài CLAUDE.md (4 nguyên tắc Karpathy toàn cục)?") { Install-ClaudeMd }
        Install-Hooks
    }
}

Write-Title "Hoàn tất!"
Write-Ok "Techla Kit đã cài đặt"
$count = (Get-Content $Manifest | Where-Object { $_ -ne "" }).Count
Write-Say "Manifest: $Manifest ($count mục)"
if (Test-Path $BackupDir) { Write-Say "Backup: $BackupDir" }
Write-Host ""
Write-Say "Các bước tiếp theo:"
Write-Host "  1. Mở terminal mới và chạy: claude"
Write-Host "  2. Trong Claude: /help"
Write-Host "  3. Đọc thêm: docs\HUONG-DAN-SU-DUNG.md"
Write-Host ""
