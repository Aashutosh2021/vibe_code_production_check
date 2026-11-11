#!/usr/bin/env bash
set -e

# 107-Point Production Readiness Audit Skill Installer
# Compatible with Claude Code, Antigravity, Cursor, Windsurf, and Codex

TARGET="${1:-all}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🛡️ Installing 107-Point Production Audit Skill..."

install_claude() {
  echo "Installing for Claude Code..."
  mkdir -p "$HOME/.claude/commands"
  cp "$REPO_DIR/.claude/commands/audit.md" "$HOME/.claude/commands/audit.md"
  
  if [ -d ".claude" ]; then
    mkdir -p ".claude/commands"
    cp "$REPO_DIR/.claude/commands/audit.md" ".claude/commands/audit.md"
    echo "  -> Linked to project .claude/commands/audit.md"
  fi
  echo "  ✓ Claude Code installed (/audit command ready)"
}

install_antigravity() {
  echo "Installing for Antigravity..."
  mkdir -p "$HOME/.gemini/antigravity/skills/production-audit"
  cp "$REPO_DIR/SKILL.md" "$HOME/.gemini/antigravity/skills/production-audit/SKILL.md"
  
  if [ -d ".agent" ]; then
    mkdir -p ".agent/skills/production-audit"
    cp "$REPO_DIR/SKILL.md" ".agent/skills/production-audit/SKILL.md"
    echo "  -> Linked to project .agent/skills/production-audit/SKILL.md"
  fi
  echo "  ✓ Antigravity installed"
}

install_cursor() {
  echo "Installing for Cursor / Windsurf..."
  cp "$REPO_DIR/rules/.cursorrules" "./.cursorrules" 2>/dev/null || true
  echo "  ✓ .cursorrules added to current project"
}

install_codex() {
  echo "Installing for Codex..."
  mkdir -p "$HOME/.codex/skills/production-audit"
  cp "$REPO_DIR/SKILL.md" "$HOME/.codex/skills/production-audit/SKILL.md"
  
  if [ -d ".codex" ]; then
    mkdir -p ".codex/skills/production-audit"
    cp "$REPO_DIR/SKILL.md" ".codex/skills/production-audit/SKILL.md"
    echo "  -> Linked to project .codex/skills/production-audit/SKILL.md"
  fi
  echo "  ✓ Codex installed"
}

case "$TARGET" in
  claude)
    install_claude
    ;;
  antigravity)
    install_antigravity
    ;;
  cursor)
    install_cursor
    ;;
  codex)
    install_codex
    ;;
  all)
    install_claude
    install_antigravity
    install_cursor
    install_codex
    ;;
  *)
    echo "Usage: ./install.sh [all|claude|antigravity|cursor|codex]"
    exit 1
    ;;
esac

echo ""
echo "🎉 107-Point Audit Skill installed successfully!"
echo "👉 Run in Claude Code: /audit"
echo "👉 Run in Antigravity / Codex: 'Run full 107-point production audit'"
echo "👉 Run in Cursor / Windsurf: '@workspace Audit project for production readiness'"
