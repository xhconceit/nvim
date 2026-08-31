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

return M
