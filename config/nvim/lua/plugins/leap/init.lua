local helpers = require("helpers")

helpers.set_keymaps({ 'n', 'x', 'o' }, {}, {
  ["s"] = "<Plug>(leap-forward)",
  ["S"] = "<Plug>(leap-backward)",
  ["gs"] = "<Plug>(leap-from-window)"
})
