local gruvbox = {
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
        ["@keyword.coroutine.rust"] = { fg = "#fb4934", italic = true },
        ["@lsp.type.label.rust"] = { fg = "#8ec07c" },
        ["@label.rust"] = { fg = "#8ec07c" },
        ["rustModPathSep"] = { fg = "#fe8019" },
        ["rustEscape"] = { fg = "#fe8019" },
      }
    })

    vim.o.background = "dark"
    vim.cmd.colorscheme "gruvbox"

    -- fix colors
    vim.api.nvim_set_hl(0, "SignColumn", { guibg = Dark })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#282828" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
  end,
}

local lualine = {
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

local notify = {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    vim.notify = require("notify")
  end
}

local toggleterm = {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = false,
	dependencies = { "nvim-tree/nvim-tree.lua" },
	config = function()
    -- https://github.com/akinsho/toggleterm.nvim/issues/97#issuecomment-1121232712
    local opts = {
      on_open = function(terminal)
        local nvimtree = require "nvim-tree.api"
        local nvimtree_view = require "nvim-tree.view"
        if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
          local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
          nvimtree.tree.toggle()
          nvimtree_view.View.width = nvimtree_width
          nvimtree.tree.toggle(false, true)
        end
      end
    }
    require("toggleterm").setup(opts)

    vim.cmd([[
"=============================
tnoremap <Esc> <C-\><C-n>

autocmd TermEnter term://*toggleterm#*
\ tnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>

nnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>
"=============================
    ]])
  end
}

local colorizer = {
  "NvChad/nvim-colorizer.lua",
}

local gitsigns = {
  "lewis6991/gitsigns.nvim",
  config = true,
}

return {
  gruvbox,
  lualine,
  gitsigns,
  colorizer,
  toggleterm,
  notify,
}
-- vim: tabstop=2
