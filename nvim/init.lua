vim.cmd("set number")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end 
vim.opt.rtp:prepend(lazypath)


local plugins = {
 
  { 
   "folke/tokyonight.nvim",
   name = "tokyonight",
   priority = 1000,
   init = function()
     vim.opt.termguicolors = true
     vim.cmd("colorscheme tokyonight")
   end, 
 },

 { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"} ,

 {
   "folke/noice.nvim",
   event = "VeryLazy",
   dependencies = {
     "MunifTanjim/nui.nvim",
     "rcarriga/nvim-notify",
     }
     
 },

 {
   'nvim-telescope/telescope.nvim', tag = '0.1.5',
     dependencies = { 'nvim-lua/plenary.nvim' },
 },

 {
   'goolord/alpha-nvim',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
  end
 },
 
 {'romgrk/barbar.nvim',
  dependencies = {
  'lewis6991/gitsigns.nvim', 
  'nvim-tree/nvim-web-devicons', 
  },
  init = function() vim.g.barbar_auto_setup = false end,
    version = '^1.0.0', 
 },

 {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  dependencies = {
      'nvim-tree/nvim-web-devicons',
     },
 },

 {'hrsh7th/nvim-cmp',
  dependencies = {
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
    },
 },

 { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  { 'itchyny/lightline.vim'}

} --End of plugins to install

--here goes anything that needs require

local opts = {},

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<C-S-p>', builtin.live_grep, {})

require("tokyonight").setup()
vim.cmd.colorscheme="tokyonight"

require("noice").setup({
  lsp = {
        override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, 
    },
  },
    presets = {
    bottom_search = true,
    command_palette = true, 
    long_message_to_split = true,    
    inc_rename = false, 
    lsp_doc_border = false,
  },
})

require("nvim-tree").setup({

  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("ibl").setup()

require("tokyonight").setup({
  style = "moon", 
  light_style = "day",
  transparent = true,
  terminal_colors = true, 
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "dark", 
      floats = "dark",
  },
  sidebars = { "qf", "help" }, 
  day_brightness = 0.3, 
  hide_inactive_statusline = false, 
  dim_inactive = false, 
  lualine_bold = false,
  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
})

require("alpha-config")
require("treesitter-config")

--other configuration that doesn't use require

--add vim.cmd stuff here

vim.cmd("colorscheme tokyonight-moon")
vim.cmd("set expandtab")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.cmd("set cursorline")
vim.cmd("nnoremap <C-t> :NvimTreeToggle<CR>")
vim.cmd("nnoremap q :q<CR>")
