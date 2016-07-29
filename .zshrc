# 少し凝った zshrc
 
########################################
# 環境変数
#! /usr/bin/zsh
# -*- mode: sh ; coding: utf-8 -*-
 
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

		# oh-my-zsh
		export ZSH=$HOME/.oh-my-zsh
		
		# CPLEX
		export CPLEX_HOME_DIR=$HOME/Apprications/IBM/ILOG/CPLEX_Studio126
		export CPLEX_BIN_DIR=$CPLEX_HOME_DIR/cplex/bin/x86-64_osx
		
		# Gurobi
		export GUROBI_HOME=/opt/gurobi600/linux64
		export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib" # DYLib
		export PATH=$PATH:$GUROBI_HOME/bin # Path
		
		# pyenv
		export PYENV_ROOT=/usr/local/var/pyenv

		
		#clangのデフォルトライブラリパスの設定
		#export CLIB
		
		# alias
		alias emacs="TERM=xterm-256color /usr/local//bin/emacs"
		alias gcc="g++-5 -std=c++11 -Wall -Wextra -Wconversion"
		;;
    linux*)
        #ここにLinux向けの設定

		# oh-my-zsh
		export ZSH=/home/tokunaga/.oh-my-zsh
		
		# HomeBrew (Linux Brew)
		export BREW_DIR=$HOME/.linuxbrew

		# Local Dir
		export LOCAL_DIR=$HOME/local

		# Cplex
		export CPLEX_HOME_DIR=/opt/ibm/ILOG/CPLEX_Studio1261
		export CPLEX_BIN_DIR=$CPLEX_HOME_DIR/cplex/bin/x86-64_linux
		
		# pyenv
		export PYENV_ROOT=$BREW_DIR/var/pyenv

		# Go
		export GOPATH=$HOME/go

		# manpath
		export MANPATH=$BREW_DIR/share/man:$MANPATH

		# infopath
		export INFOPATH=$BREW_DIR/share/info:$INFOPATH

		;;
esac

############# PATH #####################
export PATH=$HOME/.cabal/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$LOCAL_DIR/bin:$PATH

# CPLEX
export PATH=$CPLEX_BIN_DIR:$PATH

# HOMEBREW
export PATH=$BREW_DIR/bin:$PATH
export PATH=$BREW_DIR/sbin:$PATH

# Go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# my build lib path
export PKG_CONFIG_PATH=$LOCAL_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
export DYLD_FALLBACK_LIBRARY_PATH=$LOCAL_DIR/lib:$DYLD_FALLBACK_LIBRARY_PATH

##### clangのデフォルトインクルードパスの設定 ####
export CPATH=/usr/local/include:$CPATH
export CPATH=$LOCAL_DIR/include:$CPATH

# CPLEX
export CPATH=$CPLEX_HOME_DIR/cplex/include:$CPATH
export CPATH=$CPLEX_HOME_DIR/concert/include:$CPATH
export CPATH=$CPLEX_HOME_DIR/cpoptimizer/include:$CPATH

# HomeBrew
export LD_LIBRARY_PATH=$BREW_DIR/lib:$LD_LIBRARY_PATH



####################################################
# oh-my-zsh
# THEME
#ZSH_THEME="amuse"
ZSH_THEME="agnoster"

# Plugins
plugins=(my-env atom autojump brew brew-cask bundler cdd colored-man composer docker encode64 gem git homeshick pow rails rake rbenv tig tmux vagrant web-search)


source $ZSH/oh-my-zsh.sh

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
# vcs_info

# autoload -Uz vcs_info
# zstyle ':vcs_info:*' formats '(%s)-[%b]'
# zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
# precmd () {
# 	psvar=()
# 	LANG=en_US.UTF-8 vcs_info
# 	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
# }
# RPROMPT="%1(v|%F{green}%1v%f|)"

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
 
########################################
# キーバインド
 
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
 
########################################
# エイリアス
 
alias la='ls -a'
alias ll='ls -l'
 
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
 
alias mkdir='mkdir -p'

alias ...='cd ../..'
alias ....='cd ../../..'
 
# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
 
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

# emacs
alias -g emacs='emacsclient -nw -a ""'
alias -g e='emacs'

# peco
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

#######################################
# hashの設定
# "~hoge" が特定のパス名に展開されるようにする（ブックマークのようなもの）
# 例： cd ~hoge と入力すると /long/path/to/hogehoge ディレクトリに移動
# hash -d hoge=/long/path/to/hogehoge

#######################################
# ruby の設定
export PATH=$HOME/.rbenv/bin:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# python の設定
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then
	eval "$(pyenv init -)";
	eval "$(pyenv virtualenv-init -)"
fi

export VIRTUALENVWRAPPER_PYTHON=python
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
 
########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
		alias clang++=/usr/local/opt/llvm/bin/clang++
		alias clang=/usr/local/opt/llvm/bin/clang
		#brew-fileの設定
		export HOMEBREW_BREWFILE=$HOME/.brewfile
		export HOMEBREW_CASK_OPTS="--caskroom=/etc/Caskroom"
        ;;
    linux*)
        #Linux用の設定
        ;;
esac
 
# vim:set ft=zsh:

#########################################
# 他のファイルの読み込み

# terminal-notifierの設定
# export SYS_NOTIFIER='terminal-notifier'
# source ~/.zsh.d/zsh-notify/notify.plugin.zsh

