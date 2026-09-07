local received_request = nil

local fake_formatter = {}

function fake_formatter.format_buffer(request)
  received_request = request
end

function fake_formatter.format_range(request)
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
  received_request.bufnr == vim.api.nvim_get_current_buf(),
  "格式化请求包含了错误的 Buffer"
)

local range_mapping
for _, candidate in ipairs(vim.api.nvim_get_keymap("v")) do
  if candidate.desc == "格式化选中代码" then
    range_mapping = candidate
    break
  end
end

assert(range_mapping ~= nil, "找不到选区格式化快捷键")
assert(
  type(range_mapping.callback) == "function",
  "选区格式化应该使用 Lua callback"
)
received_request = nil
range_mapping.callback()
assert(type(received_request) == "table", "选区格式化没有收到请求")
assert(
  received_request.range.start[2] == 0,
  "选区格式化起始列应该为 0"
)
assert(
  received_request.range["end"][2] == 0,
  "选区格式化结束列应该为 0"
)
