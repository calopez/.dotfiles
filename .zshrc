export PATH="/opt/homebrew/bin:$PATH"

source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# ------------------------------------------------------------------------------
# eza (better `ls`)
# ------------------------------------------------------------------------------
if [ "$(command -v eza)" ]; then
  alias l="eza --icons"
  alias ls='eza -G --icons=auto -a --show-symlinks'
  alias ll='eza -lg --icons=auto -a --show-symlinks'
  alias la="eza -lag --icons"
  alias lt="eza -lTg --icons"
  alias lt1="eza -lTg --level=1 --icons"
  alias lt2="eza -lTg --level=2 --icons"
  alias lt3="eza -lTg --level=3 --icons"
  alias lta="eza -lTag --icons"
  alias lta1="eza -lTag --level=1 --icons"
  alias lta2="eza -lTag --level=2 --icons"
  alias lta3="eza -lTag --level=3 --icons"
fi


# ------------------------------------------------------------------------------
# eza (better `cd`)
# ------------------------------------------------------------------------------

eval "$(zoxide init zsh --cmd cd)"


export EDITOR="nvim"
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
  alias n='nvim'
fi

export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"


source <(fzf --zsh)

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line  # Ctrl+e opens command in $EDITOR
export VISUAL=nvim
export EDITOR=nvim

# Don't store duplicate lines
setopt HIST_IGNORE_ALL_DUPS       # Removes older duplicates, keeps latest
setopt HIST_FIND_NO_DUPS          # Don't show dupes in reverse search (Ctrl-R)

HISTSIZE=10000         # In-memory history
SAVEHIST=10000         # File history size
HISTFILE=~/.zsh_history


# Make zsh follow symbolic links in tab completion
setopt CHASE_LINKS
