local dap = require("dap")
local dapui = require("dapui")
-- local masonDap = require("mason-nvim-dap")

dap.set_log_level('ERROR')

vim.keymap.set("n", "<Leader>ds", dapui.toggle, {})
vim.keymap.set("n", "<Leader>dS", function()
  dapui.toggle({ reset = true })
end, {})
vim.keymap.set("n", "<Leader>dc", dap.continue, {})
vim.keymap.set("n", "<Leader>do", dap.step_over, {})
vim.keymap.set("n", "<Leader>di", dap.step_into, {})
vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})

dapui.setup(
  {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = false,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = {
      {
        elements = {
          -- { id = "repl",    size = 0.5 },
          { id = "scopes",  size = 0.5 },
          { id = "console", size = 0.5 },
        },
        position = "bottom",
        size = 7

      },
      {
        elements = {
          { id = "breakpoints", size = 0.333 },
          { id = "stacks",      size = 0.333 },
          { id = "watches",     size = 0.333 },
        },
        position = "top",
        size = 3
      },
    },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
  }
)

-- masonDap.setup({
--   ensure_installed = { "node2" },
--   handlers = {
--     function(config)
--       -- all sources with no handler get passed here
--
--       -- Keep original functionality
--       masonDap.default_setup(config)
--     end,
--     node2 = function(config)
--       masonDap.default_setup(config) -- don't forget this!
--     end,
--   },
-- })
