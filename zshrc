#! /usr/bin/zsh
# -*- mode: sh ; coding: utf-8 -*-

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################################
# 環境変数
########################################
# LANG
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# PATH設定

case ${OSTYPE} in
    darwin*)
        #ここにMac向けの設定

		# HomeBrew
		export BREW_DIR=/usr/local

		# Local Dir
		export LOCAL_DIR=$HOME/local

		#clangのデフォルトライブラリパスの設定
		#export CLIB
		
		# alias
		alias emacs="TERM=xterm-256color /usr/local/bin/emacs"
		# alias gcc="g++-5 -std=c++11 -Wall -Wextra -Wconversion"
		;;
    linux*)
        #ここにLinux向けの設定

		# HomeBrew (Linux Brew)
		export BREW_DIR=$HOME/.linuxbrew

		# Local Dir
		export LOCAL_DIR=$HOME/local

		# Go
		export GOPATH=$HOME/local/go

		# manpath
		export MANPATH=$BREW_DIR/share/man:$MANPATH

		# infopath
		export INFOPATH=$BREW_DIR/share/info:$INFOPATH

        # parquet
        alias parquet="java -cp '/home/makoto/repos/parquet-mr/parquet-cli/target/parquet-cli-1.13.1.jar:target/dependency/*' org.apache.parquet.cli.Main"
		;;
esac

############# PATH #####################
export PATH=$HOME/.cabal/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$LOCAL_DIR/bin:$PATH

# HOMEBREW
#export PATH=$BREW_DIR/bin:$PATH
#export PATH=$BREW_DIR/sbin:$PATH

# Go
export PATH=$GOPATH/bin:$PATH
export GOPRIVATE=github.com/tier4

# my build lib path
#export PKG_CONFIG_PATH=$LOCAL_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
#export DYLD_FALLBACK_LIBRARY_PATH=$LOCAL_DIR/lib:$DYLD_FALLBACK_LIBRARY_PATH

##### clangのデフォルトインクルードパスの設定 ####
export CPATH=/usr/local/include:$CPATH
export CPATH=$LOCAL_DIR/include:$CPATH

# HomeBrew
#export LD_LIBRARY_PATH=$BREW_DIR/lib:$LD_LIBRARY_PATH

# for prezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# python user
PATH=$HOME/.local/bin:$PATH

# Rust
PATH=$PATH:$HOME/.cargo/bin


#####################################################
# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
#PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
#%# " 

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# add-zsh-hook
autoload -Uz add-zsh-hook

########################################
# 補完
# 補完機能を有効にする
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=($BREW_DIR/share/zsh-completions $fpath)
fi

autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
       /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# <Tab> でパス名の補完候補を表示したあと、
# 続けて <Tab> を押すと候補からパス名を選択できるようになる
# 候補を選ぶには <Tab> か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1

######## ディレクトリの移動の設定 ##############

DIRSTACKSIZE=100
setopt AUTO_PUSHD

autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# = の後はパス名として補完する
setopt magic_equal_subst

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# glob に引っかからなくても警告を出さないようにする
setopt nonomatch

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス


alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias ...='cd ../..'
alias ....='cd ../../..'

alias grep='grep --color'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
alias sudo='nocorrect sudo'

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
alias -g P='| peco'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi


#######################################

########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
		alias clang++=/usr/local/opt/llvm/bin/clang++
		alias clang=/usr/local/opt/llvm/bin/clang
#		if [ -e $HOME/.Xmodmap ]; then
#			xmodmap $HOME/.Xmodmap
#		fi
        ;;
    linux*)
        #Linux用の設定
        ;;
esac

#########################################
# 他のファイルの読み込み


# for ros
if [ -e /opt/ros/kinetic/setup.zsh ]; then
	source /opt/ros/kinetic/setup.zsh
fi

# for Autoware
#if [ -e $HOME/repos/Autoware/ros/devel/setup.zsh ]; then
#	source $HOME/repos/Autoware/ros/devel/setup.zsh
#fi

# anyenvの設定
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# peco
## peco history
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
				 eval $tac | \
				 peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# ### search a destination from cdr list
function peco-get-destination-from-cdr() {
	cdr -l | \
		sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
		peco --query "$LBUFFER"
}

### search a destination from cdr list and cd the destination
function peco-cdr() {
	local destination="$(peco-get-destination-from-cdr)"
	if [ -n "$destination" ]; then
		BUFFER="cd $destination"
		zle accept-line
	else
		zle reset-prompt
	fi
}
zle -N peco-cdr
bindkey '^x' peco-cdr

#pecoでkill
function peco-pkill() {
	for pid in `ps aux | peco | awk '{ print $2 }'`
	do
		kill $pid
		echo "Killed ${pid}"
	done
}
alias pk="peco-pkill"


#######################################

# pipenv
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"

########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
		alias clang++=/usr/local/opt/llvm/bin/clang++
        alias clang=/usr/local/opt/llvm/bin/clang
        alias sudo='nocorrect sudo'
        ;;
    linux*)
        #Linux用の設定
        ;;
esac
 
# vim:set ft=zsh:

#########################################
# 他のファイルの読み込み

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

#if [ $SHLVL = 1 ]; then
#    tmux -2
#fi

# emacs
alias -g emacs='emacsclient -nw -a ""'
alias -g e='emacs'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -e ${HOME}/.secret ]; then
  . ${HOME}/.secret
fi
autoload -U compinit; compinit
