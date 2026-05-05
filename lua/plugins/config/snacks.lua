local snacks = require("snacks")
local keymap = require("core.keymap")

keymap.nmap("<leader>gB", function() snacks.gitbrowse() end, { desc = "在浏览器中打开" })

keymap.vmap("<leader>gB", function() snacks.gitbrowse() end, { desc = "在浏览器中打开（带选中行）" })

snacks.dim.enable()

keymap.nmap("<leader>gb", function() snacks.git.blame_line() end, {
  desc = "Git Blame 当前行",
})

keymap.nmap("<leader>e", function() snacks.explorer() end, {
  desc = "文件浏览器",
})

keymap.nmap("<leader>tt", function()
  snacks.terminal.toggle(nil, {
    win = {
      position = "float",
      height = 0.8,
      width = 0.85,
      border = "rounded",
      keys = {
        ["<esc>"] = {
          "<esc>",
          function(self) self:hide() end,
          mode = "t", -- 必须指定 terminal 模式
          desc = "隐藏终端",
        },
        term_normal = {
          "<c-esc>",
          "<C-\\><C-n>",
          mode = "t",
          desc = "退出终端模式",
        },
      },
    },
  })
end, {
  desc = "浮动终端",
})

local default_terminal_keys = {
  ["<esc>"] = {
    "<esc>",
    function(self) self:hide() end,
    mode = "t", -- 必须指定 terminal 模式
    desc = "隐藏终端",
  },
  term_normal = {
    "<c-esc>",
    "<C-\\><C-n>",
    mode = "t",
    desc = "退出终端模式",
  },
}

local function create_terminal(cmd, title, keys)
  snacks.terminal.toggle(cmd, {
    win = {
      position = "float",
      height = 0.8,
      width = 0.85,
      border = "rounded",
      title = title,
      keys = table.deep_extend("force", default_terminal_keys, keys or {}),
    },
  })
end

keymap.batch({
  {
    "n",
    "<leader>tt",
    function() create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } }) end,
    { desc = "浮动终端" },
  },
  {
    "n",
    "<leader>tq",
    function() create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } }) end,
    { desc = "浮动终端" },
  },
  {
    "n",
    "<leader>tw",
    function() create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } }) end,
    { desc = "浮动终端" },
  },
  {
    "n",
    "<leader>te",
    function() create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } }) end,
    { desc = "浮动终端" },
  },
  {
    "n",
    "<leader>tr",
    function() create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } }) end,
    { desc = "浮动终端" },
  },
  {
    "n",
    "<leader>tg",
    function()
      snacks.lazygit()
      -- create_terminal("lazygit", { { " 🐚 Terminal ", "FloatTitle" } })
    end,
    { desc = "浮动终端" },
  },
})
