return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = false,
	after = { "nvim-tree/nvim-tree.lua" },
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
tnoremap <Esc> <C-\><C-n>

autocmd TermEnter term://*toggleterm#*
\ tnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>

nnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    ]])
  end
}
-- vim: tabstop=2
