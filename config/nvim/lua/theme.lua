local helpers = require("helpers")
local colors = require("user_ini").colors

vim.cmd("colorscheme default")

local bg = colors.black;
local fg = colors.pureWhite;

helpers.set_hls_globally({
  -- ["Statement"] = { fg = colors.blue },
  ["Visual"] = { bg = colors.darkerGray },
  ["Normal"] = { bg = bg, fg = fg },
  ["NormalFloat"] = { link = "Pmenu" },

  ["StatusLine"] = { bg = colors.lighterBlack },
  ["StatusLineNC"] = { bg = colors.lightBlack },
  -- status line

  ["Pmenu"] = { bg = colors.lightestBlack },
  ["PmenuSel"] = { link = "Visual" },
  -- cmdline

  ["MsgArea"] = { link = "Pmenu" },
  -- cmdline, pager

  ["LineNr"] = { fg = colors.gray },
  ["LineNrAbove"] = { fg = colors.darkGray },
  ["LineNrBelow"] = { link = "LineNrAbove" },
  ["SignColumn"] = { link = "LineNr" },
  -- line number, sign column

  ["Search"] = { bg = colors.lightYellow, fg = bg },
  ["CurSearch"] = { bg = colors.yellow, fg = bg },

  ["ColorColumn"] = { link = "StatusLineNC" },
  -- ruler column

  ["MatchParen"] = { link = "Visual" },

  ["Directory"] = { fg = colors.blue },

  ["Error"] = { fg = colors.red },
  ["Whitespace"] = { fg = colors.lightGray },

  ["DiagnosticError"] = { link = "Error" },
  ["DiagnosticWarn"] = { fg = colors.lighterOrange },
  ["DiagnosticInfo"] = { fg = colors.darkBlue },
  ["DiagnosticHint"] = { fg = colors.lightYellow },
  ["DiagnosticOk"] = { fg = colors.green },

  -- TREESITTER
  ["Comment"] = { fg = colors.gray },
  -- @text.literal @comment
  ["Identifier"] = { fg = fg },
  -- @text.reference @parameter @field @property @variable @namespace
  ["Title"] = { fg = colors.pureWhite },
  -- @text.title
  ["Underlined"] = {},
  -- @text.uri @text.underline
  ["Todo"] = { bg = colors.lightestBlack },
  -- @text.todo
  ["Delimiter"] = { fg = colors.lightGray },
  -- @punctuation
  ["Constant"] = {},
  -- @constant
  ["Special"] = { fg = colors.lightViolet },
  -- @constant.builtin @function.builtin @constructor
  ["Define"] = { fg = colors.darkBlue },
  -- @constant.macro @define
  ["Macro"] = {},
  -- @macro @function.macro
  ["String"] = { fg = colors.lightestGreen },
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
  ["Function"] = { fg = colors.blue },
  -- @function @method
  ["Conditional"] = {},
  -- @conditional
  ["Repeat"] = {},
  -- @repeat
  ["Label"] = {},
  -- @label
  ["Operator"] = { fg = colors.lighterOrange },
  -- @operator
  ["Keyword"] = { fg = colors.lighterOrange },
  -- @keyword
  ["Exception"] = {},
  -- @exception
  ["Type"] = { fg = colors.lightViolet },
  -- @type
  ["Typedef"] = {},
  -- @type.definition
  ["StorageClass"] = {},
  -- @storageclass
  ["Structure"] = { fg = fg },
  -- @structure
  ["Include"] = { fg = colors.darkBlue },
  -- @include
  ["PreProc"] = { fg = colors.lightGray },
  -- @preproc
  ["Debug"] = {},
  -- @debug
  ["Tag"] = {},
  -- @tag
})
