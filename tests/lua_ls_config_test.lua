local config = require("nvi.infrastructure.lsp.servers.lua_ls")

-- 确认服务器启动命令
assert(config.cmd[1] == "lua-language-server", "lua_ls 启动命令错误")

-- 确认服务器处理 Lua 文件
assert(
  vim.tbl_contains(config.filetypes, "lua"),
  "lua_ls 应该支持 Lua 文件"
)

-- Neovim Lua 应使用 LuaJIT
assert(
  config.settings.Lua.runtime.version == "LuaJIT",
  "lua_ls 应该使用 LuaJIT"
)

print("lua_ls_config_test: OK")
