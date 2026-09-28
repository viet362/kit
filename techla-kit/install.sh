#!/usr/bin/env bash
###############################################################################
# Techla Kit Installer (macOS / Linux)
###############################################################################
# Toolkit Claude Code tổng hợp từ SuperClaude Framework + claude-skills.
#
# Cách dùng:
#   bash install.sh                # Cài tương tác (chọn nhóm cần cài)
#   bash install.sh --yes          # Cài tất cả không hỏi
#   bash install.sh --minimal      # Chỉ cài SuperClaude (gọn nhẹ)
#   bash install.sh --full         # Cài tất cả (SuperClaude + claude-skills)
#   bash install.sh --uninstall    # Gỡ tất cả mục đã cài từ techla-kit
#   bash install.sh --export-agents --tool codex --output ./exports/codex
#   bash install.sh --install-tool codex --target-dir ~/.codex/techla-kit
#   bash install.sh --help         # Hướng dẫn
###############################################################################

set -e

# Màu sắc
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
BACKUP_DIR="$CLAUDE_HOME/.techla-backup-$(date +%Y%m%d-%H%M%S)"
MANIFEST="$CLAUDE_HOME/.techla-installed.txt"

MODE="interactive"   # interactive | yes | minimal | full | uninstall | export_agents | install_tool | list_exportables
EXPORT_TOOL="codex"
EXPORT_OUTPUT="exports/agents"
TARGET_DIR=""

###############################################################################
# UI helpers
###############################################################################
say()   { printf "%b\n" "${BLUE}ℹ️  $*${NC}"; }
ok()    { printf "%b\n" "${GREEN}✅ $*${NC}"; }
warn()  { printf "%b\n" "${YELLOW}⚠️  $*${NC}"; }
err()   { printf "%b\n" "${RED}❌ $*${NC}"; }
step()  { printf "%b\n" "${CYAN}▶ $*${NC}"; }
title() {
    printf "\n%b\n" "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    printf "%b\n"   "${BOLD}${CYAN}  $*${NC}"
    printf "%b\n"   "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

ask() {
    local prompt="$1"; local default="${2:-y}"
    case "$MODE" in
        yes|full|minimal) return 0 ;;
    esac
    [ "$default" = "y" ] && prompt="$prompt [Y/n]: " || prompt="$prompt [y/N]: "
    read -r -p "$prompt" response
    response=${response:-$default}
    [[ "$response" =~ ^[Yy]$ ]]
}

show_help() {
    cat <<EOF
${BOLD}Techla Kit Installer${NC}

Cách dùng:
  bash install.sh              Cài tương tác (chọn nhóm cần cài)
  bash install.sh --yes        Cài tất cả không hỏi
  bash install.sh --minimal    Chỉ cài SuperClaude (gọn nhẹ)
  bash install.sh --full       Cài tất cả
  bash install.sh --uninstall  Gỡ cài đặt
  bash install.sh --export-agents --tool codex --output ./exports/codex
  bash install.sh --install-tool codex --target-dir ~/.codex/techla-kit
  bash install.sh --list-exportables
  bash install.sh --help       Hiển thị trợ giúp

Script này copy skills/agents/commands từ:
  - SuperClaude Framework (engineering personas, workflow modes)
  - claude-skills (Alireza) - 315+ skills theo nhiều domain

Files cài vào: ~/.claude/{skills,agents,commands,modes,rules}/
Export agents: AGENTS.md bundle cho codex/opencode/pi
EOF
}

###############################################################################
# Parse args
###############################################################################
while [ $# -gt 0 ]; do
    case "$1" in
        --yes|-y) MODE="yes"; shift ;;
        --minimal) MODE="minimal"; shift ;;
        --full) MODE="full"; shift ;;
        --uninstall) MODE="uninstall"; shift ;;
        --export-agents) MODE="export_agents"; shift ;;
        --install-tool) MODE="install_tool"; EXPORT_TOOL="${2:-}"; shift 2 ;;
        --tool) EXPORT_TOOL="${2:-}"; shift 2 ;;
        --output) EXPORT_OUTPUT="${2:-}"; shift 2 ;;
        --target-dir) TARGET_DIR="${2:-}"; shift 2 ;;
        --list-exportables) MODE="list_exportables"; shift ;;
        --help|-h) show_help; exit 0 ;;
        *) err "Tham số không hợp lệ: $1"; show_help; exit 1 ;;
    esac
