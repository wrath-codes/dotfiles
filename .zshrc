export TERM="xterm-256color"
export COLORTERM=truecolor

# starship intialization
eval "$(starship init zsh)"

# setup oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  asdf
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

source $ZSH/oh-my-zsh.sh


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
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Java
alias java-8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_231`"
alias java-17="export JAVA_HOME=`/usr/libexec/java_home -v 17`"
alias java-21="export JAVA_HOME=`/usr/libexec/java_home -v 21`"

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

# bat
alias cat="bat"

# ripgrep
alias grep="rg"

neofetch

