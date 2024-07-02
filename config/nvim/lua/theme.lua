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

  ["Search"] = { bg = colors.lightYellow, fg = bg },
  ["CurSearch"] = { bg = colors.neutralYellow, fg = bg },

  ["ColorColumn"] = { link = "StatusLineNC" },
  -- ruler column

  ["MatchParen"] = { link = "Visual" },

  ["Directory"] = { fg = colors.lightCyan },

  ["Error"] = { fg = colors.neutralRed },
  ["Whitespace"] = { fg = colors.grayS15 },

  ["DiagnosticError"] = { link = "Error" },
  ["DiagnosticWarn"] = { fg = colors.lightYellow },
  ["DiagnosticInfo"] = { fg = colors.lightCyan },
  ["DiagnosticHint"] = { fg = colors.lightYellow },
  ["DiagnosticOk"] = { fg = colors.lightGreen },

  -- TREESITTER
  -- 1. Comments and Documentation
  ["Comment"] = { fg = colors.grayS52 },
  -- @text.literal @comment
  ["Todo"] = { fg = colors.grayS52 },
  -- @text.todo

  -- 2. Variables and Identifiers
  ["Identifier"] = { fg = colors.fg },
  -- @text.reference @parameter @field @property @variable @namespace
  ["Constant"] = { fg = colors.grayS65 },
  -- @constant

  -- 3. Functions and Methods
  ["Function"] = { fg = colors.lightBlue },
  -- @function @method
  ["Macro"] = { fg = colors.lightRed },
  -- @macro @function.macro
  ["Special"] = { fg = colors.grayS15 },
  -- @constant.builtin @function.builtin @constructor

  -- 4. Keywords and Operators
  ["Keyword"] = { fg = colors.lightGreen },
  -- @keyword
  ["Operator"] = { fg = colors.lightGreen },
  -- @operator
  ["Conditional"] = { fg = colors.lightGreen },
  -- @conditional
  ["Repeat"] = { fg = colors.lightGreen },
  -- @repeat
  ["Exception"] = { fg = colors.lightRed },
  -- @exception

  -- 5. Types and Structures
  ["Type"] = { fg = colors.lightPurple },
  -- @type
  ["Typedef"] = { fg = colors.lightPurple },
  -- @type.definition
  ["StorageClass"] = { fg = colors.lightPurple },
  -- @storageclass
  ["Structure"] = { fg = colors.lightPurple },
  -- @structure

  -- 6. Literals
  ["String"] = { fg = colors.lightYellow },
  -- @string
  ["Character"] = { fg = colors.lightRed },
  -- @character
  ["Number"] = { fg = colors.lightYellow },
  -- @number
  ["Boolean"] = { fg = colors.lightRed },
  -- @boolean
  ["Float"] = { fg = colors.lightYellow },
  -- @float

  -- 7. Punctuation and Delimiters
  ["Delimiter"] = { fg = colors.grayS15 },
  -- @punctuation

  -- 8. Preprocessor and Includes
  ["Define"] = { fg = colors.lightPurple },
  -- @constant.macro @define
  ["Include"] = { fg = colors.lightPurple },
  -- @include
  ["PreProc"] = { fg = colors.grayS52 },
  -- @preproc

  -- 9. Text Formatting
  ["Title"] = { fg = colors.lightBlue },
  -- @text.title
  ["Underlined"] = { fg = colors.lightCyan },
  -- @text.uri @text.underline

  -- 10. Special Elements
  ["SpecialChar"] = { fg = colors.lightRed },
  -- @string.escape @string.special @character.special
  ["Label"] = { fg = colors.lightCyan },
  -- @label
  ["Debug"] = { fg = colors.lightRed },
  -- @debug
  ["Tag"] = { fg = colors.lightPurple },
  -- @tag
})
