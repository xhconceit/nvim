local module_name = "nvi.adapters.native_tab"
local original_adapter = package.loaded[module_name]
local original_cmd = vim.cmd

local calls = {
  tabnew = 0,
  tabclose = 0,
  tabnext = 0,
  tabprevious = 0,
  tabonly = 0,
}

vim.cmd = {
  tabnew = function()
    calls.tabnew = calls.tabnew + 1
  end,
  tabclose = function()
    calls.tabclose = calls.tabclose + 1
  end,
  tabnext = function()
    calls.tabnext = calls.tabnext + 1
  end,
  tabprevious = function()
    calls.tabprevious = calls.tabprevious + 1
  end,
  tabonly = function()
    calls.tabonly = calls.tabonly + 1
  end,
}

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local NativeTab = require(module_name)

  NativeTab.new()
  NativeTab.close()
  NativeTab.next()
  NativeTab.previous()
  NativeTab.only()

  for _, method in ipairs({ "tabnew", "tabclose", "tabnext", "tabprevious", "tabonly" }) do
    assert(calls[method] == 1, method .. " 应该执行一次")
  end
end, debug.traceback)

vim.cmd = original_cmd
package.loaded[module_name] = original_adapter

assert(ok, error_message)

print("native_tab_test: OK")
