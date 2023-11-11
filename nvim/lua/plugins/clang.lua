return {
  "p00f/clangd_extensions.nvim",
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp" -- lsp capabilities
  },
  ft = {"cpp", "c", "objc", "objcpp", "cuda", "proto"},
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("lspconfig").clangd.setup{capabilities = capabilities}
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
  end
}
-- vim: tabstop=2
