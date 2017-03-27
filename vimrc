" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

"Coloration syntaxique
syntax on

"Indentation automatique
"filetype indent plugin on
set autoindent

"Lisibilite pour une console sur fond noir
set background=dark

"Affiche le numero des lignes
set number

"Affiche les parentheses correspondantes
set showmatch

"Remplace les tabulations par des espaces
set expandtab

set tabstop=2
set shiftwidth=2
set softtabstop=2

"La recherche s'affiche au fur et a mesure qu'elle est tapee
set incsearch

"Coloration de la ligne courante
set cursorline

"Affiche la commande en cours d'ecriture
set showcmd

"Support de la souris
set mouse=a

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

" Autocompletion
set wildmode=longest:full
set wildmenu

" Surligne les resultats d'une recherche
set hlsearch

set noerrorbells
set novisualbell

set encoding=utf8

" Affiche le numero et la colonne du curseur
set ruler


" Prise en charge de Merlin
let g:opamshare = substitute(system('opam config var share'), '\n$', '', '''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" OmniCompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete









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
