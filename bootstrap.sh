#!/usr/bin/env bash

#####################################################################
# 1. Symlink Setup
#####################################################################

DOTFILES_DIR="$(pwd)"

# Store pairs in a regular array in "SRC|DEST" format
SYMLINK_PAIRS=(
  "$DOTFILES_DIR/nvim|$HOME/.config/nvim.iferdel.git"
  "$DOTFILES_DIR/git/.gitconfig|$HOME/.gitconfig"
)

for PAIR in "${SYMLINK_PAIRS[@]}"; do
    SRC="${PAIR%%|*}"
    DEST="${PAIR##*|}"
    DEST_DIR="$(dirname "$DEST")"

    if [ ! -d "$DEST_DIR" ]; then
        echo "Creating directory: $DEST_DIR"
        mkdir -p "$DEST_DIR"
    fi

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

#####################################################################
# 2. Copy Aliases from Dotfiles to Home Aliases File
#####################################################################

DOTFILES_ALIASES="$DOTFILES_DIR/bash/aliases"
HOME_ALIASES="$HOME/.bash_aliases"

# Ensure the dotfiles' aliases file exists
if [ ! -f "$DOTFILES_ALIASES" ]; then
    echo "Dotfiles aliases file ($DOTFILES_ALIASES) does not exist. Exiting..."
    exit 1
fi

# Check if the files are different before copying
if [ ! -f "$HOME_ALIASES" ] || ! cmp -s "$DOTFILES_ALIASES" "$HOME_ALIASES"; then
    echo "Copying aliases from $DOTFILES_ALIASES to $HOME_ALIASES..."
    cp "$DOTFILES_ALIASES" "$HOME_ALIASES"
    echo "Aliases file updated."
else
    echo "Aliases file is already up to date."
fi

#####################################################################
# 2b. Copy PostgreSQL Config (.psqlrc)
#####################################################################

DOTFILES_PSQLRC="$DOTFILES_DIR/psql/.psqlrc"
HOME_PSQLRC="$HOME/.psqlrc"

# Only copy if the source file exists
if [ -f "$DOTFILES_PSQLRC" ]; then
    # Check if the files are different before copying
    if [ ! -f "$HOME_PSQLRC" ] || ! cmp -s "$DOTFILES_PSQLRC" "$HOME_PSQLRC"; then
        echo "Copying .psqlrc from $DOTFILES_PSQLRC to $HOME_PSQLRC..."
        cp "$DOTFILES_PSQLRC" "$HOME_PSQLRC"
        echo "PostgreSQL config (.psqlrc) updated."
    else
        echo "PostgreSQL config (.psqlrc) is already up to date."
    fi
else
    echo "PostgreSQL config file ($DOTFILES_PSQLRC) not found. Skipping..."
fi

#####################################################################
# 3. Append Logic to the Appropriate Shell Config
#####################################################################

# The line that should go in the shell config
SOURCE_BASH_ALIASES='if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi'

# If we're on macOS, use ~/.zshrc
if [[ "$OSTYPE" == "darwin"* ]]; then
    TARGET_SHELLRC="$HOME/.zshrc"
    # Create ~/.zshrc if it doesn't exist
    if [ ! -f "$TARGET_SHELLRC" ]; then
        echo "Creating $TARGET_SHELLRC..."
        touch "$TARGET_SHELLRC"
    fi
    # Check if the line is already present
    if ! grep -Fxq "$SOURCE_BASH_ALIASES" "$TARGET_SHELLRC"; then
        echo "Appending source logic for .bash_aliases to $TARGET_SHELLRC..."
        echo -e "\n$SOURCE_BASH_ALIASES" >> "$TARGET_SHELLRC"
        echo "Done. Reload or source $TARGET_SHELLRC to apply changes."
    else
        echo "Source logic for .bash_aliases is already present in $TARGET_SHELLRC."
    fi

# Otherwise, if we're on WSL2, use ~/.bashrc
elif grep -qi 'microsoft' /proc/version; then
    TARGET_SHELLRC="$HOME/.bashrc"
    # Create ~/.bashrc if it doesn't exist
    if [ ! -f "$TARGET_SHELLRC" ]; then
        echo "Creating $TARGET_SHELLRC..."
        touch "$TARGET_SHELLRC"
    fi
    if ! grep -Fxq "$SOURCE_BASH_ALIASES" "$TARGET_SHELLRC"; then
        echo "Detected WSL2. Appending source logic for .bash_aliases to $TARGET_SHELLRC..."
        echo -e "\n$SOURCE_BASH_ALIASES" >> "$TARGET_SHELLRC"
        echo "Done. Reload or source $TARGET_SHELLRC to apply changes."
    else
        echo "Source logic for .bash_aliases is already present in $TARGET_SHELLRC."
    fi

else
    echo "Not running on macOS or WSL2. No action taken."
fi

#####################################################################
# 4. Set up `nvimf` wrapper and make it the default Git editor
#####################################################################

NVIMF_WRAPPER="$HOME/bin/nvimf"
NVIMF_COMMAND='NVIM_APPNAME=nvim.iferdel.git nvim'

# Create ~/bin if it doesn't exist
if [ ! -d "$HOME/bin" ]; then
    echo "Creating $HOME/bin..."
    mkdir -p "$HOME/bin"
fi

# Create or overwrite the nvimf wrapper
echo "#!/usr/bin/env bash" > "$NVIMF_WRAPPER"
echo "$NVIMF_COMMAND \"\$@\"" >> "$NVIMF_WRAPPER"
chmod +x "$NVIMF_WRAPPER"
echo "Wrapper created at $NVIMF_WRAPPER"

# Add ~/bin to PATH in shell config if not already
if [[ "$OSTYPE" == "darwin"* ]]; then
    SHELLRC="$HOME/.zshrc"
else
    SHELLRC="$HOME/.bashrc"
fi

if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$SHELLRC"; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$SHELLRC"
    echo "Added ~/bin to PATH in $SHELLRC"
fi

# Set Git to use nvimf as core.editor (full path)
if git config --global core.editor &>/dev/null; then
    echo "Git core.editor is already set. Skipping..."
else
    git config --global core.editor "$NVIMF_WRAPPER"
    echo "Set Git core.editor to $NVIMF_WRAPPER"
fi

#####################################################################
# 5. Completed setup
#####################################################################

echo "Dotfiles symlink setup completed!"
