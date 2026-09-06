local Command = require("nvi.ui.command")

local original = {
  get_commands = vim.api.nvim_get_commands,
  get_current_buf = vim.api.nvim_get_current_buf,
  buf_get_commands = vim.api.nvim_buf_get_commands,
  cmd = vim.cmd,
}

local executed = nil

vim.api.nvim_get_commands = function(options)
  assert(
    options.builtin == false,
    "命令列表暂时只应读取用户命令"
  )

  return {
    Undescribed = {
      name = "Undescribed",
      desc = "",
    },
    Shared = {
      name = "Shared",
      desc = "全局命令",
    },
    NviConfig = {
      name = "NviConfig",
      desc = "打开 NVI 配置入口",
    },
  }
end

vim.api.nvim_get_current_buf = function()
  return 42
end

vim.api.nvim_buf_get_commands = function(bufnr, options)
  assert(bufnr == 42, "应该读取当前 Buffer 的命令")
  assert(vim.tbl_isempty(options), "Buffer 命令选项错误")

  return {
    Shared = {
      name = "Shared",
      desc = "Buffer 命令",
    },
  }
end

vim.cmd = function(command)
  executed = command
end

local ok, error_message = xpcall(function()
  local items = Command.list()

  assert(#items == 3, "应该合并全局与 Buffer 命令")

  assert(
    vim.deep_equal(items[1], {
      name = "NviConfig",
      desc = "打开 NVI 配置入口",
      text = "NviConfig  打开 NVI 配置入口",
    }),
    "命令应该按名称排序并包含描述"
  )

  assert(
    vim.deep_equal(items[2], {
      name = "Shared",
      desc = "Buffer 命令",
      text = "Shared  Buffer 命令",
    }),
    "Buffer 命令应该覆盖同名全局命令"
  )

  assert(
    vim.deep_equal(items[3], {
      name = "Undescribed",
      desc = "",
      text = "Undescribed",
    }),
    "没有描述的命令应该只显示名称"
  )

  Command.execute(items[1].name)

  assert(
    executed == "NviConfig",
    "Command.execute 应该执行选中的命令"
  )
end, debug.traceback)

vim.api.nvim_get_commands = original.get_commands
vim.api.nvim_get_current_buf = original.get_current_buf
vim.api.nvim_buf_get_commands = original.buf_get_commands
vim.cmd = original.cmd

assert(ok, error_message)

print("command_test: OK")
