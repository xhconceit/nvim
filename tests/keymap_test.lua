local Keymap = require("nvi.ui.keymap")

Keymap.nmap("<F12>", function() end, "测试全局快捷键")

local global_mapping = nil

for _, mapping in ipairs(vim.api.nvim_get_keymap("n")) do
  if mapping.desc == "测试全局快捷键" then
    global_mapping = mapping
    break
  end
end

assert(global_mapping ~= nil, "Keymap.set 没有注册全局快捷键")

assert(global_mapping.silent == 1, "Keymap.set 应该默认启用 silent")

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

assert(not ok, "缺少 desc 的快捷键应该注册失败")

assert(error_message:match("desc"), "错误信息应该指出缺少 desc")

local bufnr = vim.api.nvim_create_buf(false, true)

Keymap.buffer(bufnr, "n", "<F10>", function() end, {
  desc = "测试 Buffer 快捷键",
  nowait = true,
})

local buffer_mapping = nil

for _, mapping in ipairs(vim.api.nvim_buf_get_keymap(bufnr, "n")) do
  if mapping.desc == "测试 Buffer 快捷键" then
    buffer_mapping = mapping
    break
  end
end

assert(buffer_mapping ~= nil, "Keymap.buffer 没有注册 Buffer 快捷键")

assert(buffer_mapping.nowait == 1, "table options 应该保留自定义选项")

Keymap.del("n", "<F12>")
vim.api.nvim_buf_delete(bufnr, {
  force = true,
})

local original_api = {
  get_keymap = vim.api.nvim_get_keymap,
  get_current_buf = vim.api.nvim_get_current_buf,
  buf_get_keymap = vim.api.nvim_buf_get_keymap,
  replace_termcodes = vim.api.nvim_replace_termcodes,
  feedkeys = vim.api.nvim_feedkeys,
}

local calls = {
  replaced_keys = nil,
  feedkeys = nil,
}

vim.api.nvim_get_keymap = function(mode)
  assert(mode == "n", "应该读取指定模式的快捷键")

  return {
    {
      lhs = "<leader>ff",
      desc = "搜索文件",
    },
    {
      lhs = "gd",
      desc = "全局跳转定义",
    },
    {
      lhs = "<F12>",
    },
    {
      lhs = "<F11>",
      desc = "",
    },
  }
end

vim.api.nvim_get_current_buf = function()
  return 42
end

vim.api.nvim_buf_get_keymap = function(bufnr, mode)
  assert(bufnr == 42, "应该读取当前 Buffer 的快捷键")
  assert(mode == "n", "应该读取相同模式的 Buffer 快捷键")

  return {
    {
      lhs = "gd",
      desc = "跳转到定义",
    },
    {
      lhs = "<F10>",
    },
  }
end

vim.api.nvim_replace_termcodes = function(keys, from_part, do_lt, special)
  calls.replaced_keys = {
    keys = keys,
    from_part = from_part,
    do_lt = do_lt,
    special = special,
  }

  return "encoded:" .. keys
end

vim.api.nvim_feedkeys = function(keys, mode, escape)
  calls.feedkeys = {
    keys = keys,
    mode = mode,
    escape = escape,
  }
end

local catalog_ok, catalog_error = xpcall(function()
  local items = Keymap.list("n")

  assert(#items == 2, "Buffer 快捷键应该覆盖同 lhs 的全局快捷键")

  assert(
    vim.deep_equal(items[1], {
      lhs = "<leader>ff",
      desc = "搜索文件",
      text = "<leader>ff  搜索文件",
    }),
    "Keymap.list 生成了错误的快捷键条目"
  )

  assert(
    vim.deep_equal(items[2], {
      lhs = "gd",
      desc = "跳转到定义",
      text = "gd  跳转到定义",
    }),
    "Keymap.list 没有生成 Buffer 快捷键条目"
  )

  Keymap.execute(items[1].lhs)

  assert(
    calls.replaced_keys.keys == "<leader>ff",
    "Keymap.execute 应该转换快捷键编码"
  )

  assert(
    calls.feedkeys.keys == "encoded:<leader>ff"
      and calls.feedkeys.mode == "m"
      and calls.feedkeys.escape == false,
    "Keymap.execute 应该执行转换后的快捷键"
  )
end, debug.traceback)

vim.api.nvim_get_keymap = original_api.get_keymap
vim.api.nvim_get_current_buf = original_api.get_current_buf
vim.api.nvim_buf_get_keymap = original_api.buf_get_keymap
vim.api.nvim_replace_termcodes = original_api.replace_termcodes
vim.api.nvim_feedkeys = original_api.feedkeys

assert(catalog_ok, catalog_error)

print("keymap_test: OK")
