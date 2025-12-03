#!/usr/bin/env bash
# Dotfiles installation script
# Usage: ./install.sh [--force]

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
FORCE=false

# Parse arguments
if [[ "$1" == "--force" ]]; then
    FORCE=true
fi

# Files to symlink: source -> target
declare -A FILES=(
    [".bashrc"]="$HOME/.bashrc"
    [".bash_aliases"]="$HOME/.bash_aliases"
    [".profile"]="$HOME/.profile"
    [".vimrc"]="$HOME/.vimrc"
    [".gitconfig"]="$HOME/.gitconfig"
    [".screenrc"]="$HOME/.screenrc"
    [".my.cnf"]="$HOME/.my.cnf"
    ["starship.toml"]="$HOME/.config/starship.toml"
)

# Directories to symlink
declare -A DIRS=(
    [".grcat"]="$HOME/.grcat"
    [".android"]="$HOME/.android"
)

echo "==> Installing dotfiles from $DOTFILES_DIR"

# Backup existing files
backup_file() {
    local file="$1"
    if [[ -e "$file" && ! -L "$file" ]]; then
        mkdir -p "$BACKUP_DIR"
        echo "    Backing up $(basename "$file") to $BACKUP_DIR"
        mv "$file" "$BACKUP_DIR/"
    elif [[ -L "$file" ]]; then
        echo "    Removing old symlink $(basename "$file")"
        rm "$file"
    fi
}

# Create symlinks for files
echo ""
echo "==> Creating symlinks for dotfiles..."
for src in "${!FILES[@]}"; do
    source_file="$DOTFILES_DIR/$src"
    target_file="${FILES[$src]}"
    
    if [[ -f "$source_file" ]]; then
        # Create parent directory if it doesn't exist
        target_dir="$(dirname "$target_file")"
        mkdir -p "$target_dir"
        
        if [[ -e "$target_file" || -L "$target_file" ]]; then
            if [[ "$FORCE" == true ]]; then
                backup_file "$target_file"
            else
                echo "    Skipping $src (already exists, use --force to overwrite)"
                continue
            fi
        fi
        ln -s "$source_file" "$target_file"
        echo "    ✓ Linked $src"
    fi
done

# Create symlinks for directories
echo ""
echo "==> Creating symlinks for directories..."
for src in "${!DIRS[@]}"; do
    source_dir="$DOTFILES_DIR/$src"
    target_dir="${DIRS[$src]}"
    
    if [[ -d "$source_dir" ]]; then
        if [[ -e "$target_dir" || -L "$target_dir" ]]; then
            if [[ "$FORCE" == true ]]; then
                backup_file "$target_dir"
            else
                echo "    Skipping $src (already exists, use --force to overwrite)"
                continue
            fi
        fi
        ln -s "$source_dir" "$target_dir"
        echo "    ✓ Linked $src"
    fi
done

# Create bash enabled directory if it doesn't exist
echo ""
echo "==> Setting up bash configuration..."
mkdir -p "$DOTFILES_DIR/bash/enabled"
echo "    ✓ Created bash/enabled directory"

echo ""
echo "==> Installation complete!"
if [[ -d "$BACKUP_DIR" ]]; then
    echo "    Backups saved to: $BACKUP_DIR"
fi
echo ""
echo "To enable bash plugins, create symlinks in bash/enabled/:"
echo "    cd $DOTFILES_DIR/bash/enabled"
echo "    ln -s ../available/theme.colorful.bash ."
echo ""
echo "Reload your shell: source ~/.bashrc"
