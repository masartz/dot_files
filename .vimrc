" see also http://www15.ocn.ne.jp/~tusr/vim/options.html
"set tags=tags
set number              " 行番号表示
"set scrolloff=999       " 常にカーソルがウインドウの中心に
set expandtab           " インデントをTabではなくスペースに
"set tabstop=4           " タブをスペース何個に変換するか
set tabstop=8           " タブをスペース何個に変換するか
set softtabstop=4       " Tabを押したときに入るスペースの量
set shiftwidth=4        " インデントの幅
"set smartindent         " 自動インデント
"set autoindent          " 自動インデント
set cindent             " プログラム用自動インデント
set backspace=2         " 改行後のBackSpaceキーの振る舞い
set showmatch           " カッコの対応を確認
set laststatus=2        " ステータス行の表示設定
set ignorecase          " 検索・置換時の大文字小文字を区別しない
set wildmode=list:full  " 補完機能を有効にする
set wildmenu            " 補完候補を表示する
set listchars=tab:>-    " Tabを明示的に表示
"set list                " Tabや改行を可視化
set nolist
set shellslash          " パスのセパレータをバックスラッシュからスラッシュに（Windows専用）
set ruler               " ルーラーを表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P " ステータス行に文字コードと改行コードを表示
set incsearch           "検索打ち込み中にも検索
set hlsearch            "検索打ち込み中にも検索
set showcmd             "実行中のコマンド表示
syntax on               "ソースコードをハイライト

" .psgiファイルをperlハイライトにする
filetype on
au BufNewFile,BufRead *.psgi set filetype=perl
au BufNewFile,BufRead *.t set filetype=perl

"http://d.hatena.ne.jp/tokuhirom/20101105/1288931525
autocmd BufRead *.sql set filetype=mysql

"http://stackoverflow.com/questions/1562633/setting-vim-whitespace-preferences-by-filetype
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

iab VARH <TMPL_VAR EXPR="html()">
iab VARF <TMPL_VAR EXPR="form()">
iab SELF my $self = shift;
iab UBP #!/usr/bin/env perl
iab USUW use strict;<CR>use warnings;<CR>
iab DUMP use Data::Dumper;<CR>open(DH,">>/tmp/debug.txt");<CR>print DH Dumper();<CR>close(DH);
iab DUMPH ob_start();<CR>print_r();<CR>$dump = ob_get_contents();<CR>ob_end_clean();<CR>$fp = fopen('/tmp/debug.txt', 'a');<CR>fwrite($fp, $dump);    <CR>fclose($fp);
iab DUMPR file = File.open('/tmp/debug.txt', 'a')<CR>file.write(p().inspect + "\n")<CR>file.close

"使いやすいキー配置に
nnoremap k gk
nnoremap j gj
noremap z $
noremap 0 _

"NeoBundle --start
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'https://github.com/nakatakeshi/jump2pm.vim.git'

" scala用syntax highlight
" http://kimikimi714.hatenablog.com/entry/2015/06/05/180000
NeoBundle 'derekwyatt/vim-scala'
"NeoBundle --end

" Markdown for vim --start
" http://www.key-p.com/blog/staff/archives/9032
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
au BufRead,BufNewFile *.md set filetype=markdown
" Markdown for vim --end

" vim-go
" http://qiita.com/izumin5210/items/1f3c312edd7f0075b09c
NeoBundle 'fatih/vim-go'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" syntastic --start
" http://blog.glidenote.com/blog/2013/03/16/puppet-syntax-check/
NeoBundle 'scrooloose/syntastic'


call neobundle#end()

filetype plugin on
filetype indent on
" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
          \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif



"Jump2pm --start
noremap fv :call Jump2pm('vne')<ENTER>
noremap fe :call Jump2pm('e')<ENTER>
noremap fn :call Jump2pm('sp')<ENTER>
"noremap ft :call Jump2pm('tabe')<ENTER>
"Jump2pm --end

"" ruby-slim --start
" https://github.com/slim-template/vim-slim
call pathogen#infect()

syntax enable
filetype plugin indent on
"" ruby-slim --end

"" type-script start
"filetype plugin on
"au BufRead,BufNewFile *.ts        setlocal filetype=typescript
"set rtp+=/Users/m-hoshino/node_module/typescript-tools.vim/
"" type-script end

execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['golint']
" syntastic --end

" golint --start
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
" golint --end

" UTF-8の□や○でカーソル位置がずれないようにする
if exists("&ambiwidth")
    set ambiwidth=double
endif

"文字コード自動判別
set encoding=utf-8
"set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2
set fileformats=unix,dos,mac

if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    "iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    "fileencodingsを構築
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
"        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
"        let &fileencodings = &fileencodings .','. s:fileencodings_default
        if has('mac')
            let &fileencodings = 'utf-8,' . s:enc_jis .','. s:enc_euc
            let &fileencodings = &fileencodings .','. s:fileencodings_default
        else
            let &fileencodings = 'utf-8,' . s:enc_jis .','. s:enc_euc .',cp932'
            let &fileencodings = &fileencodings .','. s:fileencodings_default
        endif
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    unlet s:enc_euc
    unlet s:enc_jis
endif

filetype plugin on

