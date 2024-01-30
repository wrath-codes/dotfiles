
eval starship init

# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"


plugins=(
	git
	colored-man-pages
	command-not-found
	docker
	npm
	pep8
	pip
	pyenv
	python
  poetry
	sudo
	systemd
	ubuntu
	zsh-autosuggestions
	zsh-syntax-highlighting
	)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


export MANPATH="/usr/local/man:$MANPATH"


# starship intialization
eval "$(starship init zsh)"

# vim alias
alias vim="nvim"

# wrath drive aliases
alias wraths="cd /media/wrath/wrath/"
alias downloads="cd /media/wrath/wrath/Downloads/"
alias projects="cd /media/wrath/wrath/projects/"
alias pucD="cd /media/wrath/wrath/puc-rio/"

#pip alias
alias pip="pipx"

# python alias
alias python="python3"

# poetry
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$HOME/.poetry/bin

# lsd
alias ls="lsd"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# docker
alias wrathDocker="systemctl --user start docker-desktop"

# TERM
export TERM="alacritty"

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# fdfind
alias find="fdfind"

# bat
alias cat="bat"

# ripgrep
alias grep="rg"

# bashtop
alias top="bashtop"

# apt
alias apt="nala"

neofetch

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

