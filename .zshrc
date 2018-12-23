# zplugがなければzplugをインストール後zshを再起動
if [ ! -e "${HOME}/.zplug/init.zsh" ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
source ${HOME}/.zplug/init.zsh

# ssh先の場合tmux自動起動
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" && -z "$TMUX" && -z "$STY" ]] && type tmux >/dev/null 2>&1; then
    function confirm {
        MSG=$1
        while :
        do
            echo -n "${MSG} (Y/n): "
            read ans
            case $ans in
                [yY]) return 0 ;;
                [nN]) return 1 ;;
                   *) return 0 ;;
            esac
        done
    }
    option=""
    if tmux has-session && tmux list-sessions; then
        option="attach"
    fi
    tmux $option && confirm "exit?" && exit
fi

# --------------
# エイリアス
# --------------
alias ghc="stack ghc --"
alias ghci="stack ghc -- --interactive"
alias runghc="stack runghc --"
alias lsa="ls -alh"

# --------------
# プラグイン
# --------------
# テーマ
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
# シンタックスハイライト
zplug 'zsh-users/zsh-syntax-highlighting'
# 自動補完
zplug 'zsh-users/zsh-autosuggestions'
# インクリメンタルサーチ
zplug "peco/peco", as:command, from:gh-r
zplug "mollifier/anyframe"

# --------------
# 色の設定
# --------------
autoload colors
colors

# プロンプト
PROMPT="%{${fg[green]}%}%n@%m %{${fg[yellow]}%}%~ %{${fg[red]}%}%# %{${reset_color}%}"
PROMPT2="%{${fg[yellow]}%} %_ > %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r ? [n,y,a,e] %{${reset_color}%}"

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
linux*)
  # Linux
  alias ls='ls -F --color'
  ;;
esac

# --------------
# cdr関連の設定
# --------------
setopt AUTO_PUSHD # cdしたら自動でディレクトリスタックする
setopt pushd_ignore_dups # 同じディレクトリは追加しない
DIRSTACKSIZE=100 # スタックサイズ
# cdr, add-zsh-hook を有効にする
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# --------------
# 履歴関連の設定
# --------------
HISTFILE=~/.zsh_history #履歴ファイルの設定
HISTSIZE=1000000 # メモリに保存される履歴の件数。(保存数だけ履歴を検索できる)
SAVEHIST=1000000 # ファイルに何件保存するか
setopt extended_history # 実行時間とかも保存する
setopt share_history # 別のターミナルでも履歴を参照できるようにする
setopt hist_ignore_all_dups # 過去に同じ履歴が存在する場合、古い履歴を削除し重複しない
setopt hist_ignore_space # コマンド先頭スペースの場合保存しない
setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_reduce_blanks #余分なスペースを削除してヒストリに記録する
setopt hist_save_no_dups # histryコマンドは残さない
setopt hist_expire_dups_first # 古い履歴を削除する必要がある場合、まず重複しているものから削除
setopt hist_expand # 補完時にヒストリを自動的に展開する
setopt inc_append_history # 履歴をインクリメンタルに追加

# --------------
# anyframeの設定
# --------------
# anyframeで明示的にpecoを使用するように定義
zstyle ":anyframe:selector:" use peco
# C-zでcd履歴検索後移動
bindkey '^Z' anyframe-widget-cdr
# C-rでコマンド履歴検索後実行
bindkey '^R' anyframe-widget-put-history


# --------------
# その他の設定
# --------------
setopt correct # コマンドのスペルミスを指摘
setopt auto_cd # ディレクトリ名でcd
setopt no_beep # ビープ音を鳴らさない


# プラグインがインストールされていなかったらインストールするか聞く
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# プラグインをロードする
zplug load
