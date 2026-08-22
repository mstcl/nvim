#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="$HOME/.config/nvim"
ARBORIST_DIR="$HOME/.local/share/nvim/site/pack/core/opt/arborist.nvim"

mkdir -p "$CONFIG_DIR/queries/git_config"
mkdir -p "$CONFIG_DIR/queries/sql"

ln -sf "$ARBORIST_DIR/queries/git_config/highlights.scm" "$CONFIG_DIR/queries/git_config/highlights.scm"
ln -sf "$ARBORIST_DIR/queries/sql/highlights.scm" "$CONFIG_DIR/queries/sql/highlights.scm"
