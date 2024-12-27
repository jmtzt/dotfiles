# ln -s ~/.config/zsh/zshrc ~/.zshrc
alias cops="gh copilot suggest"
alias ca="conda activate "
alias cde="conda deactivate"
alias cope="gh copilot explain"
alias lzd='lazydocker'
alias n="nnn"
alias vim="lvim"
alias t="tree --gitignore"
alias nvim="/Users/c0mrade/Downloads/nvim-macos-arm64/bin/nvim"
alias av="source .venv/bin/activate"
alias todo="vim ~/personal/todo.md"

plugins=(git git-prompt zsh-fzf-history-search zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting mercurial better-virtualenv transportstatus multirust idasen-control)
ZSH_THEME="mitsuhiko"
ZSH_CUSTOM=$HOME/.config/zsh/custom/
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config/"
export EDITOR="lvim"
export WORKON_HOME="$HOME/venvs"
# source $HOME/.config/virtualenvwrapper.sh
source ~/.bash_profile

DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="yyyy-mm-dd"

source $ZSH/oh-my-zsh.sh


unsetopt share_history

# Java Configuration
# export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_352`
# export SPARK_HOME=/opt/homebrew/Cellar/apache-spark/3.5.1/libexec
# TODO: change user c0mrade to joao
export PYTHONPATH=$SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.10.9.7-src.zip:$PYTHON_PATH
# source /Users/c0mrade/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export LC_ALL=en_US.UTF-8
export PATH=/Users/c0mrade/Downloads/google-cloud-sdk/bin:\
/Users/c0mrade/.config/tmux/tmux-sessionizer.sh:\
/Users/c0mrade/.cargo/bin:\
/Users/c0mrade/.local/bin:\
/opt/apache-maven-3.8.6/bin:\
/opt/homebrew/Cellar/apache-spark/3.5.1/libexec/bin:\
/opt/homebrew/Cellar/apache-spark/3.5.1/libexec/python:\
/Users/c0mrade/miniforge3/envs/haltbar/bin:\
/opt/homebrew/bin:\
/opt/homebrew/sbin:\
/usr/local/bin:\
/System/Cryptexes/App/usr/bin:\
/usr/bin:\
/bin:\
/usr/sbin:\
/sbin:\
/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:\
/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:\
/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:\
/opt/X11/bin:\
/Library/TeX/texbin:\
/Library/Frameworks/Mono.framework/Versions/Current/Commands:\
/Users/c0mrade/opt/anaconda3/condabin:\
/opt/homebrew/opt/fzf/bin

# bind esc + ,
# autoload -Uz copy-earlier-word
# zle -N copy-earlier-word
# bindkey '\e,' copy-earlier-word

export HOMEBREW_NO_AUTO_UPDATE=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(thefuck --alias)
eval "$(zoxide init --cmd cd zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH=/Users/$(whoami)/.oh-my-zsh
