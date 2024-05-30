local helpers = require("helpers")
local builtin = require("telescope.builtin")
local lhses = require("mappings").lhses

helpers.set_keymaps({ "n" }, {}, {
  [lhses.find_files] = builtin.fd,
  [lhses.find_buffers] = builtin.buffers,
  [lhses.live_grep] = builtin.live_grep,
  [lhses.find_help] = builtin.help_tags,
  [lhses.resume] = builtin.resume,

  [lhses.find_references] = builtin.lsp_references,
  [lhses.find_implementations] = builtin.lsp_implementations,
  [lhses.find_definitions] = builtin.lsp_definitions,
  [lhses.find_type_definitions] = builtin.lsp_type_definitions
})

local actions = require("telescope.actions")
local telescope = require("telescope")

local function override_all_builtin_pickers(config)
  local pickers = {}

  for name, _ in pairs(builtin) do
    pickers[name] = config
  end
  return pickers
end

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules", "build", "dist", "yarn.lock", "dist-newstyle"
    },
    layout_strategy = "vertical",
    layout_config = {
      height = 0.95,
      width = 0.9,
      mirror = true
    },
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    mappings = {
      i = {
        ["<LeftMouse>"] = {
          actions.mouse_click,
          type = "action",
          opts = { expr = true },
        },
        ["<2-LeftMouse>"] = {
          actions.double_mouse_click,
          type = "action",
          opts = { expr = true },
        },

        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-f>"] = actions.preview_scrolling_left,
        ["<C-k>"] = actions.preview_scrolling_right,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<M-f>"] = actions.results_scrolling_left,
        ["<M-k>"] = actions.results_scrolling_right,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-/>"] = actions.which_key,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        ["<C-w>"] = { "<c-s-w>", type = "command" },
        ["<C-r><C-w>"] = actions.insert_original_cword,

        -- disable c-j because we dont want to allow new lines #2123
        ["<C-j>"] = actions.nop
      },
      n = {
        ["<LeftMouse>"] = {
          actions.mouse_click,
          type = "action",
          opts = { expr = true }
        },
        ["<2-LeftMouse>"] = {
          actions.double_mouse_click,
          type = "action",
          opts = { expr = true }
        },

        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-f>"] = actions.preview_scrolling_left,
        ["<C-k>"] = actions.preview_scrolling_right,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<M-f>"] = actions.results_scrolling_left,
        ["<M-k>"] = actions.results_scrolling_right,

        ["?"] = actions.which_key
      }
    }
  },
  pickers = helpers.merge_tables(
    override_all_builtin_pickers({
      preview_title = " ",
      results_title = false,
      prompt_title = false
    }),
    {
      fd = {
        hidden = true
      },
      live_grep = {
        additional_args = function(_) return { "--hidden" } end
      }
    })
})
