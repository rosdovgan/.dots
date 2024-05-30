local helpers = require("helpers")

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    helpers.set_hls_globally({
      IndentLine = { link = "LineNrAbove" },
      IndentLineCurrent = { link = "PreProc" }
    })
  end
})

