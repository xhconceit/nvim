local original_nvi = package.loaded["nvi"]
local original_enable = vim.loader and vim.loader.enable
local setup_calls = 0
local loader_calls = 0

package.loaded["nvi"] = {
  setup = function()
    setup_calls = setup_calls + 1
  end,
}

if vim.loader then
  vim.loader.enable = function()
    loader_calls = loader_calls + 1
  end
end

local ok, error_message = xpcall(function()
  dofile("init.lua")
  assert(setup_calls == 1, "入口应该初始化一次 nvi")
  if vim.loader then
    assert(loader_calls == 1, "入口应该启用 Lua 模块缓存")
  end
end, debug.traceback)

package.loaded["nvi"] = original_nvi
if vim.loader then
  vim.loader.enable = original_enable
end

assert(ok, error_message)
print("init_entrypoint_test: OK")
