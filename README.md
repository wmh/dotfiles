# dotfiles

My dotfiles. Join the [dotfiles community](http://dotfiles.github.io/) and create your own.

## Installation

### Quick Install
```bash
./install.sh
```

Use `--force` to overwrite existing files:
```bash
./install.sh --force
```

### Using Make
```bash
# Show available commands
make help

# Install dotfiles
make install

# Force install (overwrites existing)
make install-force

# List available bash plugins
make list-plugins

# Enable a bash plugin
make enable-plugin PLUGIN=theme.colorful.bash

# Backup current dotfiles
make backup

# Uninstall
make uninstall
```

## Bash Plugins

Plugins are stored in `bash/available/` and can be enabled by symlinking to `bash/enabled/`:

```bash
cd bash/enabled
ln -s ../available/theme.colorful.bash .
```

Or use make:
```bash
make enable-plugin PLUGIN=theme.colorful.bash
```

## What's Included

- **Bash**: Custom prompt, history settings, aliases
- **Git**: Useful aliases and configurations
- **Vim**: Basic vim configuration
- **Screen**: Screen configuration
- **Java/Go/Android**: Environment setup scripts (enable as needed)
