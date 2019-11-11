set nocompatible
syntax on
colorscheme molokai
set autoindent
set number
set ignorecase
set winminheight=0
set hlsearch
set incsearch
set nobackup
set writebackup
set tabstop=4
set sw=4
"set expandtab
set fileformat=unix
set clipboard=unnamed
set guifont=Courier_New:h12:cANSI
set cdpath=d:\work,d:\bw
set guioptions-=T
set guioptions+=a
set fileencodings=utf-8,latin1,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr
filetype indent on

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au BufNewFile,BufRead *.vim set filetype=vim
au GUIEnter * simal ~x
au BufNewFile,BufRead,BufEnter *go set filetype=go
au BufNewFile,BufRead,BufEnter Makefile set noexpandtab

set backspace=indent,eol,start

set statusline=%F\ %c%=\ %{&fileencoding}\ \ %p%%
set laststatus=2

let mapleader = "\\"
"nnoremap <Leader>* :call MultiSearch_Add("\\<".expand("<cword>")."\\>")<CR>
"nnoremap <Leader>+ :call MultiSearch_Add(expand("<cword>"))<CR>
"nnoremap <F11> :call MultiSearch_Search(0)<CR>
"nnoremap <F12> :call MultiSearch_Search(1)<CR>
"nnoremap <Leader>ml :call MultiSearch_List()<CR>

"nnoremap <Leader>] :call Hinter_switchHinterWindow()<CR>

"提示当前工作目录
nnoremap <Leader>pwd :call Hinter_showPrefixWorkDirectory()<CR>
"切换 buffer
nnoremap <C-b> :call Hinter_switchBuffer()<CR>
"跳转到指定函数的定义代码块
nnoremap <C-d> :call Hinter_jumpToDefinationOfFunc()<CR>
"打开一个终端
nnoremap <C-t> :call execute("terminal")<CR>
