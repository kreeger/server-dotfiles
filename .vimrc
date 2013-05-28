" Turn off vi-compatibility mode.
set nocompatible
filetype off
set shell=/bin/sh

" Redefine the leader.
let mapleader=","

" Set some visual options
syntax on
colorscheme benlight
set number " Line numbers!
set ruler " Information bar on bottom-right.
set laststatus=2 " Status bar at bottom is always visible.
set showcmd " Show partial command in the status line.
set linespace=1

" Set some whitespace options
set nowrap
set tabstop=2 " Tabs are two spaces.
set shiftwidth=2 " Same for auto-indents.
set softtabstop=2 " Number of spaces when <tab> is hit.
set expandtab " Tab makes spaces.
set list listchars=tab:\ \ ,trail:·

" Set search options
set hlsearch " Highlight search results.
set incsearch " Search-as-you-type.
set ignorecase " Ignore case of search string/results.
set smartcase " Consider case when ALL CAPS.

" Set tab-completion behavior
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" This is for 256-color mode
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
if filereadable(expand('~/.vim/scripts/vundle.vim'))
  source ~/.vim/scripts/vundle.vim
endif

" NERDTree options
let NERDTreeIgnore=['\.pyc$\', '\.rbc$', '\~$', '\.git$', '\.bundle$', '\.DS_Store']
let NERDTreeShowHidden=1
" Leader-n toggles NERDTree
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeMouseMode=3

" Special settings for Markdown.
function s:setWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=79
endfunction

" Filetype mappings

" Fish
autocmd BufRead,BufNewFile *.fish set ft=fish

" Gemfile/Rakefile/etc is Ruby
autocmd BufRead,BufNewFile {Podfile,Gemfile,Rakefile,Thorfile,Vagrantfile,config.ru,*.rabl} set ft=ruby
autocmd BufRead,BufNewFile *.{jsonify,builder,rabl} set ft=ruby

" Custom text-wrapping options for filetypes
autocmd BufRead,BufNewFile *.{md,markdown,txt,rst} call s:setWrapping()

" JSON is JavaScript
autocmd BufRead,BufNewFile *.json set ft=javascript

" SASS is Sass.
autocmd BufRead,BufNewFile *.{sass,scss} set ft=sass

" Now activate plugin and indention settings for whatever file is loaded
filetype plugin indent on

" Opens an edit command with the path of the currently edited file.
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Syntastic options
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1
let g:syntastic_ruby_exec='ruby19'

" Powerline options.
let g:Powerline_symbols = 'fancy'

" Mac OS X options.
set clipboard=unnamed
let macvim_hig_shift_movement = 1

" Default directories for swap files.
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" A few other conveniences.
" Ctrl-C pops out of insert mode.
cnoremap <C-c> <Esc>

" For Ctrl-P!
nmap ; :CtrlPBuffer<CR>

map <Leader>wq :wq<CR>
map <Leader>q :q!<CR>

map <F3> :vsplit<CR>
map <F4> :nohl<CR>
map <F7> :Gread<CR>
map <F8> :Gstatus<CR>
map <F9> :Gwrite<CR>
map <F10> :Gcommit<CR>
map <F11> :Git push<CR>
map <F12> :Gblame<CR>

