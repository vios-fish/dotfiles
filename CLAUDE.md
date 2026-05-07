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

`.devcontainer/` is the personal multi-project base, IntelliJ/JetBrains-flavored (`customizations.vscode.*` is intentionally omitted).

- `Dockerfile` — `mcr.microsoft.com/devcontainers/base:noble` (Ubuntu 24.04) + ja_JP.UTF-8 locale + the apt packages shared with `Setup.md` Option A/B
- `devcontainer.json` — `customizations.jetbrains.{backend: "IntelliJ", plugins: [...]}`, `docker-in-docker` and `git` features, named volumes for `~/.cache/mise` / `$XDG_STATE_HOME/zsh` / `~/.claude`, `runArgs: ["--init"]`, `userEnvProbe: "loginInteractiveShell"`, and `containerEnv.DOTFILES_DIR=${containerWorkspaceFolder}` so `setup-lib.sh` resolves correctly
- `setup.sh` — `postCreateCommand` thin wrapper that sources `lib/setup-lib.sh` and runs the same setup functions as Setup.md

To reuse for another repo: copy `.devcontainer/` into the new repo and adjust (1) `name`, (2) the `dotfiles-*` named volume names, (3) `customizations.jetbrains.plugins` for that project's stack, and (4) any host bind mounts (`~/.aws`, `~/.kube`, etc.) needed for that project.

## Key Conventions

- **XDG Base Directory**: All config goes under `~/.config/`, cache under `~/.cache/`, data under `~/.local/share/`, state under `~/.local/state/`. The four `XDG_*_HOME` vars are exported from `zsh.d/zshenv`, alongside per-tool redirections (`LESSHISTFILE`, `NODE_REPL_HISTORY`, `WGETRC`, `INPUTRC`, `RIPGREP_CONFIG_PATH`).
- **Symlink pattern**: Setup creates symlinks from dotfiles repo into XDG paths via `link_if_needed()` helper. Tool-specific configs live under their own directory in the repo (`zsh.d/`, `tmux/`, `peco/`, `emacs.d/`) and are symlinked to `~/.config/<tool>/`.
- **Locale**: `ja_JP.UTF-8` throughout (LANG, LC_ALL in zshrc; locale-gen in Dockerfile)
- **pnpm is managed via mise**, not corepack or npm global install
- **GOPRIVATE**: Set to `github.com/tier4` for private Go modules
