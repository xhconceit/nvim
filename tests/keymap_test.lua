local Keymap = require("nvi.ui.keymap")

Keymap.nmap(
  "<F12>",
  function() end,
  "测试全局快捷键"
)

local global_mapping = nil

for _, mapping in ipairs(vim.api.nvim_get_keymap("n")) do
  if mapping.desc == "测试全局快捷键" then
    global_mapping = mapping
    break
  end
end

assert(
  global_mapping ~= nil,
  "Keymap.set 没有注册全局快捷键"
)

assert(
  global_mapping.silent == 1,
  "Keymap.set 应该默认启用 silent"
)

local function has_mapping(mode, description)
  for _, mapping in ipairs(vim.api.nvim_get_keymap(mode)) do
    if mapping.desc == description then
      return true
    end
  end

  return false
end

local mode_cases = {
  { name = "map", mode = "", inspect_mode = "n" },
  { name = "nmap", mode = "n", inspect_mode = "n" },
  { name = "vmap", mode = "v", inspect_mode = "v" },
  { name = "xmap", mode = "x", inspect_mode = "x" },
  { name = "smap", mode = "s", inspect_mode = "s" },
  { name = "omap", mode = "o", inspect_mode = "o" },
  { name = "map_bang", mode = "!", inspect_mode = "i" },
  { name = "imap", mode = "i", inspect_mode = "i" },
  { name = "lmap", mode = "l", inspect_mode = "l" },
  { name = "cmap", mode = "c", inspect_mode = "c" },
  { name = "tmap", mode = "t", inspect_mode = "t" },
}

for _, case in ipairs(mode_cases) do
  local lhs = "<Plug>(NviTest" .. case.name .. ")"
  local description = "测试 " .. case.name

  Keymap[case.name](lhs, function() end, description)

  assert(
    has_mapping(case.inspect_mode, description),
    "Keymap." .. case.name .. " 没有注册正确模式的快捷键"
  )

  vim.keymap.del(case.mode, lhs)
end

local ok, error_message = pcall(function()
  Keymap.set("n", "<F11>", function() end)
end)

assert(
  not ok,
  "缺少 desc 的快捷键应该注册失败"
)

assert(
  error_message:match("desc"),
  "错误信息应该指出缺少 desc"
)

local bufnr = vim.api.nvim_create_buf(false, true)

Keymap.buffer(
  bufnr,
  "n",
  "<F10>",
  function() end,
  {
    desc = "测试 Buffer 快捷键",
    nowait = true,
  }
)

local buffer_mapping = nil

for _, mapping in ipairs(
  vim.api.nvim_buf_get_keymap(bufnr, "n")
) do
  if mapping.desc == "测试 Buffer 快捷键" then
    buffer_mapping = mapping
    break
  end
end

assert(
  buffer_mapping ~= nil,
  "Keymap.buffer 没有注册 Buffer 快捷键"
)

assert(
  buffer_mapping.nowait == 1,
  "table options 应该保留自定义选项"
)

Keymap.del("n", "<F12>")
vim.api.nvim_buf_delete(bufnr, {
  force = true,
})

print("keymap_test: OK")
