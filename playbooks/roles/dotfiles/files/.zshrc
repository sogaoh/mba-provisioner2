#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Customize to your needs...

# Iceberg iTerm2 Color
export CLICOLOR=1


# zsh-completion 
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history


# peco
function peco-repos() {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-repos
bindkey '^R' peco-repos

function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^H' peco-history-selection

if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr () {
    local selected_dir="$(cdr -l | sed -E 's/^[0-9]+ +//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^F' peco-cdr
#bindkey '^D' peco-cdr

function peco-docker-images() {
  local images="$(docker images | tail +2 | sort | peco --prompt 'DOCKER IMAGES>' | awk '{print $3}' ORS=' ')"
  [ -z "$images" ] && return
  BUFFER="$LBUFFER$images$RBUFFER"
  CURSOR=$#BUFFER
}

zle -N peco-docker-images
bindkey '^x^i' peco-docker-images


# gcloud 
## refs https://zenn.dev/choimake/articles/1abc277f1bffac
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"


# direnv
eval "$(direnv hook zsh)"


# anyenv
eval "$(anyenv init -)"


# # awsp
# function awsp() {
#   if [ $# -ge 1 ]; then
#     export AWS_PROFILE="$1"
#     echo "Set AWS_PROFILE=$AWS_PROFILE."
#   else
#     source _awsp
#   fi
#   export AWS_DEFAULT_PROFILE=$AWS_PROFILE
# }
