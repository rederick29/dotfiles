-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/erickv/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/erickv/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/erickv/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/erickv/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/erickv/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["clangd_extensions.nvim"] = {
    config = { "\27LJ\2\2o\0\0\3\0\5\0\v6\0\0\0'\1\1\0B\0\2\0026\1\0\0'\2\2\0B\1\2\0029\1\3\0019\2\4\0B\2\1\0A\1\0\1K\0\1\0\28lsp_ensure_capabilities\nsetup\22clangd_extensions\bcoq\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/opt/clangd_extensions.nvim",
    url = "https://github.com/p00f/clangd_extensions.nvim"
  },
  ["coq.artifacts"] = {
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/coq.artifacts",
    url = "https://github.com/ms-jpq/coq.artifacts"
  },
  coq_nvim = {
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/coq_nvim",
    url = "https://github.com/ms-jpq/coq_nvim"
  },
  ["crates.nvim"] = {
    after_files = { "/home/erickv/.local/share/nvim/site/pack/packer/opt/crates.nvim/after/plugin/cmp_crates.lua" },
    config = { "\27LJ\2\2s\0\0\4\0\b\0\v6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\6\0005\2\4\0005\3\3\0=\3\5\2=\2\a\1B\0\2\1K\0\1\0\bsrc\1\0\0\bcoq\1\0\0\1\0\2\fenabled\2\tname\16crates.nvim\nsetup\vcrates\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/opt/crates.nvim",
    url = "https://github.com/saecki/crates.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\2‰\1\0\0\3\0\b\0\v6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\1B\0\2\1K\0\1\0\15extensions\1\3\0\0\14nvim-tree\15toggleterm\foptions\1\0\0\1\0\1\ntheme\fonedark\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\2æ\1\0\0\2\1\n\2!6\0\0\0009\0\1\0009\0\2\0B\0\1\2\b\0\0\0X\0\23€6\0\0\0009\0\1\0009\0\3\0005\1\4\0B\0\2\0029\0\5\0\b\0\1\0X\0\5€-\0\0\0009\0\6\0'\1\a\0D\0\2\0X\0\r€-\0\0\0009\0\6\0'\1\b\0B\0\2\2-\1\0\0009\1\t\1B\1\1\2&\0\1\0L\0\2\0X\0\3€-\0\0\0009\0\t\0D\0\1\0K\0\1\0\0À\17autopairs_cr\n<c-e>\n<c-y>\besc\rselected\1\2\0\0\rselected\18complete_info\15pumvisible\afn\bvim\0þÿÿÿ\31Ä\1\0\0\2\1\n\1\0286\0\0\0009\0\1\0009\0\2\0B\0\1\2\b\0\0\0X\0\18€6\0\0\0009\0\1\0009\0\3\0005\1\4\0B\0\2\0029\0\5\0\a\0\6\0X\0\n€-\0\0\0009\0\a\0'\1\b\0B\0\2\2-\1\0\0009\1\t\1B\1\1\2&\0\1\0L\0\2\0X\0\3€-\0\0\0009\0\t\0D\0\1\0K\0\1\0\0À\17autopairs_bs\n<c-e>\besc\teval\tmode\1\2\0\0\tmode\18complete_info\15pumvisible\afn\bvim\0ã\a\1\0\t\0-\1c6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\0016\0\0\0'\1\1\0B\0\2\0026\1\0\0'\2\3\0B\1\2\0029\2\2\0005\3\4\0B\2\2\0016\2\0\0'\3\5\0B\2\2\0029\3\6\0004\4\3\0\18\5\1\0'\6\a\0'\a\b\0'\b\t\0B\5\4\2\18\6\5\0009\5\n\0059\a\v\0025\b\f\0B\a\2\0A\5\1\2>\5\1\4\18\5\1\0'\6\a\0'\a\b\0'\b\r\0B\5\4\2\18\6\5\0009\5\n\0059\a\v\0025\b\14\0B\a\2\0A\5\1\0?\5\0\0B\3\2\0016\3\15\0009\3\16\3'\4\17\0B\3\2\0016\3\15\0009\3\18\0039\3\19\3\18\4\3\0'\5\20\0'\6\21\0'\a\22\0005\b\23\0B\4\5\1\18\4\3\0'\5\20\0'\6\24\0'\a\25\0005\b\26\0B\4\5\1\18\4\3\0'\5\20\0'\6\27\0'\a\28\0005\b\29\0B\4\5\1\18\4\3\0'\5\20\0'\6\30\0'\a\31\0005\b \0B\4\5\0016\4!\0004\5\0\0=\5\"\0046\4\"\0003\5$\0=\5#\4\18\4\3\0'\5\20\0'\6%\0'\a&\0005\b'\0B\4\5\0016\4\"\0003\5)\0=\5(\4\18\4\3\0'\5\20\0'\6*\0'\a+\0005\b,\0B\4\5\0012\0\0€K\0\1\0\1\0\2\texpr\2\fnoremap\2\22v:lua.MUtils.BS()\t<bs>\0\aBS\1\0\2\texpr\2\fnoremap\2\22v:lua.MUtils.CR()\t<cr>\0\aCR\vMUtils\a_G\1\0\2\texpr\2\fnoremap\2$pumvisible() ? \"<c-p>\" : \"<bs>\"\f<s-tab>\1\0\2\texpr\2\fnoremap\2%pumvisible() ? \"<c-n>\" : \"<tab>\"\n<tab>\1\0\2\texpr\2\fnoremap\2*pumvisible() ? \"<c-e><c-c>\" : \"<c-c>\"\n<c-c>\1\0\2\texpr\2\fnoremap\2*pumvisible() ? \"<c-e><esc>\" : \"<esc>\"\n<esc>\6i\20nvim_set_keymap\bapi!hi rainbowcol1 guifg=#a0a8b7\bcmd\bvim\1\3\0\0\vstring\fcomment\bcpp\1\3\0\0\vstring\fcomment\19is_not_ts_node\14with_pair\trust\6>\6<\14add_rules\28nvim-autopairs.ts-conds\1\0\3\vmap_bs\1\rcheck_ts\2\vmap_cr\1\24nvim-autopairs.rule\nsetup\19nvim-autopairs\frequire\5€€À™\4\0" },
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\2ó\1\0\0\5\0\16\0\0216\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0=\2\5\0015\2\a\0005\3\6\0=\3\b\2=\2\t\1B\0\2\0016\0\n\0009\0\v\0009\0\f\0'\1\r\0'\2\14\0'\3\15\0004\4\0\0B\0\5\1K\0\1\0\28<Cmd>NvimTreeToggle<CR>\n<C-n>\6n\20nvim_set_keymap\bapi\bvim\rrenderer\19indent_markers\1\0\0\1\0\1\venable\2\tview\1\0\1\vnumber\2\1\0\1\18hijack_cursor\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\2è\1\0\0\3\0\n\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\0015\2\b\0=\2\t\1B\0\2\1K\0\1\0\frainbow\1\0\1\venable\2\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\0\1\6\0\0\6c\bcpp\trust\rmarkdown\20markdown_inline\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "https://github.com/navarasu/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\2–\4\0\0\6\0\29\0%5\0\22\0005\1\0\0006\2\1\0=\2\1\0015\2\19\0005\3\5\0005\4\2\0005\5\3\0=\5\4\4=\4\6\0035\4\a\0=\4\b\0035\4\t\0005\5\n\0=\5\v\4=\4\f\0035\4\r\0=\4\14\0035\4\15\0005\5\16\0=\5\17\4=\4\18\3=\3\20\2=\2\21\1=\1\23\0006\1\24\0'\2\25\0B\1\2\0026\2\24\0'\3\26\0B\2\2\0029\2\27\0029\3\28\1\18\4\0\0B\3\2\0A\2\0\1K\0\1\0\28lsp_ensure_capabilities\nsetup\15rust-tools\bcoq\frequire\vserver\1\0\0\rsettings\18rust-analyzer\1\0\0\14procMacro\15attributes\1\0\1\venable\2\1\0\1\venable\2\16checkOnSave\1\0\1\fcommand\vclippy\ncargo\17buildScripts\1\0\1\venable\2\1\0\2\25loadOutDirsFromCheck\2\16allFeatures\2\vassist\1\0\2\17importPrefix\ncrate\29importEnforceGranularity\2\16diagnostics\1\0\0\rdisabled\1\2\0\0\26unresolved-proc-macro\1\0\2\23enableExperimental\2\venable\2\14on_attach\1\0\0\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/opt/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\2ä\1\0\1\a\0\r\0\0286\1\0\0'\2\1\0B\1\2\0026\2\0\0'\3\2\0B\2\2\0029\3\3\2B\3\1\2\15\0\3\0X\4\17€9\3\4\0\a\3\5\0X\3\14€6\3\6\0009\3\a\0039\3\b\0039\4\t\2B\4\1\0A\3\0\0029\4\n\1B\4\1\0019\4\v\2=\3\f\0049\4\n\1+\5\1\0+\6\2\0B\4\3\1K\0\1\0\nwidth\tView\vtoggle\14get_winnr\rwinwidth\afn\bvim\15horizontal\14direction\15is_visible\19nvim-tree.view\14nvim-tree\frequireÅ\2\1\0\3\0\t\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0003\2\3\0=\2\5\1B\0\2\0016\0\6\0009\0\a\0'\1\b\0B\0\2\1K\0\1\0à\1      tnoremap <Esc> <C-\\><C-n>\n\n      autocmd TermEnter term://*toggleterm#*\n      \\ tnoremap <silent><c-`> <Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n\n      nnoremap <silent><c-`> <Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n      \bcmd\bvim\fon_open\1\0\0\0\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/erickv/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\2è\1\0\0\3\0\n\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\0015\2\b\0=\2\t\1B\0\2\1K\0\1\0\frainbow\1\0\1\venable\2\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\0\1\6\0\0\6c\bcpp\trust\rmarkdown\20markdown_inline\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\2‰\1\0\0\3\0\b\0\v6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\1B\0\2\1K\0\1\0\15extensions\1\3\0\0\14nvim-tree\15toggleterm\foptions\1\0\0\1\0\1\ntheme\fonedark\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\2ó\1\0\0\5\0\16\0\0216\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0=\2\5\0015\2\a\0005\3\6\0=\3\b\2=\2\t\1B\0\2\0016\0\n\0009\0\v\0009\0\f\0'\1\r\0'\2\14\0'\3\15\0004\4\0\0B\0\5\1K\0\1\0\28<Cmd>NvimTreeToggle<CR>\n<C-n>\6n\20nvim_set_keymap\bapi\bvim\rrenderer\19indent_markers\1\0\0\1\0\1\venable\2\tview\1\0\1\vnumber\2\1\0\1\18hijack_cursor\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\2æ\1\0\0\2\1\n\2!6\0\0\0009\0\1\0009\0\2\0B\0\1\2\b\0\0\0X\0\23€6\0\0\0009\0\1\0009\0\3\0005\1\4\0B\0\2\0029\0\5\0\b\0\1\0X\0\5€-\0\0\0009\0\6\0'\1\a\0D\0\2\0X\0\r€-\0\0\0009\0\6\0'\1\b\0B\0\2\2-\1\0\0009\1\t\1B\1\1\2&\0\1\0L\0\2\0X\0\3€-\0\0\0009\0\t\0D\0\1\0K\0\1\0\0À\17autopairs_cr\n<c-e>\n<c-y>\besc\rselected\1\2\0\0\rselected\18complete_info\15pumvisible\afn\bvim\0þÿÿÿ\31Ä\1\0\0\2\1\n\1\0286\0\0\0009\0\1\0009\0\2\0B\0\1\2\b\0\0\0X\0\18€6\0\0\0009\0\1\0009\0\3\0005\1\4\0B\0\2\0029\0\5\0\a\0\6\0X\0\n€-\0\0\0009\0\a\0'\1\b\0B\0\2\2-\1\0\0009\1\t\1B\1\1\2&\0\1\0L\0\2\0X\0\3€-\0\0\0009\0\t\0D\0\1\0K\0\1\0\0À\17autopairs_bs\n<c-e>\besc\teval\tmode\1\2\0\0\tmode\18complete_info\15pumvisible\afn\bvim\0ã\a\1\0\t\0-\1c6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\0016\0\0\0'\1\1\0B\0\2\0026\1\0\0'\2\3\0B\1\2\0029\2\2\0005\3\4\0B\2\2\0016\2\0\0'\3\5\0B\2\2\0029\3\6\0004\4\3\0\18\5\1\0'\6\a\0'\a\b\0'\b\t\0B\5\4\2\18\6\5\0009\5\n\0059\a\v\0025\b\f\0B\a\2\0A\5\1\2>\5\1\4\18\5\1\0'\6\a\0'\a\b\0'\b\r\0B\5\4\2\18\6\5\0009\5\n\0059\a\v\0025\b\14\0B\a\2\0A\5\1\0?\5\0\0B\3\2\0016\3\15\0009\3\16\3'\4\17\0B\3\2\0016\3\15\0009\3\18\0039\3\19\3\18\4\3\0'\5\20\0'\6\21\0'\a\22\0005\b\23\0B\4\5\1\18\4\3\0'\5\20\0'\6\24\0'\a\25\0005\b\26\0B\4\5\1\18\4\3\0'\5\20\0'\6\27\0'\a\28\0005\b\29\0B\4\5\1\18\4\3\0'\5\20\0'\6\30\0'\a\31\0005\b \0B\4\5\0016\4!\0004\5\0\0=\5\"\0046\4\"\0003\5$\0=\5#\4\18\4\3\0'\5\20\0'\6%\0'\a&\0005\b'\0B\4\5\0016\4\"\0003\5)\0=\5(\4\18\4\3\0'\5\20\0'\6*\0'\a+\0005\b,\0B\4\5\0012\0\0€K\0\1\0\1\0\2\texpr\2\fnoremap\2\22v:lua.MUtils.BS()\t<bs>\0\aBS\1\0\2\texpr\2\fnoremap\2\22v:lua.MUtils.CR()\t<cr>\0\aCR\vMUtils\a_G\1\0\2\texpr\2\fnoremap\2$pumvisible() ? \"<c-p>\" : \"<bs>\"\f<s-tab>\1\0\2\texpr\2\fnoremap\2%pumvisible() ? \"<c-n>\" : \"<tab>\"\n<tab>\1\0\2\texpr\2\fnoremap\2*pumvisible() ? \"<c-e><c-c>\" : \"<c-c>\"\n<c-c>\1\0\2\texpr\2\fnoremap\2*pumvisible() ? \"<c-e><esc>\" : \"<esc>\"\n<esc>\6i\20nvim_set_keymap\bapi!hi rainbowcol1 guifg=#a0a8b7\bcmd\bvim\1\3\0\0\vstring\fcomment\bcpp\1\3\0\0\vstring\fcomment\19is_not_ts_node\14with_pair\trust\6>\6<\14add_rules\28nvim-autopairs.ts-conds\1\0\3\vmap_bs\1\rcheck_ts\2\vmap_cr\1\24nvim-autopairs.rule\nsetup\19nvim-autopairs\frequire\5€€À™\4\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\2ä\1\0\1\a\0\r\0\0286\1\0\0'\2\1\0B\1\2\0026\2\0\0'\3\2\0B\2\2\0029\3\3\2B\3\1\2\15\0\3\0X\4\17€9\3\4\0\a\3\5\0X\3\14€6\3\6\0009\3\a\0039\3\b\0039\4\t\2B\4\1\0A\3\0\0029\4\n\1B\4\1\0019\4\v\2=\3\f\0049\4\n\1+\5\1\0+\6\2\0B\4\3\1K\0\1\0\nwidth\tView\vtoggle\14get_winnr\rwinwidth\afn\bvim\15horizontal\14direction\15is_visible\19nvim-tree.view\14nvim-tree\frequireÅ\2\1\0\3\0\t\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0003\2\3\0=\2\5\1B\0\2\0016\0\6\0009\0\a\0'\1\b\0B\0\2\1K\0\1\0à\1      tnoremap <Esc> <C-\\><C-n>\n\n      autocmd TermEnter term://*toggleterm#*\n      \\ tnoremap <silent><c-`> <Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n\n      nnoremap <silent><c-`> <Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n      \bcmd\bvim\fon_open\1\0\0\0\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType objc ++once lua require("packer.load")({'clangd_extensions.nvim'}, { ft = "objc" }, _G.packer_plugins)]]
vim.cmd [[au FileType toml ++once lua require("packer.load")({'rust-tools.nvim'}, { ft = "toml" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'rust-tools.nvim'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType objcpp ++once lua require("packer.load")({'clangd_extensions.nvim'}, { ft = "objcpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType proto ++once lua require("packer.load")({'clangd_extensions.nvim'}, { ft = "proto" }, _G.packer_plugins)]]
vim.cmd [[au FileType cuda ++once lua require("packer.load")({'clangd_extensions.nvim'}, { ft = "cuda" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'clangd_extensions.nvim'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'clangd_extensions.nvim'}, { ft = "cpp" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead Cargo.toml ++once lua require("packer.load")({'crates.nvim'}, { event = "BufRead Cargo.toml" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
