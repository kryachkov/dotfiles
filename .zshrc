ZSH_DISABLE_COMPFIX="true"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="minimal"

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
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

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
plugins=(git kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

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
# Base16 Shell
DOTFILES_ROOT=$HOME/.config/dotfiles
[ -f $DOTFILES_ROOT/.env.secrets ] && source $DOTFILES_ROOT/.env.secrets

export LC_ALL="en_US.UTF-8"
export GPG_TTY=$(tty)
export DOCKER_BUILDKIT=1

# fzf->vim (will respect .gitignore and dotfiles)
fv() {
  FZF_DEFAULT_COMMAND="rg --files" fzf --bind "enter:become:nvim {1}"
}

# fzf->vim (all files)
fva() {
  fzf --bind "enter:become:nvim {1}"
}

# ripgrep->fzf->vim [QUERY]
rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

randompass() {
  LC_ALL=C tr -dc \[:graph:\] < /dev/urandom | head -c64
}

randomkeepass() {
  keepassxc-cli generate -lUnsL 64 | tr -d '\n'
}

alias hbpr="hub pull-request"
alias vim="nvim"

alias tmn="tmux new"
alias tml="tmux list-sessions"

alias mpdk="mpd --kill"
alias ncmpd="ncmpcpp"

alias gswma="git switch master"
alias calc="bc -l"

kdn() {
  kubectl debug nodes/$(kubectl get nodes --no-headers | cut -d" " -f1 | sort -R | head -n1) \
    -it --image fedora
}

az() {
  podman run -it --rm \
    -v "${HOME}/.azure:/root/.azure:Z" \
    mcr.microsoft.com/azure-cli:2.64.0 az "$@"
}

OPENTOFU_VERSION=1.8.7

aztofu() {
  podman run -it --rm \
    --workdir=/srv/workspace \
    -v "${HOME}/.azure:/root/.azure:Z" \
    -v "$(pwd):/srv/workspace:Z" \
    tofu-azure:$OPENTOFU_VERSION "$@"
}

ggtofu() {
  podman run -it --rm \
    --workdir=/srv/workspace \
    -v "${HOME}/Projects/git-gud/aws-credentials:/root/.aws/credentials:Z" \
    -v "$(pwd):/srv/workspace:Z" \
    ghcr.io/opentofu/opentofu:$OPENTOFU_VERSION "$@"
}

azghtofu() {
  podman run -it --rm \
    --workdir=/srv/workspace \
    -v "${HOME}/.azure:/root/.azure:Z" \
    -v "$(pwd):/srv/workspace:Z" \
    -e GITHUB_TOKEN="$GITHUB_TOKEN" \
    -e GITHUB_USERNAME="$GITHUB_USERNAME" \
    tofu-azure:$OPENTOFU_VERSION "$@"
}

bindkey -e
bindkey \^U backward-kill-line

if which nvim > /dev/null 2>&1; then
  export MANPAGER="nvim +Man!"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"
# export PATH="/usr/local/sbin:$PATH" >> ~/.zshrc
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}["
export ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$reset_color%}]%{$reset_color%} "
export BAT_THEME="Solarized (light)"

eval "$(zoxide init zsh)"
