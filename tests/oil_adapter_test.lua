local original_getcwd = vim.fn.getcwd
local original_oil = package.loaded["oil"]
local module_name = "nvi.adapters.oil"
local calls = {}

vim.fn.getcwd = function()
  return "/tmp/project"
end

package.loaded["oil"] = {
  open = function(path)
    table.insert(calls, { method = "open", path = path })
  end,
  close = function()
    table.insert(calls, { method = "close" })
  end,
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local adapter = require(module_name)
  adapter.open_current()
  adapter.open_cwd()
  adapter.close()

  assert(#calls == 3, "Oil 应该被调用三次")
  assert(calls[1].method == "open" and calls[1].path == nil)
  assert(calls[2].path == "/tmp/project", "应该打开当前工作目录")
  assert(calls[3].method == "close", "应该关闭 Oil")
end, debug.traceback)

vim.fn.getcwd = original_getcwd
package.loaded["oil"] = original_oil
package.loaded[module_name] = nil

assert(ok, error_message)
print("oil_adapter_test: OK")
