
local CodeIntelligencePort = require("nvi.ports.code_intelligence")

local native_lsp =
  require("nvi.adapters.native_lsp")
-- 真实的原生 LSP 适配器应该通过契约验证
--
assert(
  CodeIntelligencePort.validate(native_lsp) == native_lsp, 
  "native_lsp 应该符合代码智能端口"
)

-- 构造一个故意缺少 code_action 的适配器

local ok, error_message = pcall(function () 
  CodeIntelligencePort.validate({
    hover = function() end,
    definition = function() end,
    references = function() end,
    rename = function() end,
  })
end)

-- 不完整适配器必须验证失败
assert(
  not ok,
   "缺少 code_action 时应该验证失败"
)


-- 错误信息应该明确指出缺少的方法
assert(
  error_message:match("code_action"),
  "错误信息应该指出缺少 code_action"
)

print("code_intelligence_port_test: OK")
