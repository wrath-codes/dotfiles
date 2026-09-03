
export COLORTERM=truecolor

# starship intialization
eval "$(starship init zsh)"

# setup oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
typeset -U FPATH fpath

plugins=(
  asdf
  uv
  macos
  thefuck
  aliases
  alias-finder
  gitignore
  brew
	git
  encode64
  vscode
  history
  gh
	docker
	npm
	pep8
	pip
	python
	sudo
  zoxide
	zsh-autosuggestions
	zsh-syntax-highlighting
	web-search
	)


export PATH="/home/wrath/bin:$PATH"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Docker CLI completions must be on fpath before Oh My Zsh runs compinit.
fpath=("$HOME/.docker/completions" $fpath)

source $ZSH/oh-my-zsh.sh

# Uppercase shortcut for the alias loaded by the thefuck plugin.
FUCK() {
  fuck "$@"
}

# Local user-installed tools
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="/home/wrath/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# elixir
export PATH="$PATH:/path/to/elixir/bin"

# Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

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
alias cd="z"

# fd
alias find="fd"

# sd
# alias sed="sd"

# duf
alias df="duf"

# bat
# alias cat="bat"

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

# Upgrade Homebrew packages, including auto-updating casks such as Spotify.
brewup() {
  brew update &&
    brew upgrade --formula &&
    brew upgrade --cask --greedy-auto-updates || return

  local spotify_app="/Applications/Spotify.app"
  if [[ -d "$spotify_app" ]] &&
    codesign --verify --deep --strict "$spotify_app" &&
    spctl --assess --type execute "$spotify_app"; then
    xattr -dr com.apple.quarantine "$spotify_app"
  fi

  if (( $+commands[xcodes] )); then
    xcodes update || return

    local selected_xcode latest_xcode
    selected_xcode=$(xcodebuild -version | awk 'NR == 1 { print $2 }')
    latest_xcode=$(xcodes list | awk '$2 ~ /^\(/ { latest = $1 } END { print latest }')

    if [[ -n "$latest_xcode" && "$selected_xcode" != "$latest_xcode" ]]; then
      print "Xcode $latest_xcode is available (selected: $selected_xcode)."
      print "Install it with: xcodes install $latest_xcode --select"
    fi
  fi
}

# Kai's Aliases
alias ll="ls -al"
alias config="v $HOME/.config/zsh/zshrc"
alias cb="pbcopy"
# alias split="split_tab"
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
# alias y="yazi"
alias gg="git log --oneline --graph --color --all --decorate"
alias gms="git merge --squash"
alias glog="git log --name-status"
alias skbr="sketchybar --reload"


# export PATH="/opt/homebrew/opt/tomcat@8/bin:$PATH"

# Load NVM only when its command is first used; Homebrew Node remains the default.
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
nvm() {
  unfunction nvm
  [ -s "$NVM_DIR/nvm.sh" ] || return 127
  \. "$NVM_DIR/nvm.sh" --no-use
  nvm "$@"
}
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# mojo
# export PATH="$PATH:/Users/wrath/.modular/bin"
# eval "$(magic completion --shell zsh)"

# nim
export PATH=/home/wrath/.nimble/bin:$PATH

. "$HOME/.cargo/env"
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
  fi

# export ODBC SQL Server
export PATH="$PATH:/opt/mssql-tools18/bin"

zstyle ':completion:*' menu select

complete -o nospace -C /opt/homebrew/bin/mc mc

# GO
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"
export GOROOT="/opt/homebrew/opt/go/libexec"
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# :-$LANG prevents the export setting from breaking iTerm2.
export LANG="${LC_ALL:-$LANG}"
unset LC_ALL

export AMP_API_KEY="sgamp_user_01JX1JQVY1MG9G5FQP0R657HEQ_1f087f1078d36c850c5cc7cd13bf900c6f2fb00f5c77d6acc0becbb45273118c"

fastfetch

# bun completions
[ -s "/Users/wrath/.bun/_bun" ] && source "/Users/wrath/.bun/_bun"
