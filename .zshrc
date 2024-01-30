export COLORTERM=truecolor

# starship intialization
eval "$(starship init zsh)"

# setup oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

plugins=(
	git
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

# vim alias
alias vim="nvim"

# python alias
alias python="python3"

# lsd
alias ls="lsd"

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

# poetry
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$HOME/.poetry/bin

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

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
