"""" Nicolas ASSOUAD
"""" VIM Configuration File

"" No VI compatibility
set nocompatible
filetype off
set backspace=2


"" Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'pangloss/vim-javascript'

Plugin 'othree/javascript-libraries-syntax.vim'

Plugin 'eslint/eslint'

Plugin 'vim-syntastic/syntastic'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line




syntax on

"" No indentation
""set autoindent
""set smartindent

"" Dark consol color scheme
set background=dark

"" Show line number
set number

"" Show matching parenthesis
set showmatch

"" Replace tab by space
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

"" Incremental search
set incsearch

"" Line highlight
set cursorline

"" Show current command
set showcmd

"" Mouse support
set mouse=a

"" Autocompletion
set wildmode=longest:full
set wildmenu

"" Highlight search results
set hlsearch

"" Remove bells
set noerrorbells
set novisualbell

set encoding=utf-8

" Show column and row number
set ruler

" Show a statusline
set laststatus=2
set statusline=CWD:\ %r%{getcwd()}%h\ \ %F%m\ Line:\ %l,%v

" Save last status
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Map Tab to Esc and Maj+Tab to Tab
inoremap <Tab> <Esc>
inoremap &lt;S-Tab> <Tab>
vnoremap <Tab> <Esc>
vnoremap &lt;S-Tab> <Tab>

"" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" coloration des espaces de fin de ligne
""""

if exists('loaded_trailing_whitespace_plugin') | finish | endif
let loaded_trailing_whitespace_plugin = 1

if !exists('g:extra_whitespace_ignored_filetypes')
    let g:extra_whitespace_ignored_filetypes = []
endif

function! ShouldMatchWhitespace()
    for ft in g:extra_whitespace_ignored_filetypes
        if ft ==# &filetype | return 0 | endif
    endfor
    return 1
endfunction

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight default ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight default ExtraWhitespace ctermbg=red guibg=red
autocmd BufRead,BufNew * if ShouldMatchWhitespace() | match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/ | else | match ExtraWhitespace /^^/ | endif

" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * if ShouldMatchWhitespace() | match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/ | endif
autocmd InsertEnter * if ShouldMatchWhitespace() | match ExtraWhitespace /\\\@<![\u3000[:space:]]\+\%#\@<!$/ | endif

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\\\@<!\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

""""
