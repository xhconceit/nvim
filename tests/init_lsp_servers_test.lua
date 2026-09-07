local module_names = {
  "nvi",
  "nvi.core.commands",
  "nvi.core.options",
  "nvi.core.keymaps",
  "nvi.core.autocmds",
  "nvi.infrastructure.lazy",
  "nvi.features.git",
  "nvi.adapters.gitsigns",
  "nvi.features.buffer",
  "nvi.adapters.native_buffer",
  "nvi.features.search",
  "nvi.adapters.mini_pick",
  "nvi.features.file_explorer",
  "nvi.adapters.mini_files",
  "nvi.features.formatting",
  "nvi.adapters.lsp_formatter",
  "nvi.features.terminal",
  "nvi.adapters.native_terminal",
  "nvi.features.quickfix",
  "nvi.adapters.native_quickfix",
  "nvi.features.window",
  "nvi.adapters.native_window",
  "nvi.features.tab",
  "nvi.adapters.native_tab",
  "nvi.features.session",
  "nvi.adapters.native_session",
  "nvi.composition.lsp",
  "nvi.infrastructure.lsp",
  "nvi.features.code_intelligence",
  "nvi.adapters.native_lsp",
  "nvi.features.diagnostics",
  "nvi.adapters.native_diagnostics",
  "nvi.infrastructure.lsp.servers.lua_ls",
  "nvi.infrastructure.lsp.servers.dartls",
}

local saved_modules = {}
for _, name in ipairs(module_names) do
  saved_modules[name] = package.loaded[name]
end

local function setup_module()
  return {
    setup = function() end,
  }
end

for _, name in ipairs(module_names) do
  if
    name:find("%.features%.")
    or name:find("%.core%.")
    or name == "nvi.infrastructure.lazy"
  then
    package.loaded[name] = setup_module()
  elseif name:find("%.adapters%.") or name == "nvi.infrastructure.lsp" then
    package.loaded[name] = {}
  end
end

local received_lsp_dependencies = nil
package.loaded["nvi.composition.lsp"] = {
  setup = function(dependencies)
    received_lsp_dependencies = dependencies
  end,
}

local lua_ls = {}
local dartls = {}
package.loaded["nvi.infrastructure.lsp.servers.lua_ls"] = lua_ls
package.loaded["nvi.infrastructure.lsp.servers.dartls"] = dartls
package.loaded["nvi"] = nil

local ok, error_message = xpcall(function()
  require("nvi").setup()
end, debug.traceback)

for _, name in ipairs(module_names) do
  package.loaded[name] = saved_modules[name]
end

assert(ok, error_message)
assert(
  received_lsp_dependencies.completion == nil,
  "默认组合根不应该再注入原生补全"
)
assert(
  received_lsp_dependencies.servers.lua_ls == lua_ls,
  "默认组合根应该注册 lua_ls"
)
assert(
  received_lsp_dependencies.servers.dartls == dartls,
  "默认组合根应该注册 dartls"
)

print("init_lsp_servers_test: OK")
