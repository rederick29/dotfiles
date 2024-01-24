local snip = {
  "L3MON4D3/LuaSnip",
  lazy = true,
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    require("luasnip").setup()
    local ls = require("luasnip")

    vim.keymap.set({"i", "s"}, "<C-l>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, {silent = true})

    vim.keymap.set({"i", "s"}, "<C-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, {silent = true})

  end
}

local autopairs = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {}
}

local lspkind = {
  "onsails/lspkind.nvim",
  -- newer versions break my config
  commit = "57610d5ab560c073c465d6faf0c19f200cb67e6e",
}

local cmp = {
  "hrsh7th/nvim-cmp",
  lazy = true,
  events = {"BufRead Cargo.toml"},
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    -- "ray-x/lsp_signature.nvim", -- instead of cmp's own signature help
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = false}),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lsp_signature_help" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = require("lspkind").cmp_format({
          maxwidth = 30,
          menu = {}
        })
      },
      enabled = function()
        local context = require("cmp.config.context")
        local disabled = false
        disabled = disabled or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt")
        disabled = disabled or (vim.fn.reg_recording() ~= "")
        disabled = disabled or (vim.fn.reg_executing() ~= "")
        disabled = disabled or context.in_treesitter_capture("comment")
        disabled = disabled or context.in_treesitter_capture("string")
        disabled = disabled or context.in_syntax_group("String")
        return not disabled
      end,
    })

    -- crates.nvim
    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup("CmpSourceCargo", {clear = true}),
      pattern = "Cargo.toml",
      callback = function()
        cmp.setup.buffer({sources = {{name = "crates"}}})
      end,
    })

    -- clangd_extensions.nvim
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"cpp", "c", "objc", "objcpp", "cuda", "proto"},
      callback = function()
        cmp.setup.buffer({sorting = {comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.recently_used,
          require("clangd_extensions.cmp_scores"),
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        }}})
      end,
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }
      }, {
        { name = "cmdline" }
      })
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done()
    )
  end
}

return {
  snip,
  autopairs,
  lspkind,
  cmp,
}
-- vim: tabstop=2