done

###############################################################################
# Pre-flight
###############################################################################
check_prerequisites() {
    step "Kiểm tra môi trường..."
    if ! command -v claude >/dev/null 2>&1; then
        warn "Chưa thấy lệnh 'claude' (Claude Code CLI)."
        say  "Cài Claude Code: https://docs.claude.com/en/docs/claude-code"
        if ! ask "Vẫn tiếp tục cài techla-kit?" "n"; then exit 1; fi
    else
        ok "Claude Code đã cài."
    fi

    [ ! -d "$CLAUDE_HOME" ] && mkdir -p "$CLAUDE_HOME"
    ok "Thư mục Claude home: $CLAUDE_HOME"
}

###############################################################################
# Tracking (manifest of installed files)
###############################################################################
track() {
    echo "$1" >> "$MANIFEST"
}

backup_if_exists() {
    local target="$1"
    if [ -e "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        local rel="${target#$CLAUDE_HOME/}"
        local backup_path="$BACKUP_DIR/$rel"
        mkdir -p "$(dirname "$backup_path")"
        cp -R "$target" "$backup_path"
    fi
}

copy_item() {
    local src="$1"; local dst="$2"
    backup_if_exists "$dst"
    cp -R "$src" "$dst"
    track "$dst"
}

###############################################################################
# Install: SuperClaude
###############################################################################
install_superclaude() {
    local sc_dir="$SCRIPT_DIR/components/superclaude"
    [ -d "$sc_dir" ] || { warn "Bỏ qua SuperClaude (không thấy components/superclaude)"; return; }

    title "Cài đặt SuperClaude Framework"

    # Agents
    if [ -d "$sc_dir/agents" ]; then
        mkdir -p "$CLAUDE_HOME/agents"
        local n=0
        for f in "$sc_dir/agents"/*.md; do
            [ -f "$f" ] || continue
            copy_item "$f" "$CLAUDE_HOME/agents/$(basename "$f")"; n=$((n+1))
        done
        ok "Đã cài $n agents từ SuperClaude"
    fi

    # Commands → vào subfolder commands/tk/ để namespace thành /tk:command-name
    # (gộp chung với Techla + claude-skills, tránh xung đột với built-in)
    # IMPORTANT: rewrite /sc: → /tk: trong NỘI DUNG file để namespace nhất quán
    if [ -d "$sc_dir/commands" ]; then
        mkdir -p "$CLAUDE_HOME/commands/tk"
        local n=0
        for f in "$sc_dir/commands"/*.md; do
            [ -f "$f" ] || continue
            local target="$CLAUDE_HOME/commands/tk/$(basename "$f")"
            backup_if_exists "$target"
            # sed replace /sc: → /tk: trong nội dung file
            sed 's|/sc:|/tk:|g' "$f" > "$target"
            track "$target"
            n=$((n+1))
        done
        ok "Đã cài $n commands từ SuperClaude (truy cập qua /tk:tên-lệnh)"
    fi

    # Modes
    if [ -d "$sc_dir/modes" ]; then
        mkdir -p "$CLAUDE_HOME/modes"
        local n=0
        for f in "$sc_dir/modes"/*.md; do
            [ -f "$f" ] || continue
            copy_item "$f" "$CLAUDE_HOME/modes/$(basename "$f")"; n=$((n+1))
        done
        ok "Đã cài $n modes từ SuperClaude"
    fi

    # Skills (each in own dir)
    if [ -d "$sc_dir/skills" ]; then
        mkdir -p "$CLAUDE_HOME/skills"
        local n=0
        for d in "$sc_dir/skills"/*/; do
            [ -d "$d" ] || continue
            local name="$(basename "$d")"
            copy_item "$d" "$CLAUDE_HOME/skills/$name"; n=$((n+1))
        done
        ok "Đã cài $n skills từ SuperClaude"
    fi

    # Core rules → ~/.claude/rules/
    if [ -d "$sc_dir/core" ]; then
        mkdir -p "$CLAUDE_HOME/rules"
        local n=0
        for f in "$sc_dir/core"/*.md; do
            [ -f "$f" ] || continue
            copy_item "$f" "$CLAUDE_HOME/rules/$(basename "$f")"; n=$((n+1))
        done
        ok "Đã cài $n rules từ SuperClaude core"
    fi
}

###############################################################################
# Install: claude-skills (Alireza)
###############################################################################
# Cấu trúc: components/claude-skills/{domain}/{plugin}/{skills|agents|commands|hooks}/...
# Plugin có thể có nested SKILL.md tại {plugin}/skills/{skill-name}/SKILL.md
install_claude_skills() {
    local cs_dir="$SCRIPT_DIR/components/claude-skills"
    [ -d "$cs_dir" ] || { warn "Bỏ qua claude-skills (không thấy components/claude-skills)"; return; }

    title "Cài đặt claude-skills (Alireza)"

    mkdir -p "$CLAUDE_HOME/skills" "$CLAUDE_HOME/agents" "$CLAUDE_HOME/commands/tk"

    local skill_count=0 agent_count=0 cmd_count=0

    # Top-level commands → /tk: namespace + rewrite /cs: → /tk: trong content
    for f in "$cs_dir/_commands"/*.md; do
        [ -f "$f" ] || continue
        local cname="$(basename "$f")"
        local target="$CLAUDE_HOME/commands/tk/$cname"
        if [ ! -f "$target" ]; then
            backup_if_exists "$target"
            sed 's|/cs:|/tk:|g' "$f" > "$target"
            echo "$target" >> "$MANIFEST"
            cmd_count=$((cmd_count+1))
        fi
    done
    if [ -d "$cs_dir/_agents" ]; then
        find "$cs_dir/_agents" -name "*.md" -type f | while read -r f; do
            local name="$(basename "$f")"
            cp "$f" "$CLAUDE_HOME/agents/$name" 2>/dev/null || true
            echo "$CLAUDE_HOME/agents/$name" >> "$MANIFEST"
        done
    fi

    # Each domain → walk plugins
    for domain_dir in "$cs_dir"/*/; do
        local domain="$(basename "$domain_dir")"
        [[ "$domain" == _* ]] && continue   # skip _commands, _agents

        for plugin_dir in "$domain_dir"*/; do
            [ -d "$plugin_dir" ] || continue
            local plugin="$(basename "$plugin_dir")"

            # Skills: {plugin}/skills/{skill-name}/SKILL.md → ~/.claude/skills/{skill-name}/
            if [ -d "$plugin_dir/skills" ]; then
                for skill_dir in "$plugin_dir/skills"/*/; do
                    [ -d "$skill_dir" ] || continue
                    local sname="$(basename "$skill_dir")"
                    local target="$CLAUDE_HOME/skills/$sname"
                    # Skip if already installed (SuperClaude wins on conflict)
                    if [ ! -d "$target" ]; then
                        cp -R "$skill_dir" "$target"
                        echo "$target" >> "$MANIFEST"
                        skill_count=$((skill_count+1))
                    fi
                done
            fi

            # Agents
            if [ -d "$plugin_dir/agents" ]; then
                for f in "$plugin_dir/agents"/*.md; do
                    [ -f "$f" ] || continue
                    local aname="$(basename "$f")"
                    local target="$CLAUDE_HOME/agents/$aname"
                    if [ ! -f "$target" ]; then
                        cp "$f" "$target"
                        echo "$target" >> "$MANIFEST"
                        agent_count=$((agent_count+1))
                    fi
                done
            fi

            # Commands → /tk: namespace + rewrite /cs: → /tk:
            if [ -d "$plugin_dir/commands" ]; then
                for f in "$plugin_dir/commands"/*.md; do
                    [ -f "$f" ] || continue
                    local cname="$(basename "$f")"
                    local target="$CLAUDE_HOME/commands/tk/$cname"
                    if [ ! -f "$target" ]; then
                        sed 's|/cs:|/tk:|g' "$f" > "$target"
                        echo "$target" >> "$MANIFEST"
                        cmd_count=$((cmd_count+1))
                    fi
                done
            fi
        done
    done

    ok "claude-skills: $skill_count skills, $agent_count agents, $cmd_count commands"
}

###############################################################################
# Install Techla custom (commands + skills riêng của Techla Kit)
###############################################################################
install_techla() {
    local t_dir="$SCRIPT_DIR/components/techla"
    [ -d "$t_dir" ] || { warn "Bỏ qua Techla custom (không thấy components/techla)"; return; }

    title "Cài đặt Techla custom (workflow brainstorm → plan → implement)"

    # Commands → subfolder commands/tk/ → namespace /tk:cmd
    if [ -d "$t_dir/commands" ]; then
        mkdir -p "$CLAUDE_HOME/commands/tk"
        local n=0
        for f in "$t_dir/commands"/*.md; do
            [ -f "$f" ] || continue
            copy_item "$f" "$CLAUDE_HOME/commands/tk/$(basename "$f")"; n=$((n+1))
        done
        ok "Đã cài $n commands Techla (gọi qua /tk:tên-lệnh)"
    fi

    # Skills → flat
    if [ -d "$t_dir/skills" ]; then
        mkdir -p "$CLAUDE_HOME/skills"
        local n=0
        for d in "$t_dir/skills"/*/; do
            [ -d "$d" ] || continue
            local name="$(basename "$d")"
            copy_item "$d" "$CLAUDE_HOME/skills/$name"; n=$((n+1))
        done
        ok "Đã cài $n skills Techla"
    fi

    # Rules → ~/.claude/rules/ (workflow guides reference từ CLAUDE.md)
    if [ -d "$t_dir/rules" ]; then
        mkdir -p "$CLAUDE_HOME/rules"
        local n=0
        for f in "$t_dir/rules"/*.md; do
            [ -f "$f" ] || continue
            copy_item "$f" "$CLAUDE_HOME/rules/$(basename "$f")"; n=$((n+1))
        done
        ok "Đã cài $n workflow rules Techla"
    fi
}

###############################################################################
# Install CLAUDE.md (global behavioral guidelines)
###############################################################################
install_claude_md() {
    local src="$SCRIPT_DIR/CLAUDE.md"
    [ -f "$src" ] || return

    local dst="$CLAUDE_HOME/CLAUDE.md"
    backup_if_exists "$dst"
    cp "$src" "$dst"
    track "$dst"
    ok "Đã cài CLAUDE.md vào $dst (toàn cục)"
}

###############################################################################
# Install hooks
###############################################################################
install_hooks() {
    local src="$SCRIPT_DIR/components/superclaude/hooks/hooks.json"
    [ -f "$src" ] || return

    if ! ask "Cài hooks (auto-verify code sau Write/Edit)?"; then return; fi

    local settings="$CLAUDE_HOME/settings.json"
    if [ -f "$settings" ]; then
        backup_if_exists "$settings"
        cp "$src" "$CLAUDE_HOME/techla-hooks.json"
        warn "settings.json đã tồn tại → hooks lưu ở $CLAUDE_HOME/techla-hooks.json"
        warn "Bạn cần tự merge (xem docs/HUONG-DAN-SU-DUNG.md)"
    else
        cp "$src" "$settings"
        ok "Đã tạo settings.json với hooks của techla-kit"
    fi
    track "$CLAUDE_HOME/techla-hooks.json"
}


###############################################################################
# Export agents to Codex/OpenCode/Pi
###############################################################################
run_agent_export() {
    local exporter="$SCRIPT_DIR/scripts/export-agents.py"
    [ -f "$exporter" ] || { err "Không thấy $exporter"; exit 1; }
    python3 "$exporter" --tool "$EXPORT_TOOL" --output "$EXPORT_OUTPUT" --clean
}

install_exported_tool() {
    [ -n "$TARGET_DIR" ] || { err "Cần --target-dir khi dùng --install-tool"; exit 1; }
    local tmp_dir="${TMPDIR:-/tmp}/techla-agent-export-$EXPORT_TOOL-$$"
    EXPORT_OUTPUT="$tmp_dir"
    run_agent_export
    mkdir -p "$TARGET_DIR"
    cp -R "$tmp_dir"/. "$TARGET_DIR"/
    ok "Đã migrate $EXPORT_TOOL bundle vào $TARGET_DIR"
}

###############################################################################
# Uninstall
###############################################################################
uninstall_all() {
    title "Gỡ Techla Kit"
    if [ ! -f "$MANIFEST" ]; then
        err "Không tìm thấy manifest $MANIFEST. Có thể chưa cài bằng installer này."
        exit 1
    fi
    if ! ask "Chắc chắn gỡ tất cả $(wc -l < "$MANIFEST" | tr -d ' ') mục?" "n"; then
        say "Đã hủy"; exit 0
    fi

    local n=0
    while IFS= read -r path; do
        [ -z "$path" ] && continue
        if [ -e "$path" ]; then
            rm -rf "$path"
            n=$((n+1))
        fi
    done < "$MANIFEST"

    mv "$MANIFEST" "$MANIFEST.removed-$(date +%Y%m%d-%H%M%S)"
    ok "Đã gỡ $n mục"
}

###############################################################################
# Interactive menu
###############################################################################
interactive_menu() {
    title "Chọn nhóm muốn cài"
    echo "  1) Minimal  → Chỉ SuperClaude (~50 mục, gọn nhẹ)"
    echo "  2) Full     → Tất cả (SuperClaude + claude-skills, 400+ mục)"
    echo "  3) Custom   → Chọn từng nhóm"
    echo
    read -r -p "Lựa chọn [1/2/3]: " choice
    case "$choice" in
        1) MODE="minimal" ;;
        2) MODE="full" ;;
        3) MODE="custom" ;;
        *) err "Lựa chọn không hợp lệ"; exit 1 ;;
    esac
}

###############################################################################
# Main
###############################################################################
main() {
    title "Techla Kit Installer"
    say "Phiên bản 1.0.0 - Toolkit Claude Code tổng hợp"
    echo

    if [ "$MODE" = "list_exportables" ]; then
        python3 "$SCRIPT_DIR/scripts/export-agents.py" --list-exportables
        exit 0
    fi

    if [ "$MODE" = "export_agents" ]; then
        run_agent_export
        exit 0
    fi

    if [ "$MODE" = "install_tool" ]; then
        install_exported_tool
        exit 0
    fi

    check_prerequisites

    if [ "$MODE" = "uninstall" ]; then
        uninstall_all
        exit 0
    fi

    [ "$MODE" = "interactive" ] && interactive_menu

    # Khởi tạo manifest mới
    > "$MANIFEST"

    case "$MODE" in
        minimal)
            install_superclaude
            install_techla
            install_claude_md
            install_hooks
            ;;
        full|yes)
            install_superclaude
            install_claude_skills
            install_techla
            install_claude_md
            install_hooks
            ;;
        custom)
            ask "Cài SuperClaude (engineering personas + commands)?" && install_superclaude
            ask "Cài claude-skills (315 skills theo domain)?" && install_claude_skills
            ask "Cài Techla custom (workflow brainstorm → plan → implement)?" && install_techla
            ask "Cài CLAUDE.md (4 nguyên tắc Karpathy toàn cục)?" && install_claude_md
            install_hooks
            ;;
    esac

    title "Hoàn tất!"
    ok "Techla Kit đã được cài đặt"
    say "Manifest cài đặt: $MANIFEST ($(wc -l < "$MANIFEST" | tr -d ' ') mục)"
    [ -d "$BACKUP_DIR" ] && say "Backup file cũ: $BACKUP_DIR"
    echo
    say "Các bước tiếp theo:"
    echo "  1. Mở terminal mới và chạy: claude"
    echo "  2. Trong Claude, gõ: /help để xem tất cả lệnh"
    echo "  3. Đọc thêm: docs/HUONG-DAN-SU-DUNG.md"
    echo
}

main "$@"
