require("plugins.lazy.download")

-------------------------------------------------------------------------------
-- vim settings

-- oil
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-------------------------------------------------------------------------------
-- settings -------------------------------------------------------------------

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
-- vim.opt.mousescroll = "ver:0,hor:0"
vim.opt.syntax = "on"
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true
vim.opt.cc = "80"
vim.encoding = "UTF-8"
vim.opt.fillchars = { eob = ' ' }

-------------------------------------------------------------------------------
-- statusline -----------------------------------------------------------------

vim.opt.statusline = -- [[%5*%{&ff}%*]] .. -- file format
    [[%4*\ %<%F%*]]  -- full path
    -- [[%1*%=%5l%*]]  .. -- current line
    -- [[%2*/%L%*]]	.. -- total lines
    .. [[%1*%4v\ %*]] -- virtual column number
-- vim.opt.statusline += '%5*%{&ff}%*'

-- set statusline=
-- set statusline +=%1*\ %n\ %*            "buffer number
-- set statusline +=%5*%{&ff}%*            "file format
-- set statusline +=%3*%y%*                "file type
-- set statusline +=%4*\ %<%F%*            "full path
-- set statusline +=%2*%m%*                "modified flag
-- set statusline +=%1*%=%5l%*             "current line
-- set statusline +=%2*/%L%*               "total lines
-- set statusline +=%1*%4v\ %*             "virtual column number
-- set statusline +=%2*0x%04B\ %*          "character under cursor

--vim.opt.clipboard = unnamedplus
--vim.opt.scrolloff = 999

-------------------------------------------------------------------------------
-- mappings -------------------------------------------------------------------

local opts = { noremap = false, silent = true };

vim.g.mapleader = ","

vim.keymap.set("n", "<s-Tab>", ":bnext<cr>", opts)
vim.keymap.set("n", "<Leader><Tab>", ":bprev<cr>", opts)
vim.keymap.set("n", "<Leader>e", ":Oil <cr>", opts)
vim.keymap.set("n", "<Leader>E", ":Oil $PWD<cr>", opts)
-- vim.keymap.set("n", "<Leader>,", ":Format<cr>", opts)
vim.keymap.set("n", "<Leader>q", ":bp | sp | bn | bd<cr>", opts)
vim.keymap.set("v", "<c-c>", "\"+y", opts)

vim.keymap.set({ "n", "v" }, "J", "L", { noremap = true })
vim.keymap.set({ "n", "v" }, "K", "H", { noremap = true })
vim.keymap.set({ "n", "v" }, "H", "0", { noremap = true })
vim.keymap.set({ "n", "v" }, "L", "$", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "\\", ",", { noremap = true })

-------------------------------------------------------------------------------
-- Lazy's managment -----------------------------------------------------------

require("lazy").setup({
  { "nvim-lua/plenary.nvim",
  },

  { "nvim-treesitter/nvim-treesitter",
    config = ":TSUpdate",
  },

  -- telescope
  { "nvim-telescope/telescope.nvim",
    -- tag = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- oil
  { "nvim-tree/nvim-web-devicons",
  },
  { 'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  { "neovim/nvim-lspconfig",
  },
  { "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- dap
  { "mfussenegger/nvim-dap",
  },
  { "jay-babu/mason-nvim-dap.nvim",
  },
  { "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  -- snippets
  { "rafamadriz/friendly-snippets"
  },

  -- cmp
  { "hrsh7th/nvim-cmp",
  },
  { "hrsh7th/cmp-nvim-lsp",
  },
  { "saadparwaiz1/cmp_luasnip",
  },
  { "L3MON4D3/LuaSnip",
  },

  -- tmux
  { "aserowy/tmux.nvim",
  },

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  -- },

  { "vim-scripts/scrollfix",
  },

  { "rhysd/clever-f.vim"
  },

  { "uga-rosa/ccc.nvim",
  },

  { "numToStr/Comment.nvim",
    config = ":TSUpdate",
  },
})

-------------------------------------------------------------------------------
-- Init plugs -----------------------------------------------------------------

local inits = {
  "treesitter",
  "web-devicons",
  "oil",
  "telescope",
  "lspconfig",
  "dap",
  "cmp",
  "null-ls",
  -- "indent-blankline",
  "tmux",
  "ccc",
  "Comment",
}

for _, v in ipairs(inits) do require("plugins/" .. v) end


-------------------------------------------------------------------------------
-- vim plugs settigns ---------------------------------------------------------

vim.g["scrollfix"] = 51
vim.g["scrollinfo"] = 0

-------------------------------------------------------------------------------
-- theme ----------------------------------------------------------------------

require("theme")
