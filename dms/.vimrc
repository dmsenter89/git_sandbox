" Some usefil .vimrc settings
" Michael Senter
"
" Some good plugins (install for archlinux):
" pacman -S vim-a vim-airline vim-fugitive vim-minibufexpl vim-nerdtree vim-tagbar
" 
" Some good web resources:
" - https://rumorscity.com/wp-content/uploads/2014/08/10-Best-VIM-Cheat-Sheet-02.jpg
" - https://danielmiessler.com/study/vim/

set nocompatible            " we want vim, not vi

filetype plugin indent on   " load plugins based on filetype
syntax on		    " syntax highlighting on

set cursorline              " show which line I'm on
set number                  " show line numbers

set autoindent		    " use previous line for indentation
set expandtab	            " use space instead of tab
set softtabstop=4	    " 4 spaces / tab
set shiftwidth=4	    " >> indents 4 spaces
set shiftround			

set backspace=2             " recommmended online   

set hidden		    " no need to save before switching buffers
set autoread                " automatically reload on external file changes


" some neat things from https://docs.j7k6.org/my-minimal-vimrc/
"let mapleader=','                                " leader key
"nnoremap <leader>, :let @/=''<cr>:noh<cr>|       " clear search
cnoreabbrev w!! w !sudo tee > /dev/null %|       " write file with sudo

" this line requires tagbar
nmap <F8> :TagbarToggle<CR>
" this line requires nerdtree
nmap <F2> :NERDTreeToggle<CR>
