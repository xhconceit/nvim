local test_files = vim.fn.glob("tests/*_test.lua", false, true)
table.sort(test_files)

local passed = 0
local failures = {}

for _, file in ipairs(test_files) do
  local ok, error_message = xpcall(function()
    dofile(file)
  end, debug.traceback)

  if ok then
    passed = passed + 1
    print("PASS " .. file)
  else
    table.insert(failures, {
      file = file,
      message = error_message,
    })

    vim.api.nvim_err_writeln("FAIL " .. file)
  end
end -- for 循环必须在这里结束

print(string.format("\n结果：%d 通过，%d 失败", passed, #failures))

if #failures > 0 then
  for _, failure in ipairs(failures) do
    vim.api.nvim_err_writeln("\n" .. failure.file .. "\n" .. failure.message)
  end

  vim.cmd("cquit 1")
  return
end

vim.cmd("qa!")
