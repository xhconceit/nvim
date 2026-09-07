local original = package.loaded["mini.hipatterns"]
local module_name = "nvi.infrastructure.plugins.hipatterns"
local captured
local hex_options

package.loaded["mini.hipatterns"] = {
  setup = function(options)
    captured = options
  end,
  gen_highlighter = {
    hex_color = function(options)
      hex_options = options
      return "hex-highlighter"
    end,
  },
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local plugin = require(module_name)[1]
  assert(
    plugin[1] == "nvim-mini/mini.hipatterns",
    "特殊标记插件声明错误"
  )
  assert(
    vim.deep_equal(plugin.event, { "BufReadPost", "BufNewFile" }),
    "特殊标记应该在打开文件后加载"
  )
  plugin.config()

  assert(
    captured.highlighters.fixme.group == "MiniHipatternsFixme",
    "FIXME 高亮组错误"
  )
  assert(
    vim.tbl_contains(captured.highlighters.todo.pattern, "%f[%w]()TODO()%f[%W]"),
    "缺少 TODO 匹配"
  )
  assert(
    captured.highlighters.hex_color == "hex-highlighter",
    "缺少颜色值高亮"
  )
  assert(hex_options.style == "inline", "颜色值应该使用行内色块")
end, debug.traceback)

package.loaded["mini.hipatterns"] = original
package.loaded[module_name] = nil
assert(ok, error_message)
print("hipatterns_plugin_test: OK")
