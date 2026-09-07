local RecentFile = require("nvi.ui.recent_file")
local Project = require("nvi.core.project")
local Keymap = require("nvi.ui.keymap")
local Command = require("nvi.ui.command")

local M = {}

function M.find_files()
  -- 获取文件名
  local path = vim.fn.input("打开文件：", Project.root() .. "/", "file")

  if path == "" then
    return
  end

  -- 打开文件
  vim.cmd.edit(
    -- 正确处理空格等特殊字符
    vim.fn.fnameescape(path)
  )
end

local function search_project(text)
  if text == "" then
    return
  end

  local pattern = "\\V" .. vim.fn.escape(text, [[\/]])

  local root = vim.fn.fnameescape(Project.root())

  local ok =
    pcall(vim.cmd, "silent vimgrep /" .. pattern .. "/gj " .. root .. "/**/*")

  if not ok then
    vim.notify("没有找到：" .. text, vim.log.levels.WARN)
    return
  end

  vim.cmd("copen")
end

function M.search_text()
  search_project(vim.fn.input("搜索文本："))
end

function M.search_keymaps()
  vim.ui.select(Keymap.list("n"), {
    prompt = "搜索快捷键：",
    format_item = function(item)
      return item.text
    end,
  }, function(item)
    if item then
      Keymap.execute(item.lhs)
    end
  end)
end

function M.search_commands()
  vim.ui.select(Command.list(), {
    prompt = "搜索命令：",
    format_item = function(item)
      return item.text
    end,
  }, function(item)
    if item then
      Command.execute(item.name)
    end
  end)
end

function M.search_buffers()
  local buffers = vim.fn.getbufinfo({
    buflisted = 1,
  })
  vim.ui.select(buffers, {
    prompt = "搜索 Buffer：",
    format_item = function(buffer)
      local name = buffer.name

      if name == "" then
        name = "[No Name]"
      end

      return buffer.bufnr .. "  " .. name
    end,
  }, function(buffer)
    if buffer then
      vim.api.nvim_set_current_buf(buffer.bufnr)
    end
  end)
end

function M.search_recent_files()
  vim.ui.select(RecentFile.list(), {
    prompt = "最近文件：",
    format_item = function(item)
      return item.text
    end,
  }, function(item)
    if item then
      RecentFile.open(item.path)
    end
  end)
end

function M.search_help()
  local topic = vim.fn.input("搜索帮助：", "", "help")
  if topic == "" then
    return
  end
  vim.cmd.help(topic)
end

function M.search_word()
  search_project(vim.fn.expand("<cword>"))
end

function M.find_git_files()
  local root = Project.root()

  local result = vim
    .system({
      "git",
      "-C",
      root,
      "ls-files",
    }, { text = true })
    :wait()

  if result.code ~= 0 then
    vim.notify("无法读取 Git 文件", vim.log.levels.WARN)
    return
  end

  local files = vim.split(result.stdout, "\n", {
    plain = true,
    trimempty = true,
  })

  vim.ui.select(files, {
    prompt = "搜索 Git 文件：",
  }, function(path)
    if path then
      vim.cmd.edit(vim.fn.fnameescape(root .. "/" .. path))
    end
  end)
end

return M
