local lipPath = vim.fn.stdpath("data") .. "/site/lua/LIP.lua"
if not vim.loop.fs_stat(lipPath) then
  vim.fn.system({
    "curl",
   "-LJ",
    "https://raw.githubusercontent.com/Dynodzzo/Lua_INI_Parser/master/LIP.lua",
    "--create-dirs",
    "-o",
    lipPath,
  })
end

local function getXdgConfigHome()
  local envVar = "$XDG_CONFIG_HOME"
  local configPath = vim.fn.expand("$XDG_CONFIG_HOME")
  if envVar == configPath then
    configPath = vim.fn.expand("~") .. "/.config/"
  end
  return configPath
end

local LIP = require("LIP")

local ini = LIP.load(getXdgConfigHome() .. "/user/user.ini")
local colors = ini.colors

vim.cmd("colorscheme default")

local bg = colors.black;
local fg = colors.pureWhite;

vim.api.nvim_set_hl(0, "Comment", { fg = colors.gray });

vim.api.nvim_set_hl(0, "Statement", { fg = colors.blue });
vim.api.nvim_set_hl(0, "Keyword", { fg = colors.lighterOrange });
vim.api.nvim_set_hl(0, "Operator", { fg = colors.lighterOrange });

vim.api.nvim_set_hl(0, "Special", { fg = colors.lightViolet });
vim.api.nvim_set_hl(0, "Delimiter", { fg = colors.lightGray });

vim.api.nvim_set_hl(0, "String", { fg = colors.lightestGreen });
vim.api.nvim_set_hl(0, "Number", { fg = colors.lightestGreen });

vim.api.nvim_set_hl(0, "Function", { fg = colors.blue });
vim.api.nvim_set_hl(0, "Identifier", { fg = fg });

vim.api.nvim_set_hl(0, "PreProc", { fg = colors.lightGray });
vim.api.nvim_set_hl(0, "Include", { fg = colors.darkBlue });
vim.api.nvim_set_hl(0, "Define", { fg = colors.darkBlue });

-- vim.api.nvim_set_hl(0, "StorageClass", { fg = "" });
vim.api.nvim_set_hl(0, "type", { fg = colors.lightViolet });
vim.api.nvim_set_hl(0, "Structure", { fg = fg });
-- vim.api.nvim_set_hl(0, "Typedef", { fg = "" });

vim.api.nvim_set_hl(0, "Visual", { bg = colors.darkerGray });
vim.api.nvim_set_hl(0, "Normal", { bg = bg, fg = fg });
vim.api.nvim_set_hl(0, "MatchParen", { link = "Visual" });
vim.api.nvim_set_hl(0, "ColorColumn", { link = "StatusLineNC" });
vim.api.nvim_set_hl(0, "Directory", { fg = colors.blue });

vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.lighterBlack });
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = colors.lightBlack });

vim.api.nvim_set_hl(0, "LineNr", { fg = colors.gray });
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.darkGray });
vim.api.nvim_set_hl(0, "LineNrBelow", { link = "LineNrAbove" });
vim.api.nvim_set_hl(0, "SignColumn", { link = "LineNr" });

vim.api.nvim_set_hl(0, "Pmenu", { bg = colors.lightestBlack });
vim.api.nvim_set_hl(0, "PmenuSel", { link = "Visual" });

vim.api.nvim_set_hl(0, "Search", { bg = colors.lightYellow, fg = bg });
vim.api.nvim_set_hl(0, "CurSearch", { bg = colors.yellow, fg = bg });

vim.api.nvim_set_hl(0, "Title", { fg = colors.pureWhite });
vim.api.nvim_set_hl(0, "Todo", { bg = colors.lightestBlack });
vim.api.nvim_set_hl(0, "Error", { fg = colors.red });

vim.api.nvim_set_hl(0, "DiagnosticError", { link = "Error" });
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.lightYellow });
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.darkBlue });
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.blue });
vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = colors.green });

vim.api.nvim_set_hl(0, "CmpItemKindDefault", { link = "Statement" });
