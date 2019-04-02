"""" Nicolas ASSOUAD
"""" VIM Configuration File

"" No VI compatibility
set nocompatible
filetype off
set backspace=2

syntax on

set autoindent

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

set paste


" Map Tab to Esc and Maj+Tab to Tab
inoremap <Tab> <Esc>
inoremap &lt;S-Tab> <Tab>
vnoremap <Tab> <Esc>
vnoremap &lt;S-Tab> <Tab>


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
