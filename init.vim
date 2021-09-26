call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/syntastic'

Plug 'valloric/youcompleteme'

Plug 'rust-lang/rust.vim'

Plug 'cdelledonne/vim-cmake'

call plug#end()

set number

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:synstastic_cpp_checkers = ['clang_check', 'clang_tidy']
let g:synstastic_c_checkers = ['clang_check', 'clang_tidy']

let g:ycm_show_diagnostics_ui = 0

syntax enable
colorscheme gruvbox
filetype plugin indent on

