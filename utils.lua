local M = {}

---@param plugin string
M.has_plugin = function(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

---@param name string
M.opts = function(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

return M
