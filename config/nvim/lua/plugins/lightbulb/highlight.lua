local helpers = require("helpers")

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    helpers.set_hls_globally({
      LightBulbSign = { link = "DiagnosticVirtualTextHint" },
      LightBulbVirtualText = { link = "DiagnosticVirtualTextHint" }
    })
  end
})
