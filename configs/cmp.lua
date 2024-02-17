local default_options = require "plugins.configs.cmp"

local cmp = require "cmp"
local override_mappings = {
  ["<C-p>"] = cmp.config.disable,
  ["<C-n>"] = cmp.config.disable,
  ["<C-d>"] = cmp.config.disable,
  ["<C-f>"] = cmp.config.disable,
  ["<C-k>"] = cmp.mapping.select_prev_item(),
  ["<C-j>"] = cmp.mapping.select_next_item(),
}
default_options.mapping = vim.tbl_deep_extend("force", default_options.mapping, override_mappings)

return default_options
