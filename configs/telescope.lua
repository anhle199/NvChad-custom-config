local default_options = require "plugins.configs.telescope"
local override_options = {
  defaults = {
    prompt_prefix = " 󰍉  ",
    selection_caret = " ",
    sorting_strategy = "descending",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.6,
      },
      width = 0.90,
      height = 0.90,
    },
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },
}

local options = vim.tbl_deep_extend("force", default_options, override_options)
return options
