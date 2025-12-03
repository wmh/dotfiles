# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"
gvm use go1.25.5
export GOPATH=/home/$USER/workspaces/go
export LANGUAGE="en_US.UTF-8"
export PATH=/home/$USER/workspaces/go/bin:$PATH

# Fix GVM's broken cd function
function cd() {
    builtin cd "$@" || return $?
    
    # GVM auto-switching for .go-version files
    if type __gvmp_find_closest_dot_go_version &>/dev/null; then
        local dot_go_version="$(__gvmp_find_closest_dot_go_version 2>/dev/null)"
        if [[ $? -eq 0 && -n "${dot_go_version}" ]]; then
            local use_goversion="$(__gvmp_read_dot_go_version "${dot_go_version}" 2>/dev/null)"
            [[ -n "${use_goversion}" ]] && gvm use "${use_goversion}" &>/dev/null
        fi
        
        local dot_go_pkgset="$(__gvmp_find_closest_dot_go_pkgset 2>/dev/null)"
        if [[ $? -eq 0 && -n "${dot_go_pkgset}" ]]; then
            local use_gopkgset="$(__gvmp_read_dot_go_pkgset "${dot_go_pkgset}" 2>/dev/null)"
            [[ -n "${use_gopkgset}" ]] && gvm pkgset use "${use_gopkgset}" &>/dev/null
        fi
    fi
    
    return 0
}

