local helpers = require("helpers")
local plugins = {}

plugins.treesitter = {
  lazy = {
    "nvim-treesitter/nvim-treesitter",
    config = ":TSUpdate"
  }
}

plugins.telescope = {
  lazy = {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' }
  }
}

plugins.oil = {
  lazy = {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" }
  }
}

plugins.lspconfig = {
  lazy = { "neovim/nvim-lspconfig" }
}

plugins["actions-preview"] = {
  lazy = { "aznhe21/actions-preview.nvim" }
}

plugins.lightbulb = {
  lazy = { "kosayoda/nvim-lightbulb" }
}

plugins.cmp = {
  lazy = {
    { "hrsh7th/nvim-cmp"
    },
    { "hrsh7th/cmp-buffer"
    },
    { "hrsh7th/cmp-path"
    },
    { "hrsh7th/cmp-cmdline"
    },
    { "hrsh7th/cmp-nvim-lsp"
    },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" }
    },
    { "saadparwaiz1/cmp_luasnip"
    }
  }
}

plugins.Comment = {
  lazy = {
    "numToStr/Comment.nvim",
    config = ":TSUpdate"
  }
}

plugins.autopairs = {
  lazy = { "windwp/nvim-autopairs" }
}

plugins.fidget = {
  lazy = { "j-hui/fidget.nvim" }
}

plugins.linefly = {
  lazy = { "bluz71/nvim-linefly" }
}

plugins.indentmini = {
  lazy = { "nvimdev/indentmini.nvim" }
}

-- plugins["none-ls"] = {
--   lazy = { "nvimtools/none-ls.nvim" }
-- }

-- plugins.ccc = {
--   lazy = { "uga-rosa/ccc.nvim" }
-- }

plugins.scrollfix = {
  lazy = { "vim-scripts/scrollfix" }
}

plugins.leap = {
  lazy = {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" }
  }
}

plugins.gitsigns = {
  lazy = { "lewis6991/gitsigns.nvim" }
}

-- plugins.codeium = {
--   lazy = "Exafunction/codeium.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "hrsh7th/nvim-cmp",
--   },
-- }

for plugin_config_dir, _ in pairs(plugins) do
  helpers.require_if_exist("plugins/" .. plugin_config_dir .. "/options")
end

require("lazy").setup(helpers.reduce_table(plugins, {},
  function(acc, x)
    table.insert(acc, x.lazy)
    return acc
  end
))

for plugin_config_dir, _ in pairs(plugins) do
  helpers.require_if_exist("plugins/" .. plugin_config_dir)
end

for plugin_config_dir, _ in pairs(plugins) do
  helpers.require_if_exist("plugins/" .. plugin_config_dir .. "/highlight")
end
