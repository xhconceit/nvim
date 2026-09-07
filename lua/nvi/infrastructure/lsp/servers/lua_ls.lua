-- lua-language-server
--
return {
  cmd = {
    "lua-language-server",
  },
  filetypes = {
    "lua",
  },
  -- 按顺序寻找项目根目录
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".git",
  },
  -- 没有项目根标记时也允许启动
  workspace_required = false,

  settings = {
    Lua = {
      -- Neovim 使用 LuaJIT
      runtime = {
        version = "LuaJIT",
      },
      -- 让服务器认识 Neovim 的 vim 全局变量
      diagnostics = {
        globals = {
          "vim",
        },
      },

      -- 把 Neovim 运行时 Lua 文件加入工作区
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
