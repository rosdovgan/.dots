local helpers = require("helpers")
local icons = require("icons")

helpers.set_options({
  termguicolors = true,
  laststatus = 3
})

helpers.set_globals({
  linefly_options = {
    separator_symbol = icons.misc.Statusline_separator,
    error_symbol = icons.error,
    warning_symbol = icons.warn,
    information_symbol = icons.info,
    with_lsp_status = false
  }
})
