#####################
# ZI            #
#####################
### Added by Zi installer
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (z-shell/zi)…%f"
    command mkdir -p $HOME/.zi
    command git clone https://github.com/z-shell/zi.git $HOME/.zi/bin && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
        print -P "%F{160}▓▒░ The clone has failed.%F"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zi]=_zi
### End of Zi installer's chunk
# ENHANCD
zi ice wait"0b" lucid
zi light b4b4r07/enhancd
export ENHANCD_FILTER=fzf:fzy:peco

####################
# THEME             #
#####################
zi ice depth=1; zi light romkatv/powerlevel10k

#####################
# PLUGINS           #
#####################
# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
zi ice wait"0a" lucid atload"_zsh_autosuggest_start"
zi light zsh-users/zsh-autosuggestions
# ENHANCD
zi ice wait"0b" lucid
zi light b4b4r07/enhancd
export ENHANCD_FILTER=fzf:fzy:peco
# HISTORY SUBSTRING SEARCHING
zi ice wait"0b" lucid atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
zi light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# TAB COMPLETIONS
zi ice wait"0b" lucid blockf
zi light zsh-users/zsh-completions
autoload compinit
compinit


zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# FZF
zi ice from"gh-r" as"command"
zi light junegunn/fzf
# FZF BYNARY AND TMUX HELPER SCRIPT
zi ice lucid wait'0c' as"command" id-as"junegunn/fzf-tmux" pick"bin/fzf-tmux"
zi light junegunn/fzf
# BIND MULTIPLE WIDGETS USING FZF
zi ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zi light junegunn/fzf
# FZF-TAB
zi ice wait"1" lucid
zi light Aloxaf/fzf-tab
# SYNTAX HIGHLIGHTING
zi ice wait"0c" lucid atinit"zpcompinit;zpcdreplay"
zi light zdharma/fast-syntax-highlighting
# FORGIT
zi ice wait lucid
zi load 'wfxr/forgit'
# LAZYGIT
zi ice lucid wait"0" as"program" from"gh-r" mv"lazygit* -> lazygit" atload"alias lg='lazygit'"
zi light 'jesseduffield/lazygit'
# LAZYDOCKER
zi ice lucid wait"0" as"program" from"gh-r" mv"lazydocker* -> lazydocker" atload"alias lg='lazydocker'"
zi light 'jesseduffield/lazydocker'
# RANGER
zi ice depth'1' as"program" pick"ranger.py"
zi light ranger/ranger
# FD
zi ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zi light sharkdp/fd
# GH-CLI
zi ice lucid wait"0" as"program" from"gh-r" pick"usr/bin/gh"
zi light "cli/cli"
# TMUX
zi ice from"gh-r" as"program" mv"tmux* -> tmux" pick"tmux" atload"alias tmux=tmux"
# ZSH MANYDOTS MAGIC
zi autoload'#manydots-magic' for knu/zsh-manydots-magic
# TREE-SITTER
zi ice as"program" from"gh-r" mv"tree* -> tree-sitter" pick"tree-sitter"
zi light tree-sitter/tree-sitter
# XURLS
zi ice as"program" from"gh-r" mv"xurls* -> xurls" pick"xurls"
zi light mvdan/xurls
# PRETTYPING
zi ice lucid wait'' as"program" pick"prettyping" atload'alias ping=prettyping'
zi load "denilsonsa/prettyping"
# GLOW
zi ice lucid wait"0" as"program" from"gh-r" bpick='*linux_amd64.deb' pick"usr/bin/glow"
zi light charmbracelet/glow
# CODE-MINIMAP
zi ice lucid wait"0" as"program" from"gh-r" bpick='*amd64.deb' pick"usr/bin/code-minimap"
zi light wfxr/code-minimap
# HISTORY           #
#####################
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zhistory"
HISTSIZE=290000
SAVEHIST=$HISTSIZE

#####################
# SETOPT            #
#####################
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion
# setopt completealiases        # complete alisases
setopt always_to_end          # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word       # allow completion from within a word/phrase
setopt nocorrect                # spelling correction for commands
setopt list_ambiguous         # complete as much of a completion until it gets ambiguous.
setopt nolisttypes
setopt listpacked
setopt automenu
unsetopt BEEP
setopt vi

#####################
# ENV VARIABLE      #
#####################
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'
export SHELL='/bin/zsh'
export LANG='it_IT.UTF-8'
export LC_ALL='it_IT.UTF-8'
export BAT_THEME="gruvbox-dark"
if [[ ! $(tmux ls) ]] 2> /dev/null; then
  tmux new -s λ
fi
#####################
# COLORING          #
#####################
autoload colors && colors

#####################
# ALIASES           #
#####################
source $HOME/.zsh_aliases

#####################
# FANCY-CTRL-Z      #
#####################
function fg-fzf() {
	job="$(jobs | fzf -0 -1 | sed -E 's/\[(.+)\].*/\1/')" && echo '' && fg %$job
}

function fancy-ctrl-z () {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER=" fg-fzf"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

#####################
# FZF SETTINGS      #
#####################
export FZF_DEFAULT_OPTS="
--ansi
--layout=default
--info=inline
--height=50%
--multi
--preview-window=right:60%
--preview-window=sharp
--preview-window=cycle
--preview '([[ -f {} ]] && (bat --style=numbers --color=always --theme=gruvbox-dark --line-range :500 {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--prompt='λ -> '
--pointer='|>'
--marker='✓'
--bind 'ctrl-e:execute(nvim {} < /dev/tty > /dev/tty 2>&1)' > selected
--bind 'ctrl-v:execute(code {+})'"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#####################
# FZF-GC-PROJECT    #
#####################
# Thanks to sei40kr/zsh-fzf-gcloud

function fzf-gcloud-config-set-project() {
    local project="$(gcloud projects list |
        fzf --header-lines=1 --reverse |
        awk '{ print $1 }')"

    if [[ -n "$project" ]]; then
        gcloud config set project "$project"
    fi
}
zle -N fzf-gcloud-config-set-project
bindkey '^G' fzf-gcloud-config-set-project

#####################
# PATH              #
#####################
export PATH=$PATH:/usr/local/go/bin:~/.local/bin:~/bin


#####################
# GO SETTINGS       #
#####################
export GOPATH=$HOME/Dev/go

#####################
# FLUTTER SETTINGS  #
#####################
export PATH="$PATH:$HOME/Dev/flutter/bin"


#####################
# P10K SETTINGS     #
#####################
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

#####################
# RVM VARIABLE      #
#####################
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


cd ~

### End of Zinit's installer chunk
