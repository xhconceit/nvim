local original_format = vim.lsp.buf.format

local received_options = nil

vim.lsp.buf.format = function(options)
  received_options = options
end

local LspFormatter = require("nvi.adapters.lsp_formatter")

local request = {
  bufnr = 17,
}

local ok, error_message = xpcall(function()
  LspFormatter.format_buffer(request)

  assert(
    type(received_options) == "table",
    "格式化适配器没有调用 vim.lsp.buf.format"
  )

  assert(
    received_options.bufnr == request.bufnr,
    "格式化适配器传递了错误的 Buffer"
  )

  assert(received_options.async == true, "LSP 格式化应该异步执行")

  LspFormatter.format_range({
    bufnr = request.bufnr,
    range = {
      start = { 0, 0 },
      ["end"] = { 2, 0 },
    },
  })

  assert(
    received_options.range["end"][1] == 2,
    "范围格式化传递了错误的结束行"
  )
end, debug.traceback)

vim.lsp.buf.format = original_format

assert(ok, error_message)

print("lsp_formatter_test: OK")
