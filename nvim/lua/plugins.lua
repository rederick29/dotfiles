-- vim: ts=2 sts=2 et
require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "navarasu/onedark.nvim"

  use {
    "neovim/nvim-lspconfig",
    config = function()
      -- Python LSP
      require'lspconfig'.pylsp.setup{}
      vim.diagnostic.config({ signs = false })
    end
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup {
        options = {
          theme = "onedark"
        },
        extensions = {
          "nvim-tree",
          "toggleterm"
        }
      }
    end
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  }

  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
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

  use {
    "simrat39/rust-tools.nvim",
    ft = { "rust", "toml" },
    config = function()
      local rust_opts = {
        server = {
          on_attach = on_attach,
          settings = {
            ["rust-analyzer"] = {
              diagnostics = {
                enable = true,
               -- disabled = {"unresolved-proc-macro"},
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
      local coq = require("coq")
      require("rust-tools").setup(coq.lsp_ensure_capabilities(rust_opts))
    end
  }

  use {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        src = {
          coq = {
            enabled = true,
            name = "crates.nvim",
          },
        },
      }
    end
  }

  use {
    "p00f/clangd_extensions.nvim",
    ft = {"cpp", "c", "objc", "objcpp", "cuda", "proto"},
    config = function()
      local coq = require("coq")
      require("clangd_extensions").setup(coq.lsp_ensure_capabilities())
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    requires = { "p00f/nvim-ts-rainbow" },
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { 'c', "cpp", "rust", "markdown", "markdown_inline" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        rainbow = {
          enable = true,
        }
      }
    end
  }

  use {
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("toggleterm").setup {
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
      vim.cmd([[
      tnoremap <Esc> <C-\><C-n>

      autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>

      nnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>
      ]])
    end
  }

  use {
    "ms-jpq/coq_nvim",
    requires = { "ms-jpq/coq.artifacts", branch = "artifacts" },
    branch = "coq",
    run = "COQdeps",
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup({
        check_ts = true,
        map_bs = false,
        map_cr = false
      })

      local ts_conds = require("nvim-autopairs.ts-conds")

      npairs.add_rules({
        Rule("<", ">", "rust")
        :with_pair(ts_conds.is_not_ts_node({"string","comment"})),
        Rule("<", ">", "cpp")
        :with_pair(ts_conds.is_not_ts_node({"string", "comment"}))
      })

      vim.cmd("hi rainbowcol1 guifg=#a0a8b7")

      -- This has been copy pasted from somewhere online to make it work with code completion
      local remap = vim.api.nvim_set_keymap
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

    end
  }

end)
