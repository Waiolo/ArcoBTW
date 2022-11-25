
##############################
#    Dave dot-files 2022   ###
##############################


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


#################
#  Path zsh   ###
export ZSH="$HOME/.config/.zsh/.oh-my-zsh"


#################
#    Theme    ###
#################
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

source $ZSH/oh-my-zsh.sh

# User configuration

 export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
 export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

#################
#    PLUGINS    #
#################
# source ~/.config/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(
	git
	autojump
	rsync python
	mercurial
	npm
	ruby
	copyfile
	dirhistory
  	zsh-autosuggestions
		)

#####################
# ENV VARIABLE      #
#####################
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'
export SHELL='/bin/zsh'
export LANG='it_IT.UTF-8'


#####################
# COLORING          #
#####################
autoload colors && colors

#####################
# ALIASES           #
#####################

[[ -f $HOME/.config/.zsh/aliases.zsh ]] && source $HOME/.config/.zsh/aliases.zsh
[[ -f $HOME/.config/.zsh/functions.zsh ]] && source $HOME/.config/.zsh/functions.zsh
[[ -f $HOME/.config/.zsh/nvm.zsh ]] && source $HOME/.config/.zsh/nvm.zsh
[[ -f $HOME/.config/.zsh/wsl2fix.zsh ]] && source $HOME/.config/.zsh/wsl2fix.zsh
source $HOME/.config/.zsh_aliases
alias empty="cat /dev/null > "

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



if [ -x "$(command -v exa)" ]; then
    alias ls="exa"
    alias la="exa --long --all --group"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.config/.zsh/.p10k.zsh ]] || source $HOME/.config/.zsh/.p10k.zsh

