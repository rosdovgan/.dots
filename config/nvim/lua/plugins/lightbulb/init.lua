local icons = require("icons")

require("nvim-lightbulb").setup({
  autocmd = { enabled = true },
  sign = {
    enabled = true,
    text = icons.diagnostic.Hint
  },
  virtual_text = {
    enabled = false,
    text = icons.diagnostic.Hint
  }
})
