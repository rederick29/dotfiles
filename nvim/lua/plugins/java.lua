local java_lsp = {
  "mfussenegger/nvim-jdtls",
  lazy = true,
  ft = {"java"},
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp", -- lsp capabilities
  },
}

return {
    java_lsp
}
