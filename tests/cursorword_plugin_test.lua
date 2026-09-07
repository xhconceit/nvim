local original_module = package.loaded["mini.cursorword"]
local original_set_hl = vim.api.nvim_set_hl
local module_name = "nvi.infrastructure.plugins.cursorword"
local setup_options
local highlight

package.loaded["mini.cursorword"] = {
  setup = function(options)
    setup_options = options
  end,
}
vim.api.nvim_set_hl = function(namespace, name, value)
  highlight = { namespace = namespace, name = name, value = value }
end
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local plugin = require(module_name)[1]
  assert(
    plugin[1] == "nvim-mini/mini.cursorword",
    "光标词插件声明错误"
  )
  assert(
    vim.deep_equal(plugin.event, { "BufReadPost", "BufNewFile" }),
    "光标词应该在打开文件后加载"
  )
  assert(plugin.opts.delay == 200, "光标词高亮延迟错误")

  plugin.config(nil, plugin.opts)

  assert(setup_options == plugin.opts, "应该传递光标词配置")
  assert(highlight.namespace == 0, "高亮命名空间错误")
  assert(highlight.name == "MiniCursorwordCurrent", "当前词高亮组错误")
  assert(vim.tbl_isempty(highlight.value), "当前词不应该额外高亮")
end, debug.traceback)

package.loaded["mini.cursorword"] = original_module
package.loaded[module_name] = nil
vim.api.nvim_set_hl = original_set_hl
assert(ok, error_message)
print("cursorword_plugin_test: OK")
