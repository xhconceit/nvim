local calls = {
  open = 0,
  close = 0,
  next_item = 0,
  previous_item = 0,
}

local adapter = {}

for name in pairs(calls) do
  adapter[name] = function()
    calls[name] = calls[name] + 1
  end
end

require("nvi.features.quickfix").setup(adapter)

local expected = {
  ["<leader>xo"] = {
    method = "open",
    desc = "打开 Quickfix 列表",
  },
  ["<leader>xc"] = {
    method = "close",
    desc = "关闭 Quickfix 列表",
  },
  ["]q"] = {
    method = "next_item",
    desc = "下一个 Quickfix 项",
  },
  ["[q"] = {
    method = "previous_item",
    desc = "上一个 Quickfix 项",
  },
}

for lhs, expectation in pairs(expected) do
  local mapping = vim.fn.maparg(
    lhs,
    "n",
    false,
    true
  )

  assert(
    mapping.desc == expectation.desc,
    lhs .. " 没有注册正确描述"
  )

  assert(
    type(mapping.callback) == "function",
    lhs .. " 没有注册 Lua callback"
  )

  mapping.callback()

  assert(
    calls[expectation.method] == 1,
    lhs .. " 没有调用正确的 Quickfix 方法"
  )
end

print("quickfix_test: OK")
