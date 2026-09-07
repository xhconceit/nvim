local original_starter = package.loaded["mini.starter"]
local original_picker = package.loaded["nvi.adapters.mini_pick"]
local module_name = "nvi.infrastructure.plugins.starter"
local captured
local recent_options
local find_files = function() end
local search_text = function() end

package.loaded["mini.starter"] = {
  setup = function(options)
    captured = options
  end,
  sections = {
    recent_files = function(count, current_dir, show_path)
      recent_options = {
        count = count,
        current_dir = current_dir,
        show_path = show_path,
      }
      return "recent-files"
    end,
  },
  gen_hook = {
    adding_bullet = function(value)
      return "bullet:" .. value
    end,
    padding = function(vertical, horizontal)
      return string.format("padding:%d:%d", vertical, horizontal)
    end,
    aligning = function(horizontal, vertical)
      return "aligning:" .. horizontal .. ":" .. vertical
    end,
  },
}
package.loaded["nvi.adapters.mini_pick"] = {
  find_files = find_files,
  search_text = search_text,
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local plugin = require(module_name)[1]
  assert(plugin[1] == "nvim-mini/mini.starter", "启动页插件声明错误")
  assert(plugin.event == "VimEnter", "启动页加载时机错误")

  plugin.config()

  assert(captured.autoopen == true, "启动页应该自动打开")
  assert(captured.items[1].action == find_files, "查找文件操作错误")
  assert(captured.items[2].action == search_text, "搜索文本操作错误")
  assert(captured.items[5] == "recent-files", "启动页缺少最近文件")
  assert(recent_options.count == 5, "最近文件数量错误")
  assert(
    recent_options.current_dir == true,
    "最近文件应该限制在当前目录"
  )
  assert(
    recent_options.show_path == false,
    "最近文件不应该显示完整路径"
  )
  assert(
    captured.content_hooks[3] == "aligning:center:center",
    "启动页应该居中"
  )
end, debug.traceback)

package.loaded["mini.starter"] = original_starter
package.loaded["nvi.adapters.mini_pick"] = original_picker
package.loaded[module_name] = nil
assert(ok, error_message)
print("starter_plugin_test: OK")
