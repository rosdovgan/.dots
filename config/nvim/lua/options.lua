local helpers = require("helpers")

helpers.set_options({
  -- clipboard = "unnamedplus",
  undofile = true,
  ignorecase = true,
  showmode = false,
  smartindent = true,
  swapfile = false,
  hidden = true, --default on
  cmdheight = 0,
  cursorcolumn = false,
  numberwidth = 4,
  scrolloff = 8,
  updatetime = 50, -- faster completion (4000ms default)

  number = true,
  relativenumber = true,
  signcolumn = "yes:1",
  mouse = "a",
  autoindent = true,
  expandtab = true,
  tabstop = 2,    --insert 2 spaces for a tab
  --softtabstop = 2
  shiftwidth = 2, --insert 2 spaces for each indentation
  -- syntax = "on",
  wrap = false,
  termguicolors = true,
  cc = "80",
  fillchars = { eob = ' ' },
  sessionoptions = "buffers,tabpages,winsize",
  list = true,
  listchars = "tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:○"
})
