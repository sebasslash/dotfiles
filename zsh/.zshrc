if [[ "$1" == "-v" ]]; then
    VERBOSE=1
fi

function debug() {
    message=$1
    if [[ $VERBOSE -eq 1 ]]; then
        echo "[DEBUG]: $message"
    fi
}

function add_binary_paths() {
    debug "adding binaries to path"
    wastime
    cuda
    solana
}

function add_env_managers() {
    debug "initializing version manager tooling"

    init_goenv
    init_pyenv
    init_exenv
    init_tfenv
    init_nvm
    init_chruby

    debug "done initializing environments"
}

function add_aliases() {
    debug "initializing aliases"

    # Tmux aliases
    alias tnew="tmux new -s"
    alias tattach="tmux attach -t"
    # Vim aliases
    alias vim="nvim"
    alias vi="nvim"
    # Shortcuts
    alias vc="vim ~/.config/nvim/init.vim"
    alias ac="vim ~/.config/alacritty/alacritty.yml"
    alias tf-debug-build="go build -gcflags=all=\"-N -l\" && mv terraform $GOPATH/bin"
    alias reload="source ~/.zshrc"

    debug "done"
}

function init_goenv() {
    debug "initializing goenv"

    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    eval "$(goenv init -)"
    # Allow goenv to manage goroot
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$PATH:$GOPATH/bin"

    debug "done"
}

function init_pyenv() {
    debug "initializing pyenv"

    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    export PYVERSION="$(pyenv root)/shims/python3"

    debug "done"
}

function init_exenv() {
    debug "initializing exenv"

    export PATH="$HOME/.exenv/bin:$PATH"
    eval "$(exenv init -)"

    debug "done"
}

function init_tfenv() {
    debug "initializing tfenv"

    export PATH="$HOME/.tfenv/bin:$PATH"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    debug "done"
}

function init_nvm() {
    debug "initializing nvm"

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    debug "done"
}

function init_chruby() {
    debug "sourcing chruby"

    source /usr/local/share/chruby/chruby.sh

    RUBIES+=(
        "$HOME/rubies/ruby-3.1.3"
        "$HOME/rubies"
    )
    debug "done"
}

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

debug "done initializing ohmyzsh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
function wastime() {
    export WASMTIME_HOME="$HOME/.wasmtime"
    export PATH="$WASMTIME_HOME/bin:$PATH"
    debug "added wastime to PATH"
}

function cuda() {
    export PATH="/usr/local/cuda-12.3/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda-12.3/lib64:$LD_LIBRARY_PATH"
    debug "added cuda-12.3 to PATH"
}

function solana() {
    export PATH="/home/sebastian/.local/share/solana/install/active_release/bin:$PATH"
    debug "added solana cli to PATH"
}

add_binary_paths
add_aliases
add_env_managers
