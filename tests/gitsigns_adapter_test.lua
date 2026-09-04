local original_gitsigns = package.loaded["gitsigns"]
local module_name = "nvi.adapters.gitsigns"

local calls = {}

package.loaded["gitsigns"] = {
  nav_hunk = function(direction)
    table.insert(calls, {
      method = "nav_hunk",
      argument = direction,
    })
  end,
  stage_hunk = function()
    table.insert(calls, { method = "stage_hunk" })
  end,
  reset_hunk = function()
    table.insert(calls, { method = "reset_hunk" })
  end,
  preview_hunk = function()
    table.insert(calls, { method = "preview_hunk" })
  end,
}

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local adapter = require(module_name)

  adapter.next_hunk()
  adapter.prev_hunk()
  adapter.stage_hunk()
  adapter.reset_hunk()
  adapter.preview_hunk()

  local expectations = {
    { method = "nav_hunk", argument = "next" },
    { method = "nav_hunk", argument = "prev" },
    { method = "stage_hunk" },
    { method = "reset_hunk" },
    { method = "preview_hunk" },
  }

  assert(
    #calls == #expectations,
    "每个 adapter 方法应该调用一次 gitsigns"
  )

  for index, expectation in ipairs(expectations) do
    assert(
      calls[index].method == expectation.method,
      "第 " .. index .. " 个 gitsigns 调用不正确"
    )
    assert(
      calls[index].argument == expectation.argument,
      "第 " .. index .. " 个 gitsigns 参数不正确"
    )
  end
end, debug.traceback)

package.loaded["gitsigns"] = original_gitsigns
package.loaded[module_name] = nil

assert(ok, error_message)

print("gitsigns_adapter_test: OK")
