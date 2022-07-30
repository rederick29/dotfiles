call plug#begin('~/.config/nvim/plugged')

Plug 'navarasu/onedark.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'p00f/clangd_extensions.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

call plug#end()

set number relativenumber
set termguicolors
set nocompatible
set clipboard=unnamedplus
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·
filetype plugin on
syntax on
autocmd BufWritePre * :%s/\s\+$//e
set hidden
set signcolumn=no

" Terminal:
tnoremap <Esc> <C-\><C-n>

autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>

nnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>


lua <<EOF
require("toggleterm").setup{
    -- https://github.com/akinsho/toggleterm.nvim/issues/97#issuecomment-1121232712
    on_open = function(terminal)
        local nvimtree = require "nvim-tree"
        local nvimtree_view = require "nvim-tree.view"
        if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
            local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
            nvimtree.toggle()
            nvimtree_view.View.width = nvimtree_width
            nvimtree.toggle(false, true)
        end
    end
}

EOF

" Indentation: always 4 spaces per <tab>
set ts=4
set softtabstop=-1
set shiftwidth=0
set shiftround
set expandtab
set autoindent
set cpoptions+=I
set smartindent

" Modeline checking
set modeline
set encoding=utf-8

" Onedark Theme:
let g:onedark_config = {
    \ 'style': 'darker',
\}

colorscheme onedark

" Lualine:
lua << EOF
require('lualine').setup {
    options = {
        theme = 'onedark'
    },
    extensions = {
        'nvim-tree',
        'toggleterm'
    }
}
EOF

" Nvim Tree:
lua << EOF
require("nvim-tree").setup{
    hijack_cursor = true,
    view = {
        number = true,
    },
    renderer = {
        indent_markers = {
            enable = true
        }
    }
}
EOF
nmap <C-n> <Cmd>NvimTreeToggle<CR>

" Completion:
let g:coq_settings = { 'auto_start': 'shut-up', 'display.icons.mode': 'none', 'display.preview.border': 'single'}

" this is for syntax highlighting in the preview window of COQ
autocmd Syntax markdown set ft=markdown

" Rust:
lua << EOF
require'lspconfig'.rust_analyzer.setup(require"coq".lsp_ensure_capabilities())
require('rust-tools').setup({})
EOF

" Clangd:
lua << EOF
require'lspconfig'.clangd.setup(require"coq".lsp_ensure_capabilities())
require("clangd_extensions").setup({})
EOF

" Treesitter:
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "rust", "markdown", "markdown_inline" },
    highlight = {
        enable = true,
        adittional_vim_regex_highlighting = false
    }
}
EOF
