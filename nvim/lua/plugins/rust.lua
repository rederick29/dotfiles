local rust_tools = {
  "simrat39/rust-tools.nvim",
  lazy = true,
  ft = {"rust"},
  event = {"BufRead Cargo.toml"},
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "hrsh7th/nvim-cmp" -- lsp capabilities
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local opts = {
      server = {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
              enableExperimental = true,
            },
            assist = {
              importEnforceGranularity = true,
              importPrefix = "crate",
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true
              },
            },
            checkOnSave = {
              command = "clippy"
            },
            procMacro = {
              enable = true,
              attributes = {
                enable = true,
              },
            },
          }
        }
      }
    }
    require("rust-tools").setup(opts)
  end,
}

local crates = {
  "saecki/crates.nvim",
  event = {"BufRead Cargo.toml"},
  dependencies = {"nvim-lua/plenary.nvim"},
  opts = {src = {cmp = {enabled = true}}},
  config = true,
}

return {
  rust_tools,
  crates
}
-- vim: tabstop=2
