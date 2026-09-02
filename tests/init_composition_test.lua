local Nvi = require("nvi")

local calls = {
  commands = 0,
  options = 0,
  keymaps = 0,
  autocmds = 0,
  lazy = 0,
  search = nil,
  file_explorer = nil,
  formatting = nil,
  lsp = nil,
}

local function setup_counter(name)
  return {
    setup = function()
      calls[name] = calls[name] + 1
    end,
  }
end

local search_adapter = {
  name = "fake search adapter",
}
local file_explorer_adapter = {
  name = "fake file explorer adapter",
}
local formatter_adapter = {
  name = "fake formatter adapter",
}

local lsp_dependencies = {
  infrastructure = {
    name = "fake lsp infrastructure",
  },
  code_intelligence = {
    feature = {
      name = "fake code intelligence feature",
    },
    adapter = {
      name = "fake code intelligence adapter",
    },
  },
  completion = {
    feature = {
      name = "fake completion feature",
    },
    adapter = {
      name = "fake completion adapter",
    },
  },
  diagnostics = {
    feature = {
      name = "fake diagnostics feature",
    },
    adapter = {
      name = "fake diagnostics adapter",
    },
  },
  servers = {
    lua_ls = {
      name = "fake lua_ls server",
    },
  },
}

local dependencies = {
  core = {
    commands = setup_counter("commands"),
    options = setup_counter("options"),
    keymaps = setup_counter("keymaps"),
    autocmds = setup_counter("autocmds"),
  },
  lazy = setup_counter("lazy"),
  search = {
    feature = {
      setup = function(adapter)
        calls.search = adapter
      end,
    },
    adapter = search_adapter,
  },
  file_explorer = {
    feature = {
      setup = function(adapter)
        calls.file_explorer = adapter
      end,
    },
    adapter = file_explorer_adapter,
  },
  formatting = {
    feature = {
      setup = function(adapter)
        calls.formatting = adapter
      end,
    },
    adapter = formatter_adapter,
  },
  lsp = {
    composition = {
      setup = function(received)
        calls.lsp = received
      end,
    },
    dependencies = lsp_dependencies,
  },
}

Nvi.setup(dependencies)

for _, name in ipairs({
  "commands",
  "options",
  "keymaps",
  "autocmds",
  "lazy",
}) do
  assert(
    calls[name] == 1,
    name .. " 应该初始化一次"
  )
end

assert(
  calls.search == search_adapter,
  "搜索功能没有收到注入的适配器"
)
assert(
  calls.file_explorer
    == file_explorer_adapter,
  "文件浏览器没有收到 mini.files 适配器"
)
assert(
  calls.formatting == formatter_adapter,
  "格式化功能没有收到注入的适配器"
)
assert(
  calls.lsp == lsp_dependencies,
  "LSP 组合根没有收到完整的依赖对象"
)

assert(
  calls.lsp.infrastructure
    == lsp_dependencies.infrastructure,
  "LSP 基础设施接线错误"
)
assert(
  calls.lsp.code_intelligence
    == lsp_dependencies.code_intelligence,
  "代码智能接线错误"
)
assert(
  calls.lsp.completion
    == lsp_dependencies.completion,
  "补全接线错误"
)
assert(
  calls.lsp.diagnostics
    == lsp_dependencies.diagnostics,
  "诊断接线错误"
)
assert(
  calls.lsp.servers.lua_ls
    == lsp_dependencies.servers.lua_ls,
  "lua_ls 服务配置接线错误"
)

print("init_composition_test: OK")
