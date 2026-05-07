#!/usr/bin/env bash
# Patch JetBrains IDE .desktop launchers so that BUILDX_BUILDER=default
# is set when the IDE is started from a desktop shortcut.
#
# Why: IntelliJ's devcontainer build runs the final image-merge step on
# whichever buildx builder is currently active. When that builder uses
# the docker-container driver, BuildKit runs in an isolated container
# and cannot read images from the local Docker engine store, so the
# merge fails with `pull access denied` for jb-*-uid:latest et al.
# Forcing BUILDX_BUILDER=default routes IntelliJ's buildx calls through
# the docker-driver builder, which shares the local image store.
#
# Idempotent. Re-run after a JetBrains Toolbox update if it regenerates
# the .desktop files and drops the env prefix.

set -euo pipefail

APPS_DIR="${APPS_DIR:-$HOME/.local/share/applications}"

cd "$APPS_DIR"

shopt -s nullglob
files=(
  jetbrains-goland-*.desktop
  jetbrains-idea-*.desktop
  jetbrains-pycharm-*.desktop
  jetbrains-rustrover-*.desktop
  jetbrains-webstorm-*.desktop
)

if [ ${#files[@]} -eq 0 ]; then
  echo "no JetBrains IDE .desktop files found in $APPS_DIR" >&2
  exit 1
fi

for f in "${files[@]}"; do
  if grep -q '^Exec=env BUILDX_BUILDER=default ' "$f"; then
    echo "[skip] $f (already patched)"
    continue
  fi
  if ! grep -q '^Exec="[^"]*" %u$' "$f"; then
    echo "[warn] $f: Exec line does not match expected pattern; skipping" >&2
    continue
  fi
  sed -i.bak 's|^Exec="\(.*\)" %u$|Exec=env BUILDX_BUILDER=default "\1" %u|' "$f"
  echo "[done] $f"
  diff -u "$f.bak" "$f" | sed 's/^/    /'
done

echo
echo "Restart any running JetBrains IDEs and relaunch from the desktop shortcut."
