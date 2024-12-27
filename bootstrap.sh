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

DOTFILES_ALIASES="$HOME/.dotfiles/bash/aliases"
SOURCE_BASH_ALIASES='if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi'

# Ensure the source file exists
if [ ! -f "$DOTFILES_ALIASES" ]; then
    echo "Dotfiles aliases file ($DOTFILES_ALIASES) does not exist. Exiting..."
    exit 1
fi

# Ensure the destination file exists (create it if it doesn't)
if [ ! -f "$SOURCE_BASH_ALIASES" ]; then
    echo "Home aliases file ($SOURCE_BASH_ALIASES) does not exist. Creating it..."
    touch "$SOURCE_BASH_ALIASES"
fi

# Check if content is already present
MISSING_LINES=0
while IFS= read -r LINE; do
    if ! grep -Fxq "$LINE" "$SOURCE_BASH_ALIASES"; then
        echo "$LINE" >> "$SOURCE_BASH_ALIASES"
        ((MISSING_LINES++))
    fi
done < "$DOTFILES_ALIASES"

if [ $MISSING_LINES -eq 0 ]; then
    echo "All aliases from dotfiles are already in the home aliases file."
else
    echo "Added $MISSING_LINES missing alias(es) to $SOURCE_BASH_ALIASES."
fi

# Check if the operating system is macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    ZSHRC_FILE="$HOME/.zshrc"

    # Check if the line is already present
    if ! grep -Fxq "$SOURCE_BASH_ALIASES" "$ZSHRC_FILE"; then
        echo "Appending source logic for .bash_aliases to $ZSHRC_FILE..."
        # Append the source logic
        echo -e "\n$SOURCE_BASH_ALIASES" >> "$ZSHRC_FILE"
        echo "Done. Reload .zshrc to apply changes."
    else
        echo "Source logic for .bash_aliases is already present in $ZSHRC_FILE."
    fi
else
    echo "This script is designed for macOS. No changes made."
fi

echo "Dotfiles symlink setup completed"

