# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles repository (`vios-fish/dotfiles`) managing development environment configuration across local Ubuntu, WSL, and devcontainer environments. Uses [Runme](https://runme.dev/) + [mise](https://mise.jdx.dev/) for setup.

## Setup Architecture

共通セットアップロジックは `lib/setup-lib.sh` に集約されている。2つのエントリポイントがこのライブラリをsourceして使う:

- **Local**: `Setup.md` — Runme interactive runbook。各ブロックが `lib/setup-lib.sh` の関数を呼ぶ
- **Devcontainer**: `.devcontainer/setup.sh` — `postCreateCommand` から実行される薄いラッパー

新しいセットアップステップを追加する場合: `lib/setup-lib.sh` に関数を定義し、両方のエントリポイントから呼ぶ。

## Architecture

### Zsh Initialization Chain

```
~/.zshenv (zsh.d/zshenv)     — sets XDG vars, pivots ZDOTDIR to ~/.config/zsh
  → .zprofile (zsh.d/zprofile)  — EDITOR, VISUAL, PAGER, path arrays
  → .zshrc (zsh.d/zshrc)        — main config: paths, Prezto, mise, aliases, integrations
  → .p10k.zsh (zsh.d/.p10k.zsh) — Powerlevel10k theme (loaded last)
```

All zsh files live in `zsh.d/` and are symlinked to `~/.config/zsh/` (XDG-compliant). The only file placed in `$HOME` is `.zshenv`.

### Toolchain Management

`mise.toml` declares all language runtimes and CLI tools. Mise is activated in zshrc (`mise activate zsh`). Peco is pinned to 0.5.11 due to a broken 0.6.0 installer.

### Emacs Configuration

`emacs.d/` uses init-loader for modular config files (`init_loader/00-base.el` through `99-keybind.el`). Entry point is `init.el` → `common.el` (use-package, init-loader setup) → `setup.el` (package management). Includes DDSKK for Japanese input.

### Devcontainer

`.devcontainer/devcontainer.json` uses Ubuntu 24.04 base with Docker-in-Docker and Claude Code features. Mounts mise cache and zsh history as Docker volumes for persistence. AWS credentials are bind-mounted read-only.

## Key Conventions

- **XDG Base Directory**: All config goes under `~/.config/`, cache under `~/.cache/`, data under `~/.local/share/`
- **Symlink pattern**: Setup creates symlinks from dotfiles repo into XDG paths via `link_if_needed()` helper
- **Locale**: `ja_JP.UTF-8` throughout (LANG, LC_ALL in zshrc; locale-gen in Dockerfile)
- **pnpm is managed via mise**, not corepack or npm global install
- **GOPRIVATE**: Set to `github.com/tier4` for private Go modules
