local original_treesitter = package.loaded["nvim-treesitter"]
local original_create_autocmd = vim.api.nvim_create_autocmd
local original_start = vim.treesitter.start
local module_name = "nvi.infrastructure.plugins.treesitter"

local calls = {
  setup = 0,
  setup_options = nil,
  install = 0,
  languages = nil,
  autocmd = nil,
  start = 0,
}

package.loaded["nvim-treesitter"] = {
  setup = function(options)
    calls.setup = calls.setup + 1
    calls.setup_options = options
  end,
  install = function(languages)
    calls.install = calls.install + 1
    calls.languages = languages
  end,
}

vim.api.nvim_create_autocmd = function(event, options)
  calls.autocmd = {
    event = event,
    options = options,
  }
  return 1
end

vim.treesitter.start = function()
  calls.start = calls.start + 1
end

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local specs = require(module_name)
  local plugin = specs[1]

  assert(
    plugin[1] == "nvim-treesitter/nvim-treesitter",
    "声明了错误的 Treesitter 插件"
  )
  assert(plugin.branch == "main", "应该使用新版 main 分支")
  assert(plugin.lazy == false, "新版 Treesitter 不支持懒加载")
  assert(
    plugin.build == ":TSUpdate",
    "升级插件时应该同步更新 parser"
  )
  assert(
    type(plugin.config) == "function",
    "Treesitter 插件应该提供 config 函数"
  )

  plugin.config()

  assert(calls.setup == 1, "应该调用一次 setup")
  assert(calls.install == 1, "应该调用一次 install")

  local expected_languages = {
    "lua",
    "vim",
    "vimdoc",
    "query",
    "bash",
    "dart",
    "json",
    "markdown",
    "markdown_inline",
    "latex",
  }

  assert(
    vim.deep_equal(calls.languages, expected_languages),
    "应该安装约定的 parser"
  )
  assert(
    calls.autocmd.event == "FileType",
    "应该在 FileType 事件启用高亮"
  )
  assert(
    vim.deep_equal(calls.autocmd.options.pattern, expected_languages),
    "只应该为已安装的语言启用高亮"
  )
  assert(
    type(calls.autocmd.options.callback) == "function",
    "FileType autocmd 应该提供 callback"
  )

  calls.autocmd.options.callback()

  assert(calls.start == 1, "FileType callback 应该启动 Treesitter 高亮")
end, debug.traceback)

package.loaded["nvim-treesitter"] = original_treesitter
package.loaded[module_name] = nil
vim.api.nvim_create_autocmd = original_create_autocmd
vim.treesitter.start = original_start

assert(ok, error_message)

print("treesitter_plugin_test: OK")
