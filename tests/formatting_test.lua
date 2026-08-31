local received_request = nil

local fake_formatter = {}

function fake_formatter.format_buffer(request)
  received_request = request
end

require("nvi.features.formatting").setup(fake_formatter)

local function find_mapping(description)
  for _, mapping in ipairs(vim.api.nvim_get_keymap("n")) do
    if mapping.desc == description then
      return mapping
    end
  end

  error("找不到快捷键: " .. description)
end

local mapping = find_mapping("格式化当前文件")

assert(
  type(mapping.callback) == "function",
  "格式化快捷键没有 Lua callback"
)

mapping.callback()

assert(
  type(received_request) == "table",
  "格式化适配器没有收到请求"
)

assert(
  received_request.bufnr
    == vim.api.nvim_get_current_buf(),
  "格式化请求包含了错误的 Buffer"
)
