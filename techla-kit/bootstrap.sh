#!/usr/bin/env bash
###############################################################################
# Techla Kit - One-line bootstrap installer (macOS / Linux)
###############################################################################
# Cách dùng:
#   curl -fsSL https://raw.githubusercontent.com/techlaaidev/techla-kit/main/bootstrap.sh | bash
#
# Tùy chọn (chạy với env vars):
#   TK_DIR=~/dev/techla-kit bash bootstrap.sh    # Đổi nơi clone repo
#   TK_MODE=minimal bash bootstrap.sh            # Cài minimal thay vì full
#   TK_BRANCH=dev bash bootstrap.sh              # Clone branch khác
###############################################################################

set -e

REPO_URL="${TK_REPO:-https://github.com/techlaaidev/techla-kit.git}"
INSTALL_DIR="${TK_DIR:-$HOME/.techla-kit}"
BRANCH="${TK_BRANCH:-main}"
MODE="${TK_MODE:-full}"   # full | minimal

# Màu
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

say()  { printf "%b\n" "${BLUE}ℹ️  $*${NC}"; }
ok()   { printf "%b\n" "${GREEN}✅ $*${NC}"; }
warn() { printf "%b\n" "${YELLOW}⚠️  $*${NC}"; }
step() { printf "%b\n" "${CYAN}▶ $*${NC}"; }

cat <<EOF
${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
${BOLD}${CYAN}  Techla Kit - One-line Bootstrap${NC}
${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}

Repo:   $REPO_URL
Branch: $BRANCH
Đến:    $INSTALL_DIR
Mode:   $MODE

EOF

# 1. Check git
if ! command -v git >/dev/null 2>&1; then
    warn "Chưa thấy git. Cần cài git trước."
    say "macOS:  brew install git    (hoặc xcode-select --install)"
    say "Linux:  sudo apt install git   /  sudo yum install git"
    exit 1
fi
ok "git có sẵn"

# 2. Clone hoặc pull
if [ -d "$INSTALL_DIR/.git" ]; then
    step "Repo đã tồn tại → cập nhật (git pull)..."
    cd "$INSTALL_DIR"
    git fetch origin "$BRANCH"
    git checkout "$BRANCH"
    git pull origin "$BRANCH"
    ok "Đã cập nhật repo"
else
    if [ -d "$INSTALL_DIR" ]; then
        warn "$INSTALL_DIR đã tồn tại nhưng không phải git repo → backup."
        mv "$INSTALL_DIR" "${INSTALL_DIR}.bak-$(date +%Y%m%d-%H%M%S)"
    fi
    step "Cloning repo..."
    git clone --depth=1 --branch="$BRANCH" "$REPO_URL" "$INSTALL_DIR"
    ok "Đã clone xong"
fi

# 3. Chạy installer
step "Chạy installer ($MODE mode)..."
cd "$INSTALL_DIR"
chmod +x install.sh 2>/dev/null || true

case "$MODE" in
    minimal) bash install.sh --minimal ;;
    full)    bash install.sh --full ;;
    *)       bash install.sh ;;
esac

cat <<EOF

${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
${GREEN}🎉 Hoàn tất bootstrap Techla Kit${NC}
${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}

Repo lưu tại: $INSTALL_DIR

${BOLD}Lần sau muốn cập nhật:${NC}
  cd $INSTALL_DIR
  git pull
  bash install.sh --$MODE

${BOLD}Mở Claude Code:${NC}
  claude

EOF
