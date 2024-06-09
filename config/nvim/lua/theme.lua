local helpers = require("helpers")
local colors = require("user_ini").colors

vim.cmd("colorscheme default")

local bg = colors.blackT10;
local fg = colors.white;

helpers.set_hls_globally({
  -- ["Statement"] = { fg = colors.blue },
  ["Visual"] = { bg = colors.grayS65 },
  ["Normal"] = { bg = bg, fg = fg },
  ["NormalFloat"] = { link = "Pmenu" },

  ["StatusLine"] = { bg = colors.blackT12 },
  ["StatusLineNC"] = { bg = colors.blackT11 },
  -- status line

  ["Pmenu"] = { bg = colors.blackT17 },
  ["PmenuSel"] = { link = "Visual" },
  -- cmdline

  ["MsgArea"] = { link = "Pmenu" },
  -- cmdline, pager

  ["LineNr"] = { fg = colors.grayS52 },
  ["LineNrAbove"] = { fg = colors.grayS62 },
  ["LineNrBelow"] = { link = "LineNrAbove" },
  ["SignColumn"] = { link = "LineNr" },
  -- line number, sign column

  ["Search"] = { bg = colors.yellowT70, fg = bg },
  ["CurSearch"] = { bg = colors.yellow, fg = bg },

  ["ColorColumn"] = { link = "StatusLineNC" },
  -- ruler column

  ["MatchParen"] = { link = "Visual" },

  ["Directory"] = { fg = colors.cyanT40 },

  ["Error"] = { fg = colors.red },
  ["Whitespace"] = { fg = colors.grayS15 },

  ["DiagnosticError"] = { link = "Error" },
  ["DiagnosticWarn"] = { fg = colors.orangeT50 },
  ["DiagnosticInfo"] = { fg = colors.cyanT40 },
  ["DiagnosticHint"] = { fg = colors.yellowT70 },
  ["DiagnosticOk"] = { fg = colors.green },

  -- TREESITTER
  ["Comment"] = { fg = colors.grayS52 },
  -- @text.literal @comment
  ["Identifier"] = { fg = fg },
  -- @text.reference @parameter @field @property @variable @namespace
  ["Title"] = { fg = colors.white },
  -- @text.title
  ["Underlined"] = {},
  -- @text.uri @text.underline
  ["Todo"] = { bg = colors.blackT17 },
  -- @text.todo
  ["Delimiter"] = { fg = colors.grayS15 },
  -- @punctuation
  ["Constant"] = {},
  -- @constant
  ["Special"] = { fg = colors.lavender },
  -- @constant.builtin @function.builtin @constructor
  ["Define"] = { fg = colors.cyanT40 },
  -- @constant.macro @define
  ["Macro"] = {},
  -- @macro @function.macro
  ["String"] = { fg = colors.greenT80 },
  -- @string
  ["SpecialChar"] = {},
  -- @string.escape @string.special @character.special
  ["Character"] = {},
  -- @character
  ["Number"] = { fg = colors.lightestGreen },
  -- @number
  ["Boolean"] = {},
  -- @boolean
  ["Float"] = {},
  -- @float
  ["Function"] = { fg = colors.cyanT40 },
  -- @function @method
  ["Conditional"] = {},
  -- @conditional
  ["Repeat"] = {},
  -- @repeat
  ["Label"] = {},
  -- @label
  ["Operator"] = { fg = colors.orangeT50 },
  -- @operator
  ["Keyword"] = { fg = colors.orangeT50 },
  -- @keyword
  ["Exception"] = {},
  -- @exception
  ["Type"] = { fg = colors.lavender },
  -- @type
  ["Typedef"] = {},
  -- @type.definition
  ["StorageClass"] = {},
  -- @storageclass
  ["Structure"] = { fg = fg },
  -- @structure
  ["Include"] = { fg = colors.cyanT40 },
  -- @include
  ["PreProc"] = { fg = colors.grayS15 },
  -- @preproc
  ["Debug"] = {},
  -- @debug
  ["Tag"] = {},
  -- @tag
})
