export TERM="xterm-256color"
export COLORTERM=truecolor

# starship intialization
eval "$(starship init zsh)"

# setup oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  asdf
  brew
	git
	gh
	docker
	npm
	pep8
	pip
	pyenv
	python
	poetry
	sudo
	zsh-autosuggestions
	zsh-syntax-highlighting
	web-search
	)

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  # Despite homebrew docs, running compinit after loading oh-my-zsh
  # seems to work, without the need to rebuild zcompdump
  #autoload -Uz compinit
  #compinit
fi

source $ZSH/oh-my-zsh.sh


if type brew &>/dev/null; then
  autoload -Uz compinit
  # Use `-u` to silence `zsh compinit: insecure directories`
  # See: https://stackoverflow.com/a/19601821/4378637
  compinit -u
fi

# poetry
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$HOME/.poetry/bin

# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/wrath/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
#
# elixir
export PATH="$PATH:/path/to/elixir/bin"

# added by Webi for pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Java
# alias java-8="sudo export JAVA_HOME=`/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home`"
# alias java-17="export JAVA_HOME=`/usr/libexec/java_home -v 17`"
# alias java-21="export JAVA_HOME=`/usr/libexec/java_home -v 21`"

# vim alias
alias vim="nvim"

# python alias
alias python="python3"

# lsd
alias ls="eza"

# docker
alias wrathDocker="systemctl --user start docker-desktop"

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# fd
alias find="fd"

# sd
alias sed="sd"

# duf
alias df="duf"

# bat
alias cat="bat"

# ripgrep
alias grep="rg"

# top
alias top="bashtop"

# tldr
alias man="tldr --theme base16"

# tre
alias tree="tre"

# gping
# alias ping="gping"

# brew fix
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'


# thefuck terminal helper
eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)


export PATH="/opt/homebrew/opt/tomcat@8/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

<<<<<<< HEAD:zshrc/.zshrc
export PATH="$PATH:/Users/wrath/.modular/bin"
eval "$(magic completion --shell zsh)"

. "$HOME/.cargo/env"
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
  fi
=======
# export ODBC SQL Server
export PATH="$PATH:/opt/mssql-tools18/bin"
>>>>>>> 2302b43 (feat:):.zshrc

fastfetch

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select


. "$HOME/.cargo/env"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
