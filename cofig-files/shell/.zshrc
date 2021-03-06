# ================================设置环境变量（path）====================================

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
#export PATH=$HOME/bin:/usr/Cellar/local/bin:$PATH
#export PATH="/usr/local/opt/python@3.8/libexec/bin:$PATH"
#export PATH="/usr/local/opt/ruby/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ================================设置ohmyzsh主题、插件===================================

# Set name of the theme to load --- if set to "random"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git sublime z zsh-syntax-highlighting zsh-autosuggestions)

#取消自动显示窗口标题
DISABLE_AUTO_TITLE="true"

source $ZSH/oh-my-zsh.sh

setopt HIST_IGNORE_DUPS  #消除重复记录

# ===================设置语言：在文件最后设置，因为source ohmyzsh之后会失效=================

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
#export LANG=zh_CN.UTF-8

# =================================设置别名（alias）=====================================
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi="nvim"
alias vim="nvim"
alias la="ls -a"
alias clr="clear"
alias python="/usr/local/bin/python3"
alias pip="/usr/local/bin/pip3"

#mac users alias
alias proxy="export ALL_PROXY=socks5://127.0.0.1:1086"
alias unproxy='unset ALL_PROXY'
#mac terminal vs使用vscode打开
alias vs="/Applications/'Visual Studio Code.app'/Contents/Resources/app/bin/code"

# ======================================其他设置========================================

#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# cd /Users/zxll/Desktop/code


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"