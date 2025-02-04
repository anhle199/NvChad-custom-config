---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "vscode_dark",
  theme_toggle = { "vscode_dark", "vscode_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  telescope = {
    style = "bordered",
  },

  statusline = {
    theme = "vscode_colored",
  },

  nvdash = {
    header = {
      "██╗  ██╗ ██████╗  █████╗ ███╗   ██╗ ██████╗      █████╗ ███╗   ██╗██╗  ██╗",
      "██║  ██║██╔═══██╗██╔══██╗████╗  ██║██╔════╝     ██╔══██╗████╗  ██║██║  ██║",
      "███████║██║   ██║███████║██╔██╗ ██║██║  ███╗    ███████║██╔██╗ ██║███████║",
      "██╔══██║██║   ██║██╔══██║██║╚██╗██║██║   ██║    ██╔══██║██║╚██╗██║██╔══██║",
      "██║  ██║╚██████╔╝██║  ██║██║ ╚████║╚██████╔╝    ██║  ██║██║ ╚████║██║  ██║",
      "╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝",
    },
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
