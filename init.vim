call plug#begin('~/.config/nvim/plugged')

Plug 'navarasu/onedark.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag': 'v2.*'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'p00f/clangd_extensions.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq', 'do': ':COQdeps'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'windwp/nvim-autopairs'
Plug 'p00f/nvim-ts-rainbow'

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
let g:coq_settings = { 'auto_start': 'shut-up', 'display.icons.mode': 'none', 'display.preview.border': 'single', 'keymap.recommended': v:false }

" this is for syntax highlighting in the preview window of COQ
autocmd Syntax markdown set ft=markdown

" LSP:
lua << EOF
local coq = require('coq')
local opts = {
    server = {
        settings = {
            ["rust-analyzer"] = {
                diagnostics = {
                   enable = true,
                   disabled = {"unresolved-proc-macro"},
                   enableExperimental = true,
                },
                assist = {
                    importEnforceGranularity = true,
                    importPrefix = "crate"
                },
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    buildScripts = {
                        enable = true
                    }
                },
                checkOnSave = {
                    command = "clippy"
                },
                procMacro = {
                    enable = true,
                    attributes = {
                        enable = true
                    }
                },
            }
        }
    }
}
require('rust-tools').setup(coq.lsp_ensure_capabilities(opts))
require('lspconfig').clangd.setup(coq.lsp_ensure_capabilities())
require("clangd_extensions").setup({})
EOF

" Code navigation shortcuts -- mostly from sharksforarms
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gb    <cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>
nnoremap <silent> g[    <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g]    <cmd>lua vim.diagnostic.goto_next()<CR>

" Treesitter + Brackets:
lua << EOF
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "rust", "markdown", "markdown_inline" },
    highlight = {
        enable = true,
        adittional_vim_regex_highlighting = false
    },
    rainbow = {
        enable = true,
    }
}

npairs.setup({ map_bs = false, map_cr = false })

remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

_G.MUtils= {}

MUtils.CR = function()
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
            return npairs.esc('<c-y>')
        else
            return npairs.esc('<c-e>') .. npairs.autopairs_cr()
        end
    else
        return npairs.autopairs_cr()
    end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
        return npairs.esc('<c-e>') .. npairs.autopairs_bs()
    else
        return npairs.autopairs_bs()
    end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
EOF
