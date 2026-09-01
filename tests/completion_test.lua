local enabled_context = nil
local trigger_count = 0

local fake_completion = {}

function fake_completion.enable(context)
  enabled_context = context
end

function fake_completion.trigger()
  trigger_count = trigger_count + 1
end

local bufnr = vim.api.nvim_create_buf(
  false,
  true
)

local context = {
  bufnr = bufnr,
  client_id = 42,
}

require("nvi.features.completion").attach(
  fake_completion,
  context
)

assert(
  enabled_context == context,
  "补全功能没有把 LSP 上下文传给适配器"
)

assert(
  enabled_context.bufnr == bufnr,
  "补全适配器收到了错误的 Buffer"
)

assert(
  enabled_context.client_id == 42,
  "补全适配器收到了错误的客户端 ID"
)

local trigger_mapping = nil

for _, mapping in ipairs(
  vim.api.nvim_buf_get_keymap(bufnr, "i")
) do
  if mapping.desc == "触发代码补全" then
    trigger_mapping = mapping
    break
  end
end

assert(
  trigger_mapping ~= nil,
  "没有注册手动补全快捷键"
)

assert(
  type(trigger_mapping.callback) == "function",
  "补全快捷键没有 Lua callback"
)

trigger_mapping.callback()

assert(
  trigger_count == 1,
  "补全快捷键应该调用一次 trigger"
)

vim.api.nvim_buf_delete(bufnr, {
  force = true,
})

print("completion_test: OK")
