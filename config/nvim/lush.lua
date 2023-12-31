local lush = require('lush')
local hsl = lush.hsl -- We'll use hsl a lot so its nice to bind it separately

local sea_foam  = hsl(208, 100, 80) -- Vim has a mapping, <n>C-a and <n>C-x to
local sea_crest = hsl(208, 90, 30)  -- increment or decrement integers, or
local sea_deep  = hsl(208, 90, 10)  -- you can just type them normally.
local sea_gull  = hsl("#c6c6c6")
local sea_foam_triadic = sea_foam.rotate(120)
local sea_foam_complement = sea_foam.rotate(180).darken(10).saturate(10)

---@diagnostic disable: undefined-global
local theme = lush(function()
  return {
    Normal { bg = "#000000", fg = "#ffffff" }, -- Goodbye gray, hello blue!
    CursorLine { bg = Normal.fg, fg = Normal.bg }, -- lighten() can also be called via li()
    CursorColumn { CursorLine }, -- CursorColumn is linked to CursorLine
    Visual { fg = Normal.bg, bg = Normal.fg }, -- Try pressing v and selecting some text
    Comment { fg = "#0000ff" },
    LineNr { Comment, gui = "italic" },
    LineNrBelow { LineNr },
    LineNrAbove { LineNr },
    CursorLineNr { LineNr },
    -- search_base  { bg = hsl(52, 52, 52), fg = hsl(52, 10, 10) },
    Search       { bg = "#FFFF00", fg = "#0000FF" },
    IncSearch    { Search },
  }
end)
return theme
