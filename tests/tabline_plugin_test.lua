local plugin = require("nvi.infrastructure.plugins.tabline")[1]

assert(plugin[1] == "nvim-mini/mini.tabline", "标签栏插件声明错误")
assert(plugin.version == false, "mini.tabline 应该跟随最新版")
assert(plugin.event == "VeryLazy", "标签栏加载时机错误")
assert(plugin.opts.show_icons == true, "标签栏应该显示图标")
assert(
  type(plugin.opts.format) == "function",
  "标签栏应该自定义文件标签"
)
assert(
  plugin.opts.tabpage_section == "right",
  "Tab 区域应该显示在右侧"
)

local original_module = package.loaded["mini.tabline"]
package.loaded["mini.tabline"] = {
  default_format = function(_, label)
    return " " .. label .. " "
  end,
}

local buffer = vim.api.nvim_create_buf(true, false)
vim.bo[buffer].modified = false
assert(plugin.opts.format(buffer, "init.lua") == " init.lua ")

vim.api.nvim_buf_set_lines(buffer, 0, -1, false, { "changed" })
assert(
  plugin.opts.format(buffer, "init.lua") == " init.lua  ●",
  "未保存的 Buffer 应该显示修改标记"
)

vim.api.nvim_buf_delete(buffer, { force = true })
package.loaded["mini.tabline"] = original_module

print("tabline_plugin_test: OK")
