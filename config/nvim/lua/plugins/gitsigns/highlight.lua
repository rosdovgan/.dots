local helpers = require("helpers")

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    helpers.set_hls_globally({
      GitSignsAdd = { link = "DiagnosticOk" },
      GitSignsChange = { link = "DiagnosticSignWarn" },
      GitSignsDelete = { link = "DiagnosticSignError" },

      GitSignsAddNr = { link = "DiagnosticOk" },
      GitSignsChangeNr = { link = "DiagnosticSignWarn" },
      GitSignsDeleteNr = { link = "DiagnosticSignError" },

      GitSignsAddLn = { link = "DiagnosticOk" },
      GitSignsChangeLn = { link = "DiagnosticWarn" },
      GitSignsDeleteLn = { link = "DiagnosticError" },

      GitSignsAddPreview = { link = "DiagnosticOk" },
      GitSignsDeletePreview = { link = "DiagnosticError" },

      GitSignsCurrentLineBlame = { link = "Comment" },
    })
  end
})
