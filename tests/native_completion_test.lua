local original = {
  enable = vim.lsp.completion.enable,
  get = vim.lsp.completion.get,
}

local calls = {
  enable = nil,
  get = 0,
}

vim.lsp.completion.enable = function(
  enabled,
  client_id,
  bufnr,
  options
)
  calls.enable = {
    enabled = enabled,
    client_id = client_id,
    bufnr = bufnr,
    options = options,
  }
end

vim.lsp.completion.get = function()
  calls.get = calls.get + 1
end

local NativeCompletion =
  require("nvi.adapters.native_completion")

local context = {
  client_id = 42,
  bufnr = 17,
}

local ok, error_message = xpcall(function()
  NativeCompletion.enable(context)
  NativeCompletion.trigger()

  assert(
    calls.enable ~= nil,
    "enable 没有调用原生补全 API"
  )

  assert(
    calls.enable.enabled == true,
    "应该启用原生补全"
  )

  assert(
    calls.enable.client_id
      == context.client_id,
    "原生补全收到了错误的客户端 ID"
  )

  assert(
    calls.enable.bufnr == context.bufnr,
    "原生补全收到了错误的 Buffer"
  )

  assert(
    calls.enable.options.autotrigger
      == true,
    "原生补全应该启用自动触发"
  )

  assert(
    calls.get == 1,
    "trigger 应该调用一次 completion.get"
  )
end, debug.traceback)

vim.lsp.completion.enable =
  original.enable

vim.lsp.completion.get =
  original.get

assert(ok, error_message)

print("native_completion_test: OK")
