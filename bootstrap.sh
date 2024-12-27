#!/usr/bin/env bash

DOTFILES_DIR="$(pwd)"

# Store pairs in a regular array in "SRC|DEST" format
SYMLINK_PAIRS=(
  "$DOTFILES_DIR/nvim|$HOME/.config/nvim.iferdel.git"
)

for PAIR in "${SYMLINK_PAIRS[@]}"; do
    SRC="${PAIR%%|*}"
    DEST="${PAIR##*|}"

    # Debugging output
    echo "SRC:  $SRC"
    echo "DEST: $DEST"

    if [ ! -e "$SRC" ]; then
        echo "Error: Source '$SRC' does not exist. Skipping..."
        continue
    fi

    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        echo "Warning: Destination '$DEST' already exists. Skipping..."
        continue
    fi

    ln -s "$SRC" "$DEST"
    echo "Linked '$SRC' -> '$DEST'"
done

echo "Dotfiles symlink setup completed"

