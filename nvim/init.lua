-- vim: ts=2 sts=2 et
require("plugins")

--- Theming
require('onedark').setup {
  style = 'darker'
}
require('onedark').load()

--- General Options
-- Numberline where current line is always 0
vim.opt.relativenumber = true
-- Force truecolor usage
vim.opt.termguicolors = true
-- Use copy/paste clipboard rather than selection clipboard on linux
vim.opt.clipboard = "unnamedplus"
-- Characters to use when explicitly showing whitespace
vim.opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·"
-- Remove all trailing whitespace before saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = '*',
  command = [[:%s/\s\+$//e]]
})
-- Required by toggleterm for toggling multiple windows
vim.opt.hidden = true
-- Always show the signcolumn
vim.opt.signcolumn = "yes"
-- Allow using mouse in visual mode
vim.opt.mouse = 'v'

-- Make coq autostart and change some things
vim.g.coq_settings = {
  ["auto_start"] = "shut-up",
  ["display.icons.mode"] = "none",
  ["display.preview.border"] = "single",
  ["keymap.recommended"] = false
}

-- Fix syntax highlighting in coq preview window
vim.api.nvim_create_autocmd("Syntax", {
  pattern = "markdown",
  command = "set ft=markdown"
})

-- Apply LSP keybinds
vim.api.nvim_create_autocmd("FileType", {
  pattern = '*',
  desc = 'Sets custom LSP keybinds',
  callback = function() set_lsp_keybinds() end
})

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

--- Map lsp keybinds in normal mode
function set_lsp_keybinds()
  if vim.tbl_isempty(vim.lsp.buf_get_clients()) then
    return
  end
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
