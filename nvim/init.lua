local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')
require('colorizer').setup()

--- General Options
-- Numberline where current line is always 0
vim.opt.relativenumber = true
-- Force truecolor usage
vim.opt.termguicolors = true
-- Use copy/paste clipboard rather than selection clipboard on linux
vim.opt.clipboard = "unnamedplus"
-- Characters to use when explicitly showing whitespace
vim.opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·"
-- Required by toggleterm
vim.opt.hidden = true
-- Always show the signcolumn
vim.opt.signcolumn = "yes"
-- Allow using mouse in visual mode
vim.opt.mouse = 'v'
-- Keep cursor 5 lines away from bottom/top
vim.opt.scrolloff = 5

--- Indentation
-- Alwas change tab(s) to spaces
vim.opt.expandtab = true
-- Set default tab width to 4 spaces
vim.opt.tabstop = 4
-- (auto)indent using with value of tabstop
vim.opt.shiftwidth = 0
-- Use value of shiftwidth for softtabstop
vim.opt.softtabstop = -1
-- Do smart autoindenting
vim.opt.smartindent = true

-- Remove all trailing whitespace before saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = '*',
  command = [[:%s/\s\+$//e]]
})

--- Map lsp keybinds in normal mode
function set_lsp_keybinds(bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- hover.nvim instead
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gb', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
end

-- Apply LSP keybinds
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Sets custom LSP keybinds",
  callback = function(args) set_lsp_keybinds(args.buf) end
})

-- Apply inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Set Inlay Hints for supported LSP servers",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(args.buf, true)
    end
  end
})

-- vim: tabstop=2
