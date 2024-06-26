PATH=/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/sbin:
export PATH 
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
LANG=ja_JP.UTF-8
export LANG 
export CLICOLOR=yes
export LSCOLORS=gxfxcxdxbxegedabagacad
export PERL5LIB=''
export GOPATH=$HOME
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/opt/libjpeg/lib:/opt/homebrew/opt/libpng/lib

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# rbenv     
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# plenv     
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

# https://zenn.dev/rh820/articles/86f13278b68c1b

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
## シンタックスハイライト
zinit light zsh-users/zsh-syntax-highlighting

## 入力補完
zinit light zsh-users/zsh-autosuggestions

### --git branch start
### http://kitak.hatenablog.jp/entry/2013/05/25/103059
# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|) %~"
### --git branch end

#PROMPT='%l %T %m[%h]%# '
PROMPT='%m[%h]%# '
#RPROMPT=' %~'

#alias ls='ls --color=auto'
alias ll="ls -l"
alias la="ls -a"
alias lt="ls -ltr"
alias vi="vim"
alias pus="pushd"
alias pop="popd"
alias gp="git pull"
alias glg="git log --oneline --graph"
alias ack="ack -C 3"
alias vup="vagrant up"
alias vdown="vagrant halt"
alias vsh="vagrant ssh"
alias perldoc="perldoc -M Pod::Text::Color::Delight"
alias grep="grep --color=auto"

# http://qiita.com/dongri/items/7b142c138e650785bd72
alias date="gdate"

fpath=(~/.zsh/functions/Completion ${fpath})
#.zshrc ファイルに次の2行を足すだけで、タブキーでファイル名を拾うだけでなくて、コマンドラインオプションも持ってくることができる。
autoload -U compinit
compinit
 
#function chpwd() {
#  _reg_pwd_screennum
#}

# ssh-agent --start
# http://nekoya.github.io/wiki/ssh-agent.html
agent="$HOME/.ssh-agent-`hostname`"
if [ -S "$agent" ]; then
    export SSH_AUTH_SOCK=$agent
elif [ ! -S "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=$agent
elif [ ! -L "$SSH_AUTH_SOCK" ]; then
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
 fi          
# ssh-agent --end
                                      
                                                  
# 補完時の大文字・小文字の区別をしない
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
#setopt append_history

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# 補完候補が複数ある時に、一覧表示する
setopt auto_list

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除く
#setopt auto_remove_slash

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
#setopt auto_resume

# ビープ音を鳴らさないようにする
setopt NO_beep

# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

# 内部コマンドの echo を BSD 互換にする

#setopt bsd_echo

# シンボリックリンクは実体を追うようになる
#setopt chase_links

# 既存のファイルを上書きしないようにする
#setopt clobber

# コマンドのスペルチェックをする
setopt correct

# コマンドライン全てのスペルチェックをする
#setopt correct_all

# =command を command のパス名に展開する
setopt equals

# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

# zsh の開始・終了時刻をヒストリファイルに書き込む
#setopt extended_history

# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control

# 各コマンドが実行されるときにパスをハッシュに入れる
#setopt hash_cmds

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
#setopt hist_ignore_space

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
setopt NO_hup

# Ctrl+D では終了しないようになる（exit, logout などを使う）

setopt ignore_eof

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types

# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# メールスプール $MAIL が読まれていたらワーニングを表示する
#setopt mail_warning

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 補完候補が複数ある時、一覧表示 (auto_list) せず、すぐに最初の候補を補完する
#setopt menu_complete

# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios

# ファイル名の展開で、辞書順ではなく数値的にソートされるようになる
setopt numeric_glob_sort

# コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
#setopt path_dirs

# 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit

# 戻り値が 0 以外の場合終了コードを表示する
#setopt print_exit_value

# ディレクトリスタックに同じディレクトリを追加しないようになる
#setopt pushd_ignore_dups

# pushd を引数なしで実行した場合 pushd $HOME と見なされる
#setopt pushd_to_home

# rm * などの際、本当に全てのファイルを消して良いかの確認しないようになる
#setopt rm_star_silent

# rm_star_silent の逆で、10 秒間反応しなくなり、頭を冷ます時間が与えられる

#setopt rm_star_wait

# for, repeat, select, if, function などで簡略文法が使えるようになる
setopt short_loops

# デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる
#setopt single_line_zle

# コマンドラインがどのように展開され実行されたかを表示するようになる
#setopt xtrace

# 色を使う  
#setopt prompt_subst

# シェルのプロセスごとに履歴を共有
#setopt share_history

# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

# 文字列末尾に改行コードが無い場合でも表示する
unsetopt promptcr

#コピペの時rpromptを非表示する
#setopt transient_rprompt

# cd -[tab] でpushd
setopt autopushd

# ディレクトリを水色にする｡
#export LS_COLORS='di=01;36'

# ファイルリスト補完でもlsと同様に色をつける｡

#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

