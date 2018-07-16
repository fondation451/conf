"execute pathogen#infect()


"""" Nicolas ASSOUAD
"""" VIMRC


" Configuration de base
""""

" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
filetype off                  " required
set backspace=2		" more powerful backspacing

"Coloration syntaxique
syntax on

"Indentation automatique
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

""""

" Configuration spécifique pour le BÉPO
""""

" colorise les espaces insécables
highlight NbSp ctermbg=lightgray guibg=lightred
match NbSp /\%xa0/


" Tab fait un Esc, Maj+Tab fait un Tab
inoremap <Tab> <Esc>
inoremap &lt;S-Tab> <Tab>

" Même chose, mais en mode visuel
vnoremap <Tab> <Esc>
vnoremap &lt;S-Tab> <Tab>

" Changement de demi page en mode normal
" Effacer revient en arrière d'une demi page
" Espace va en avant d'une demi page
noremap <BS> <C-U>
noremap <Space> <C-D>

" Entrée centre la fenêtre sur le curseur
noremap <Return> zz

" Changement d'onglet avec la tabulation
noremap g<Tab> gt
noremap g<S-Tab> gT

" Changement de w en ç pour la navigation mot à mot
noremap ç w
" Raccourci de sauvegarde Ç
noremap Ç :w<cr>

" [HJKL] -> {CTSR}
" ————————————————
" {cr} = « gauche / droite »
noremap c h
noremap r l
" {ts} = « haut / bas »
noremap t j
noremap s k
" {CR} = « haut / bas de l'écran »
noremap C H
noremap R L
" {TS} = « joindre / aide »
"noremap T J
"noremap S K


""""

"""" Vundle Configuration

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'

" Or, if using Vundle
Bundle 'reasonml-editor/vim-reason-plus'


" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
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

""""














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
