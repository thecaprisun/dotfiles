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
   "catppuccin/nvim",
   name = "catppuccin",
   priority = 1000,
   init = function()
     vim.opt.termguicolors = true
     vim.cmd("colorscheme catppuccin")
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

 { "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", 
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", 
    },
 },

 {"neoclide/coc.nvim", lazy = true },


 { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

 { "famiu/feline.nvim", lazy = true },

} --End of plugins to install

--here goes anything that needs require

local opts = {},

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<C-S-p>', builtin.live_grep, {})

require("catppuccin").setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "frappe",
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        coc_nvim = true,
        cmp = true,
        gitsigns = true,
        -- nvimtree = true,
        neotree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

vim.cmd.colorscheme="catppuccin"

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

require("ibl").setup()
--require("coc.nvim").setup()

require("alpha-config")
require("treesitter-config")


local ctp_feline = require('catppuccin.groups.integrations.feline')

require("feline").setup({
    components = ctp_feline.get(),
})

--other configuration that doesn't use require

--add vim.cmd stuff here

vim.cmd("set expandtab")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.cmd("set cursorline")
vim.cmd("nnoremap <C-t> :Neotree<CR>")
vim.cmd("nnoremap q :q<CR>")
vim.cmd("nnoremap <C-z> :undo<CR>")
vim.cmd("nnoremap <C-y> :redo<CR>")
