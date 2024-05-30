local function print_table(t, indent)
  indent = indent or ""
  for k, v in pairs(t) do
    if type(v) == "table" then
      print(indent .. k .. ":")
      print_table(v, indent .. "  ")
    else
      print(indent .. k .. ": " .. tostring(v))
    end
  end
end

local function reduce_table(t, acc, f)
  for _, v in pairs(t) do
    acc = f(acc, v)
  end
  return acc
end

local function merge_tables(t1, t2)
  local result = {}

  local function merge_values(k, v1, v2)
    if type(v1) == "table" and type(v2) == "table" then
      result[k] = merge_tables(v1, v2)
    else
      result[k] = v2
    end
  end

  for k, v in pairs(t1) do
    if type(v) == "table" then
      result[k] = merge_tables({}, v)
    else
      result[k] = v
    end
  end

  for k, v in pairs(t2) do
    if result[k] then
      merge_values(k, result[k], v)
    else
      if type(v) == "table" then
        result[k] = merge_tables({}, v)
      else
        result[k] = v
      end
    end
  end

  return result
end

local function set_options(options)
  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

local function set_globals(globals)
  for k, v in pairs(globals) do
    vim.g[k] = v
  end
end

local function set_keymaps(modes, options, keymaps)
  for k, v in pairs(keymaps) do
    vim.keymap.set(modes, k, v, options)
  end
end

local function set_hls_globally(hls)
  for k, v in pairs(hls) do
    vim.api.nvim_set_hl(0, k, v);
  end
end

local function require_if_exist(module_name)
  local module_path =
      vim.fn.stdpath('config')
      .. '/lua/'
      .. module_name:gsub('%.', '/')

  if vim.fn.isdirectory(module_path) == 1 then
    module_path = module_path .. "/init"
  end

  module_path = module_path .. '.lua'

  if vim.fn.filereadable(module_path) == 1 then
    local module = require(module_name)
    return module
  end
end

return {
  print_table = print_table,
  reduce_table = reduce_table,
  merge_tables = merge_tables,
  set_options = set_options,
  set_globals = set_globals,
  set_keymaps = set_keymaps,
  set_hls_globally = set_hls_globally,
  require_if_exist = require_if_exist
}
