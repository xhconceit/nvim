local uv = vim.uv or vim.loop

local original = {
  fs_stat = uv.fs_stat,
  lazy = package.loaded.lazy,
  runtimepath = vim.o.runtimepath,
}

local calls = {
  fs_stat_path = nil,
  lazy_options = nil,
}

uv.fs_stat = function(path)
  calls.fs_stat_path = path

  return {
    type = "directory",
  }
end

package.loaded.lazy = {
  setup = function(options)
    calls.lazy_options = options
  end,
}

local LazyInfrastructure = require("nvi.infrastructure.lazy")

local expected_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local ok, error_message = xpcall(function()
  LazyInfrastructure.setup()

  assert(
    calls.fs_stat_path == expected_path,
    "lazy.nvim 检查了错误的安装路径"
  )

  assert(
    vim.tbl_contains(vim.opt.runtimepath:get(), expected_path),
    "lazy.nvim 没有加入 runtimepath"
  )

  assert(type(calls.lazy_options) == "table", "没有调用 lazy.setup")

  assert(
    calls.lazy_options.spec[1].import == "nvi.infrastructure.plugins",
    "lazy.nvim 导入了错误的插件目录"
  )

  assert(
    calls.lazy_options.install.colorscheme[1] == "habamax",
    "lazy.nvim 安装回退配色错误"
  )

  assert(
    calls.lazy_options.checker.enabled == false,
    "插件更新检查应该关闭"
  )

  assert(
    calls.lazy_options.change_detection.notify == false,
    "配置变化通知应该关闭"
  )
end, debug.traceback)

uv.fs_stat = original.fs_stat
package.loaded.lazy = original.lazy
vim.o.runtimepath = original.runtimepath

assert(ok, error_message)

print("lazy_infrastructure_test: OK")
