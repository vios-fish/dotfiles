#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib/setup-lib.sh"

setup_dirs
setup_mise
setup_pnpm
setup_prezto
setup_zsh_symlinks
setup_extra_configs
setup_shell
setup_claude
setup_git_hooks

echo "=== devcontainer setup complete ==="
