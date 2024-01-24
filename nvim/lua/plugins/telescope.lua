local telescope_fzf_native = {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make",
}

local telescope = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  config = function()
    require("telescope").setup()
    require("telescope").load_extension("fzf")
  end
}

local dressing = {
  "stevearc/dressing.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  lazy = false,
  opts = {},
}

return {
  telescope_fzf_native,
  telescope,
  dressing,
}
-- vim: ts=2
