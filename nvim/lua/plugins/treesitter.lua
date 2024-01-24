local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = true,
  ft = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "glsl",
    "html",
    "java",
    "lua",
    "markdown",
    "md",
    "python",
    "rust",
    "vim",
    "query",
  },
  dependencies = { "HiPhish/rainbow-delimiters.nvim" },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "doxygen",
        "glsl",
        "html",
        "java",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "rust",
        "vim",
        "vimdoc",
      },
      highlight = {
        enable = true,
        -- rust TS highlighting is slow slow slow!
        -- also breaks the rainbow delimiters plugin which depends on this
        disable = { "rust" },
        additional_vim_regex_highlighting = false,
      },
    })

    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
  end
}

local treesitter_asm = {
  "rush-rs/tree-sitter-asm",
  ft = { "asm", "vmasm" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.parsers").get_parser_configs().asm = {
      install_info = {
        url = "https://github.com/rush-rs/tree-sitter-asm.git",
        files = { "src/parser.c" },
        branch = "main",
      },
    }
  end
}

local indent_blankline = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",

  -- nicer eye-candy alternative if you can run it
  config = function()
    -- rainbow-delimiters.nvim integration from README
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local opts = {
      -- enabling the scope feature destroys my neovim performance :/
      -- additionally, setting the custom colours with rainbow-delimiters integration destroys it further
      scope = {
        enabled = false,
        highlight = highlight,
      },
    }

    -- highlight groups for rainbow delimiters
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed",   { fg = "#cc241d" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#fabd2f" })
      vim.api.nvim_set_hl(0, "RainbowBlue",  { fg = "#458588" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#d79921" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98971a" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#b16286" })
      vim.api.nvim_set_hl(0, "RainbowCyan",  { fg = "#689d6a" })
    end)

    vim.g.rainbow_delimiters = {
      highlight = highlight,
    }
    require("ibl").setup(opts)

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end
}

-- Custom query to add to the rust parser separately:
-- Description: injects glsl highlighting into vulkano_shaders macro
-- (macro_invocation
--   macro: (scoped_identifier
--     name: (identifier) @_shader (#eq? @_shader "shader"))
--   (token_tree
--     (identifier) @_srcstr (#eq? @_srcstr "src")
--     (raw_string_literal) @injection.content)
--   (#set! injection.language "glsl"))

return {
  treesitter,
  treesitter_asm,
  indent_blankline,
}

-- vim: tabstop=2
