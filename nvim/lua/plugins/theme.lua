return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true

      require("gruvbox").setup({
        contrast = "hard",
        overrides = {
          ["@lsp.typemod.method.mutable.rust"] = { underline = true },
          ["@lsp.mod.async"] = { italic = true },
          ["@lsp.type.label.rust"] = { fg = "#8ec07c" },
          ["rustModPathSep"] = { fg = "#fe8019" },
          ["rustEscape"] = { fg = "#fe8019" },
        }
      })

      vim.o.background = "dark"
      vim.cmd.colorscheme "gruvbox"
      -- make the sign column same bg as rest of buffer
      vim.api.nvim_set_hl(0, "SignColumn", { bg = Dark })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
    opts = {
      options = {
        theme = "gruvbox",
      },
      extensions = {
        "nvim-tree",
        "toggleterm",
      },
    },
  }
}
-- vim: tabstop=2
