call plug#begin('~/.config/nvim/plugged')

Plug 'navarasu/onedark.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag': 'v2.*'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'saecki/crates.nvim'
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
" set mouse=a

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

let g:rustfmt_autosave = 1

" LSP:
lua <<EOF
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gb', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
end

local coq = require('coq')
local rust_opts = {
    server = {
        on_attach = on_attach,
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

local c_opts = {
    on_attach = on_attach,
    cmd = {
        "clangd",
        "--background-index",
        "--cross-file-rename",
        "--pch-storage=memory",
        "--clang-tidy",
        "--pretty",
        "--all-scopes-completion",
        "--header-insertion=never",
        "-j=4",
        "--header-insertion-decorators",
    },
    filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto"}
}

require('rust-tools').setup(coq.lsp_ensure_capabilities(rust_opts))
require('lspconfig').clangd.setup(coq.lsp_ensure_capabilities(c_opts))

require('crates').setup {
    src = {
        coq = {
            enabled = true,
            name = "crates.nvim",
        },
    },
}
EOF

" Code navigation shortcuts -- mostly from sharksforarms
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gb    <cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>
nnoremap <silent> g[    <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g]    <cmd>lua vim.diagnostic.goto_next()<CR>

" Treesitter + Brackets:
hi rainbowcol1 guifg=#a0a8b7
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
