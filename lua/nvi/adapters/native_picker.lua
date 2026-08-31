local M = {}

function M.find_files()
  -- 获取文件名
  local path = vim.fn.input("打开文件：", "", "file")

  if path == "" then
    return
  end

  -- 打开文件
  vim.cmd.edit(
    -- 正确处理空格等特殊字符
    vim.fn.fnameescape(path)
  )
end

function M.search_text()
  local text = vim.fn.input("搜索文本：")

  if text == "" then
    return
  end

  local pattern = "\\V"
  .. vim.fn.escape(text, [[\/]])

  local ok = pcall(
    vim.cmd,
    "silent vimgrep /"
    .. pattern
    .. "/gj **/*"
  )

  if not ok then
    vim.notify(
      "没有找到：" .. text,
      vim.log.levels.WARN
    )
    return
  end

  vim.cmd("copen")
end

return M
