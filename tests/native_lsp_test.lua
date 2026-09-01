local methods = {
  "hover",
  "definition",
  "references",
  "rename",
  "code_action",
}

local original = {}
local calls = {}

for _, method in ipairs(methods) do
  original[method] =
    vim.lsp.buf[method]

  calls[method] = 0

  vim.lsp.buf[method] = function()
    calls[method] =
      calls[method] + 1
  end
end

local NativeLsp =
  require("nvi.adapters.native_lsp")

local ok, error_message = xpcall(function()
  for _, method in ipairs(methods) do
    NativeLsp[method]()
  end

  for _, method in ipairs(methods) do
    assert(
      calls[method] == 1,
      string.format(
        "%s 应该调用一次 vim.lsp.buf.%s",
        method,
        method
      )
    )
  end
end, debug.traceback)

for _, method in ipairs(methods) do
  vim.lsp.buf[method] =
    original[method]
end

assert(ok, error_message)

print("native_lsp_test: OK")
