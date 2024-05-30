local helpers = require("helpers")

local lhses = {
  leader = ",",
  explorer = "<Leader>e",
  explorer_pwd = "<Leader>E",
  next_buffer = "<Tab>",
  prev_buffer = "<s-Tab>",
  copy = "<c-c>",
  cut = "<c-x>",

  format = "<Leader>,",
  hover = "<Leader>h",
  rename = "<Leader>.",

  find_files = "<Leader>f",
  live_grep = "<Leader>g",
  find_buffers = "<Leader>b",
  find_help = "<Leader>?",
  resume = "<Leader><Tab>",

  code_actions = "<Leader>a",

  find_references = "<Leader>r",
  find_definitions = "<Leader>d",
  find_implementations = "<Leader>i",
  find_type_definitions = "<Leader>t",

  tmux_next_pane = "<m-l>",
  tmux_prev_pane = "<m-h>",
  tmux_resize_pane_left = "<m-j>",
  tmux_resize_pane_right = "<m-k>",
  tmux_resize_pane_down = "<c-m-j>",
  tmux_resize_pane_up = "<c-m-k>"
}

vim.g.mapleader = lhses.leader

helpers.set_keymaps({ "n", "v" }, { silent = true }, {
  [lhses.explorer] = ":Oil<CR>",
  [lhses.explorer_pwd] = ":Oil $PWD<CR>",
})

helpers.set_keymaps({ "n" }, { silent = true }, {
  [lhses.next_buffer] = ":bnext<CR>",
  [lhses.prev_buffer] = ":bprev<CR>",
})

helpers.set_keymaps({ "v" }, { silent = true }, {
  [lhses.copy] = "\"+y",
  [lhses.cut] = "\"+d",
})

helpers.set_keymaps({ "n", "v" }, { noremap = true }, {
  ["J"] = "L",
  ["0"] = "J",
  ["K"] = "H",
  ["H"] = "0",
  ["L"] = "$",
  ["$"] = "K"
})

return { lhses = lhses }
