.PHONY: install uninstall backup help enable-plugin list-plugins

DOTFILES_DIR := $(shell pwd)
BACKUP_DIR := $(HOME)/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)

help:
	@echo "Dotfiles Management"
	@echo ""
	@echo "Usage:"
	@echo "  make install        Install dotfiles (creates symlinks)"
	@echo "  make install-force  Install dotfiles (overwrites existing)"
	@echo "  make uninstall      Remove symlinks"
	@echo "  make backup         Backup current dotfiles"
	@echo "  make list-plugins   List available bash plugins"
	@echo "  make enable-plugin PLUGIN=name  Enable a bash plugin"
	@echo ""

install:
	@./install.sh

install-force:
	@./install.sh --force

uninstall:
	@echo "==> Removing dotfiles symlinks..."
	@for file in .bashrc .bash_aliases .profile .vimrc .gitconfig .screenrc .my.cnf; do \
		if [ -L "$(HOME)/$$file" ]; then \
			rm "$(HOME)/$$file"; \
			echo "    ✓ Removed $$file"; \
		fi; \
	done
	@for dir in .grcat .android; do \
		if [ -L "$(HOME)/$$dir" ]; then \
			rm "$(HOME)/$$dir"; \
			echo "    ✓ Removed $$dir"; \
		fi; \
	done
	@if [ -L "$(HOME)/dotfiles/bash" ]; then \
		rm "$(HOME)/dotfiles/bash"; \
		echo "    ✓ Removed bash"; \
	fi
	@echo "==> Uninstall complete!"

backup:
	@echo "==> Backing up current dotfiles to $(BACKUP_DIR)..."
	@mkdir -p $(BACKUP_DIR)
	@for file in .bashrc .bash_aliases .profile .vimrc .gitconfig .screenrc .my.cnf .grcat .android; do \
		if [ -e "$(HOME)/$$file" ] && [ ! -L "$(HOME)/$$file" ]; then \
			cp -r "$(HOME)/$$file" $(BACKUP_DIR)/; \
			echo "    ✓ Backed up $$file"; \
		fi; \
	done
	@echo "==> Backup complete: $(BACKUP_DIR)"

list-plugins:
	@echo "Available bash plugins:"
	@ls -1 bash/available/*.bash | xargs -n1 basename
	@echo ""
	@echo "Currently enabled:"
	@if [ -d bash/enabled ]; then \
		ls -1 bash/enabled/*.bash 2>/dev/null | xargs -n1 basename || echo "  (none)"; \
	else \
		echo "  (none)"; \
	fi

enable-plugin:
	@if [ -z "$(PLUGIN)" ]; then \
		echo "Error: PLUGIN not specified"; \
		echo "Usage: make enable-plugin PLUGIN=theme.colorful.bash"; \
		exit 1; \
	fi
	@if [ ! -f "bash/available/$(PLUGIN)" ]; then \
		echo "Error: Plugin $(PLUGIN) not found"; \
		echo "Available plugins:"; \
		ls -1 bash/available/*.bash | xargs -n1 basename; \
		exit 1; \
	fi
	@mkdir -p bash/enabled
	@ln -sf ../available/$(PLUGIN) bash/enabled/$(PLUGIN)
	@echo "✓ Enabled plugin: $(PLUGIN)"
	@echo "  Reload with: source ~/.bashrc"
