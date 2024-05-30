local helpers = require("helpers")
local lhses = require("mappings").lhses

local is_tmux = os.getenv("TERM_PROGRAM") == "tmux"
local function execute_tmux_cmd(cmd)
  if is_tmux then
    os.execute("tmux " .. cmd)
  end
end

local function make_tmux_action(cmd)
  return function()
    execute_tmux_cmd(cmd)
  end
end

helpers.set_keymaps({ "n", "v" }, { silent = true }, {
  [lhses.tmux_next_pane] = make_tmux_action("select-pane -t :.+"),
  [lhses.tmux_prev_pane] = make_tmux_action("select-pane -t :.-"),
  [lhses.tmux_resize_pane_left] = make_tmux_action("resize-pane -L 3"),
  [lhses.tmux_resize_pane_right] = make_tmux_action("resize-pane -R 3"),
  [lhses.tmux_resize_pane_down] = make_tmux_action("resize-pane -D 3"),
  [lhses.tmux_resize_pane_up] = make_tmux_action("resize-pane -U 3"),
})
