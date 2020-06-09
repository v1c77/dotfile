export ZSH=/Users/vici/.oh-my-zsh

ZSH_THEME="gnzh"

# for hub and brew installed tools auto Completions.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

#zsh self conf
autoload -U compinit
compinit
plugins=(git github docker docker-compose celery pyenv pip mvn zsh-syntax-highlighting nvm  zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias cls='clear'
alias ll='ls -l'
alias la='ls -a'
alias vi='vim'
alias javac="javac -J-Dfile.encoding=utf8"
alias grep="grep --color=auto"
alias -s html=mate   # 在命令行直接输入后缀为 html 的文件名，会在 TextMate 中打开
alias -s rb=mate     # 在命令行直接输入 ruby 文件，会在 TextMate 中打开
alias -s js=vi
alias -s c=vi
alias -s java=vi
alias -s txt=vi
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias -s tar='tar -zxvf'
alias wp='cd ~/proj/smartx'
alias pc='proxychains4'
alias git='hub'
alias vinavel='vim +"set nornu nonumber wrap"'

# nvm related
export NVM_DIR="/Users/vici/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# color
export TERM=xterm-256color
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/usr/local/sbin:$PATH"

#some tools about GNU
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# SOMETHING ABOUT GOLANG
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
# export PATH="/Users/vici/myproject/qshell-v2.0.3:/$PATH"

# setup cmd  proxy
function init_proxy {
    eval "export https_proxy=http://127.0.0.1:1090;export http_proxy=http://127.0.0.1:1090;export all_proxy=socks5://127.0.0.1:1080"
}
function remove_proxy {
    eval "export https_proxy=;export http_proxy=;export all_proxy="
}


# added by travis gem
#[ -f /Users/vici/.travis/travis.sh ] && source /Users/vici/.travis/travis.sh

# dotfile script
# function dot_sync {
#   eval "cd ~/myproject/dotfiles && make sync"
# }
#
# function dot_upload {
#   eval "cd ~/myproject/dotfiles && make upload"
# }
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL=


# lua
export LUA=/usr/local/opt/lua
export LUAINC=/usr/local/opt/lua
export LUALIB=/usr/local/opt/lua
export LUABIN=/usr/local/bin

# pyenv related
export PATH="/Users/vici/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -s "/Users/vici/.gvm/scripts/gvm" ]] && source "/Users/vici/.gvm/scripts/gvm"

export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

# qt related
# For compilers to find qt you may need to set:
export LDFLAGS="-L/usr/local/opt/qt/lib"
export CPPFLAGS="-I/usr/local/opt/qt/include"

# For pkg-config to find qt you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig"
export PATH="/usr/local/opt/qt/bin:$PATH"

# openssl related
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

#libvirt
export PKG_CONFIG_PATH="/usr/local/opt/libvirt/lib/pkgconfig"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/kustomize kustomize
