local session_path = vim.fn.stdpath("data") .. "/last_session.vim"

vim.api.nvim_create_autocmd("VimLeavePre", {
  once = true,
  command = "mks! " .. session_path
})

vim.api.nvim_create_user_command(
  "LastSession",
  ":source " .. session_path,
  {}
)
