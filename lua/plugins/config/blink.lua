require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
  snippets = {
    preset = "luasnip",
  },
  keymap = {
    preset = "enter", -- 默认的快捷键
    ["<A-j>"] = { "select_next", "fallback" }, -- 向下选择
    ["<A-k>"] = { "select_prev", "fallback" }, -- 向上选择
    ["<A-d>"] = { "scroll_documentation_down" }, -- 向下滚动文档
    ["<A-u>"] = { "scroll_documentation_up" }, -- 向上滚动文档
    ["<Tab>"] = false,
    ["<S-Tab>"] = false,
  },
  -- 补全
  completion = {
    list = {
      selection = {
        preselect = true, -- 自动插入
        auto_insert = false, -- 自动插入
      },
    },
    menu = {
      border = "rounded", -- 边框
      draw = { -- 绘制
        columns = { -- 列
          { "kind_icon" }, -- 图标
          { "label", "label_description", gap = 1 }, -- 标签和描述
          { "kind" }, -- 类型
        },
      },
    },
    documentation = {
      auto_show = true, -- 自动显示
      auto_show_delay_ms = 200, -- 自动显示延迟
      window = { border = "rounded" }, -- 边框
    },
  },
  -- 源
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  -- 外观
  appearance = {
    nerd_font_variant = "mono", -- 字体变体
  },
})
local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  local n = require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
  if n then
    ls.jump(1)
  else
    require("luasnip").activate_node()
    while ls.jumpable(-1) do
      ls.jump(-1)
    end
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  local n = require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]

  if n then
    if ls.jumpable(-1) then
      ls.jump(-1)
    else
      while ls.jumpable(1) do
        ls.jump(1)
      end
    end
  else
    require("luasnip").activate_node()
    while ls.jumpable(1) do
      ls.jump(1)
    end
  end
end, { silent = true })
