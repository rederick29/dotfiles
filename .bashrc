# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.

# XDG Base Directory setup
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME

# Fix a bunch of programs not using XDG by default :(
GNUPGHOME=$XDG_DATA_HOME/gnupg
PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
PYTHONUSERBASE=$XDG_DATA_HOME/python
WINEPREFIX=$XDG_DATA_HOME/wine-prefixes/default
RUSTUP_HOME=$XDG_DATA_HOME/rust/rustup
CARGO_HOME=$XDG_DATA_HOME/rust/cargo
export GNUPGHOME PYTHONPYCACHEPREFIX PYTHONUSERBASE WINEPREFIX RUSTUP_HOME CARGO_HOME
. "/home/erickv/.local/share/rust/cargo/env"

export EDITOR=nvim
export PATH=$PATH:/home/erickv/.local/share/JetBrains/Toolbox/scripts
