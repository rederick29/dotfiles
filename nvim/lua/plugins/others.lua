local lsp_config = {
  "neovim/nvim-lspconfig",
  ft = { "glsl", "asm", "vmasm", "lua" },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "RRethy/vim-illuminate",
  },
  config = function()
    -- GLSL
    require("lspconfig").glsl_analyzer.setup{}

    -- Assembly
    require("lspconfig").asm_lsp.setup{}

    -- Neovim Lua
    require("lspconfig").lua_ls.setup {
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path.."/.luarc.json") and not vim.loop.fs_stat(path.."/.luarc.jsonc") then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT"
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
              }
            }
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true

      end
    }
  end,
}

local illuminate = {
  "RRethy/vim-illuminate",
  lazy = true,
  config = function()
    -- highlight other instances of word under cursor
    require("illuminate").configure({
      providers = {
        "lsp",
      },
      filetypes_denylist = {
        "dirbuf",
        "dirvish",
        "nerdtree",
      },
    })
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3c3836" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3c3836" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#3c3836" })
  end
}

local godbolt = {
  "p00f/godbolt.nvim",
  lazy = true,
  ft = { "c", "cpp", "rust" },
  opts = {
    languages = {
      cpp = { compiler = "g132", options = {} },
      c = { compiler = "cg132", options = {} },
      rust = { compiler = "nightly", options = {} },
    },
    quickfix = {
      enable = true,
      auto_open = false
    },
  },
  config = true,
}

local hover = {
  "lewis6991/hover.nvim",
  lazy = false,
  config = function()
    require("hover").setup {
      init = function()
        -- Require providers
        require("hover.providers.lsp")
        require('hover.providers.gh')
        -- require('hover.providers.gh_user')
        -- require('hover.providers.jira')
        -- require('hover.providers.man')
        require('hover.providers.dictionary')
      end,
      preview_opts = {
        border = 'single'
      },
      -- Whether the contents of a currently open hover window should be moved
      -- to a :h preview-window when pressing the hover keymap.
      preview_window = false,
      title = true,
      mouse_providers = {
        'LSP'
      },
      mouse_delay = 1000
    }

    -- Setup keymaps
    vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
    vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
  end
}

return {
  lsp_config,
  illuminate,
  godbolt,
  hover,
}
-- vim: ts=2
