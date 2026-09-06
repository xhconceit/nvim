
local M = {}

-- 代码智能适配器必须提供的能力
local required_methods = {
  "hover",
  "definition",
  "references",
  "rename",
  "code_action",
  "declaration", -- 跳转到声明
  "implementation",
  "type_definition",
  "document_symbol",
  "workspace_symbol",
  "signature_help",
}

-- 验证具体适配器是否符合端口契约
function M.validate(adapter)
  assert(
    type(adapter) == "table",
    "code intelligence adapter 必须是 table"
  )

    -- 每个必要能力都必须由函数实现
  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      string.format(
        "code intelligence adapter 缺少方法：%s",
        method
      )
    )
  end
  return adapter
end

return M
