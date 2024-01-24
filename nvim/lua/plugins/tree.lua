return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {"nvim-tree/nvim-web-devicons"},
  config = function()
    require("nvim-tree").setup {
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
    vim.api.nvim_set_keymap('n', "<C-n>", "<Cmd>NvimTreeToggle<CR>", {})
  end
}
-- vim: tabstop=2
