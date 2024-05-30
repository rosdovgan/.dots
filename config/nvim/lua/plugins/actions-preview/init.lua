local lhses = require("mappings").lhses
local actions_preview = require("actions-preview")

actions_preview.setup({
  diff = {
    algorithm = "patience",
    ignore_whitespace = true,
  },
  telescope = {},
})

vim.keymap.set({ "v", "n" }, lhses.code_actions,
  actions_preview.code_actions
)
