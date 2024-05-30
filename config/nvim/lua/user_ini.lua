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

local user_dir = unpack(vim.fs.find("user", {
  type = "directory",
  path = "$XDG_CONFIG_HOME"
}))

local user_ini_path

if user_dir then
  user_ini_path = user_dir .. "/user.ini"
end

local LIP = require("LIP")

if vim.fn.filereadable(user_ini_path) ~= 1 then
  user_ini_path = vim.fn.expand("$HOME") .. "/.config/user/user.ini"
end

return LIP.load(user_ini_path)
