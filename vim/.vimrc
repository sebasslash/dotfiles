set exrc
set secure

set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set colorcolumn=110


augroup project 
	autocmd!
	autocmd BufRead, BufNewFile *h, *.c, *.cpp set filetype=c.doxygen
augroup END




let &path.="src/include, /usr/include/AL,"

set makeprg=make\ -C\ ../build\ -j9
nnoremap <F4> :make!<cr>

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tclem/vim-arduino'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

call vundle#end()            " required
filetype plugin indent on    " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line	

" KEYMAPS
map <C-n> :NERDTreeToggle<CR> 

"Themes
syntax on
colorscheme thaumaturge

"Extra YCM Configs
let g:ycm_python_binary_path = 'python'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"



set laststatus=2
set term=xterm-256color
set termencoding=utf-8
set guifont=Ubuntu\ Mono\ derivative\ Powerline:10
" set guifont=Ubuntu\ Mono
let g:Powerline_symbols = 'fancy'


au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
