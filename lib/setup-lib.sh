#!/usr/bin/env bash
# Shared setup library for dotfiles provisioning.
# Source this file from Setup.md (Runme) or .devcontainer/setup.sh.

# --- Path resolution ---
# DOTFILES_DIR can be overridden by the caller; otherwise resolve from this file's location.
# Bash exposes ${BASH_SOURCE[0]}; zsh exposes %x via prompt expansion. Use eval for the
# zsh form so bash never tries to parse zsh-only ${(...)} syntax.
if [ -z "${DOTFILES_DIR:-}" ]; then
  if [ -n "${BASH_SOURCE[0]:-}" ]; then
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  elif [ -n "${ZSH_VERSION:-}" ]; then
    eval 'DOTFILES_DIR="$(cd "$(dirname "${(%):-%x}")/.." && pwd)"'
  else
    echo "ERROR: cannot determine DOTFILES_DIR. Set DOTFILES_DIR before sourcing." >&2
    return 1 2>/dev/null || exit 1
  fi
fi

# --- Helpers ---

link_if_needed() {
  local src="$1" dest="$2"
  if [ -L "$dest" ]; then rm "$dest"
  elif [ -d "$dest" ]; then mv "$dest" "${dest}.bak"
  elif [ -f "$dest" ]; then mv "$dest" "${dest}.bak"
  fi
  ln -sf "$src" "$dest"
}

# --- Step functions (all idempotent) ---

setup_dirs() {
  mkdir -p ~/repos ~/local
  # When dotfiles repo is mounted somewhere else (e.g. /workspaces/dotfiles),
  # create a convenience symlink at ~/repos/dotfiles.
  # Skip if DOTFILES_DIR is $HOME itself (avoids recursive symlink).
  local resolved_dotfiles
  resolved_dotfiles="$(cd "$DOTFILES_DIR" && pwd -P)"
  if [ ! -e ~/repos/dotfiles ] && [ "$resolved_dotfiles" != "$(cd "$HOME" && pwd -P)" ]; then
    ln -sf "$DOTFILES_DIR" ~/repos/dotfiles
  fi
}

setup_mise() {
  if [ ! -f ~/.local/bin/mise ]; then
    curl -fsSL https://mise.run | sh || { echo "ERROR: mise installation failed" >&2; return 1; }
  fi
  eval "$(~/.local/bin/mise activate bash)"
  (
    cd "$DOTFILES_DIR"
    ~/.local/bin/mise trust --yes || { echo "ERROR: mise trust failed" >&2; exit 1; }
    ~/.local/bin/mise install --yes || { echo "ERROR: mise install failed" >&2; exit 1; }
  ) || return 1
  ~/.local/bin/mise reshim
}

setup_pnpm() {
  if [ ! -f ~/.local/bin/mise ]; then
    echo "ERROR: mise not installed. Run setup_mise first." >&2
    return 1
  fi
  # Reject packages published less than 7 days ago (supply-chain hardening)
  ~/.local/bin/mise exec -- pnpm config set minimum-release-age 7d
}

setup_prezto() {
  export ZDOTDIR="$HOME/.config/zsh"
  mkdir -p "$ZDOTDIR"
  mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/zsh"

  if [ ! -e "$ZDOTDIR/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$ZDOTDIR/.zprezto" \
      || { echo "ERROR: Prezto clone failed" >&2; return 1; }
  fi
}

setup_zsh_symlinks() {
  local zdotdir="$HOME/.config/zsh"

  # zshenv is symlinked at both $HOME (needed for the very first shell in a
  # process tree, before ZDOTDIR exists) and $zdotdir (needed for any shell
  # that inherits ZDOTDIR from its parent's environment — zsh looks for
  # .zshenv under $ZDOTDIR when it's already set, and would otherwise skip
  # it silently, e.g. for non-interactive child shells like editor/tool
  # subprocesses).
  link_if_needed "$DOTFILES_DIR/zsh.d/zshenv"    "$HOME/.zshenv"
  link_if_needed "$DOTFILES_DIR/zsh.d/zshenv"    "$zdotdir/.zshenv"

  link_if_needed "$DOTFILES_DIR/zsh.d/zlogin"    "$zdotdir/.zlogin"
  link_if_needed "$DOTFILES_DIR/zsh.d/zlogout"   "$zdotdir/.zlogout"
  link_if_needed "$DOTFILES_DIR/zsh.d/zpreztorc" "$zdotdir/.zpreztorc"
  link_if_needed "$DOTFILES_DIR/zsh.d/zprofile"  "$zdotdir/.zprofile"
  link_if_needed "$DOTFILES_DIR/zsh.d/zshrc"     "$zdotdir/.zshrc"
  link_if_needed "$DOTFILES_DIR/zsh.d/.p10k.zsh" "$zdotdir/.p10k.zsh"
}

setup_extra_configs() {
  local xdg_config="${XDG_CONFIG_HOME:-$HOME/.config}"
  local xdg_state="${XDG_STATE_HOME:-$HOME/.local/state}"

  mkdir -p "$xdg_config/peco" "$xdg_config/tmux" "$xdg_config/herdr" "$xdg_state/less"

  link_if_needed "$DOTFILES_DIR/peco/config.json"  "$xdg_config/peco/config.json"
  link_if_needed "$DOTFILES_DIR/tmux/tmux.conf"    "$xdg_config/tmux/tmux.conf"
  # herdr writes its sockets and logs into ~/.config/herdr, so symlink only
  # config.toml — never the whole directory.
  link_if_needed "$DOTFILES_DIR/herdr/config.toml" "$xdg_config/herdr/config.toml"

  # Drop legacy symlinks at $HOME so XDG paths take precedence.
  # Only symlinks are removed — never user-managed real files.
  [ -L "$HOME/.tmux.conf" ] && rm "$HOME/.tmux.conf"
  [ -L "$HOME/.peco/config.json" ] && rm "$HOME/.peco/config.json"
  [ -d "$HOME/.peco" ] && rmdir "$HOME/.peco" 2>/dev/null || true

  # Move history files into XDG_STATE_HOME (no-op if already migrated).
  if [ -f "$HOME/.lesshst" ] && [ ! -e "$xdg_state/less/history" ]; then
    mv "$HOME/.lesshst" "$xdg_state/less/history"
  fi
  if [ -f "$HOME/.node_repl_history" ] && [ ! -e "$xdg_state/node_repl_history" ]; then
    mv "$HOME/.node_repl_history" "$xdg_state/node_repl_history"
  fi
}

setup_shell() {
  if [ "$(basename "$SHELL")" != "zsh" ]; then
    if command -v chsh > /dev/null && command -v sudo > /dev/null; then
      sudo chsh -s "$(which zsh)" "$(whoami)" \
        || echo "WARNING: could not change default shell to zsh" >&2
    else
      echo "WARNING: chsh or sudo not available, skipping shell change" >&2
    fi
  fi
}

setup_claude() {
  if claude --version > /dev/null 2>&1; then
    return 0
  fi
  curl -fsSL https://claude.ai/install.sh | bash \
    || { echo "ERROR: claude installation failed" >&2; return 1; }
}

setup_git_hooks() {
  local hooks_dir="${XDG_CONFIG_HOME:-$HOME/.config}/git/hooks"
  mkdir -p "$hooks_dir"
  link_if_needed "$DOTFILES_DIR/git/hooks/pre-commit" "$hooks_dir/pre-commit"
  chmod +x "$DOTFILES_DIR/git/hooks/pre-commit"
  git config --global core.hooksPath "$hooks_dir"
}
