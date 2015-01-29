" see also http://www15.ocn.ne.jp/~tusr/vim/options.html
"set tags=tags
set number              " ���ֹ�ɽ��
"set scrolloff=999       " ��˥������뤬������ɥ����濴��
set expandtab           " ����ǥ�Ȥ�Tab�ǤϤʤ����ڡ�����
"set tabstop=4           " ���֤򥹥ڡ������Ĥ��Ѵ����뤫
set tabstop=8           " ���֤򥹥ڡ������Ĥ��Ѵ����뤫
set softtabstop=4       " Tab�򲡤����Ȥ������륹�ڡ�������
set shiftwidth=4        " ����ǥ�Ȥ���
"set smartindent         " ��ư����ǥ��
"set autoindent          " ��ư����ǥ��
set cindent             " �ץ�������Ѽ�ư����ǥ��
set backspace=2         " ���Ը��BackSpace�����ο�����
set showmatch           " ���å����б����ǧ
set laststatus=2        " ���ơ������Ԥ�ɽ������
set ignorecase          " �������ִ�������ʸ����ʸ������̤��ʤ�
set wildmode=list:full  " �䴰��ǽ��ͭ���ˤ���
set wildmenu            " �䴰�����ɽ������
set listchars=tab:>-    " Tab������Ū��ɽ��
"set list                " Tab����Ԥ�Ļ벽
set nolist
set shellslash          " �ѥ��Υ��ѥ졼����Хå�����å��夫�饹��å���ˡ�Windows���ѡ�
set ruler               " �롼�顼��ɽ��
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P " ���ơ������Ԥ�ʸ�������ɤȲ��ԥ����ɤ�ɽ��
set incsearch           "�����Ǥ�������ˤ⸡��
set hlsearch            "�����Ǥ�������ˤ⸡��
set showcmd             "�¹���Υ��ޥ��ɽ��
syntax on               "�����������ɤ�ϥ��饤��

" .psgi�ե������perl�ϥ��饤�Ȥˤ���
filetype on
au BufNewFile,BufRead *.psgi set filetype=perl
au BufNewFile,BufRead *.t set filetype=perl

"http://d.hatena.ne.jp/tokuhirom/20101105/1288931525
autocmd BufRead *.sql set filetype=mysql

iab VARH <TMPL_VAR EXPR="html()">
iab VARF <TMPL_VAR EXPR="form()">
iab SELF my $self = shift;
iab UBP #!/usr/bin/env perl
iab USUW use strict;<CR>use warnings;<CR>
iab DUMP use Data::Dumper;<CR>open(DH,\">>/debug.log\");<CR>print DH Dumper();<CR>close(DH);


"�Ȥ��䤹���������֤�
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

NeoBundle 'git://github.com/nakatakeshi/jump2pm.vim.git'

"NeoBundle --end

"Jump2pm --start
noremap fv :call Jump2pm('vne')<ENTER>
noremap fe :call Jump2pm('e')<ENTER>
noremap fn :call Jump2pm('sp')<ENTER>
"noremap ft :call Jump2pm('tabe')<ENTER>
"Jump2pm --end




" UTF-8�΢�����ǥ���������֤�����ʤ��褦�ˤ���
if exists("&ambiwidth")
    set ambiwidth=double
endif

"ʸ�������ɼ�ưȽ��
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
    " iconv��eucJP-ms���б����Ƥ��뤫������å�
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    "iconv��JISX0213���б����Ƥ��뤫������å�
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    "fileencodings����
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
