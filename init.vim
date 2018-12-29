if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
filetype plugin indent on
syntax enable

set number            "行番号を表示
set autoindent        "改行時に自動でインデントする
set tabstop=2         "タブを2文字の空白に変換する
set shiftwidth=2      "自動インデント時に入力する空白の数
set expandtab         "タブ入力を空白に変換
set clipboard=unnamed "yank した文字列をクリップボードにコピー
set hls               "検索した文字をハイライトする
set ambiwidth=double
set laststatus=2
set sh=zsh

"----------
"折りたたみ
"----------
set foldmethod=indent "折りたたみ範囲をインデントで自動設定
set foldlevel=2
set foldcolumn=3
au BufWinLeave * mkview
au BufWinEnter * silent loadview
