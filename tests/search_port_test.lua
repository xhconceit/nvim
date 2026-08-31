
local SearchPort = require("nvi.ports.search")

local valid_adapter = {
  find_files = function() end,
  search_text = function() end,
}

assert(
  SearchPort.validate(valid_adapter) == valid_adapter,
  "有效适配器应该通过验证"
)

local ok, error_message = pcall(function()
  SearchPort.validate({
    find_files = function() end,
  })
end)

assert(
  not ok,
  "缺少 search_text 的适配器应该验证失败"
)

assert(
  error_message:match("search_text"),
  "错误信息应该指出缺少 search_text"
)

print("search_port_test: OK")
