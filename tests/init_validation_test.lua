local Nvi = require("nvi")

local function no_op_setup()
end

local function create_dependencies()
  return {
    core = {
      commands = { setup = no_op_setup },
      options = { setup = no_op_setup },
      keymaps = { setup = no_op_setup },
      autocmds = { setup = no_op_setup },
    },
    lazy = {
      setup = no_op_setup,
    },
    search = {
      feature = {
        setup = no_op_setup,
      },
      adapter = {},
    },
    git = {
      feature = {
        setup = no_op_setup,
      },
      adapter = {},
    },
    file_explorer = {
      feature = {
        setup = no_op_setup,
      },
      adapter = {},
    },
    formatting = {
      feature = {
        setup = no_op_setup,
      },
      adapter = {},
    },
    lsp = {
      composition = {
        setup = no_op_setup,
      },
      dependencies = {},
    },
  }
end

local missing_core_ok,
  missing_core_error = pcall(
    Nvi.setup,
    {}
  )

local missing_search_dependencies =
  create_dependencies()
missing_search_dependencies.search.adapter = nil

local missing_search_ok,
  missing_search_error = pcall(
    Nvi.setup,
    missing_search_dependencies
  )

local missing_explorer_feature_dependencies =
  create_dependencies()
missing_explorer_feature_dependencies
  .file_explorer.feature.setup = nil

local missing_explorer_feature_ok,
  missing_explorer_feature_error = pcall(
    Nvi.setup,
    missing_explorer_feature_dependencies
  )

local missing_explorer_adapter_dependencies =
  create_dependencies()
missing_explorer_adapter_dependencies
  .file_explorer.adapter = nil

local missing_explorer_adapter_ok,
  missing_explorer_adapter_error = pcall(
    Nvi.setup,
    missing_explorer_adapter_dependencies
  )

local missing_git_feature_dependencies =
  create_dependencies()
missing_git_feature_dependencies.git.feature.setup = nil

local missing_git_feature_ok,
  missing_git_feature_error = pcall(
    Nvi.setup,
    missing_git_feature_dependencies
  )

local missing_git_adapter_dependencies =
  create_dependencies()
missing_git_adapter_dependencies.git.adapter = nil

local missing_git_adapter_ok,
  missing_git_adapter_error = pcall(
    Nvi.setup,
    missing_git_adapter_dependencies
  )

assert(
  not missing_core_ok,
  "缺少 core.commands.setup 时应该拒绝启动"
)
assert(
  tostring(missing_core_error):find(
    "core.commands.setup",
    1,
    true
  ),
  "错误应该指出缺少 core.commands.setup"
)

assert(
  not missing_search_ok,
  "缺少 search.adapter 时应该拒绝启动"
)
assert(
  tostring(missing_search_error):find(
    "search.adapter",
    1,
    true
  ),
  "错误应该指出缺少 search.adapter"
)

assert(
  not missing_explorer_feature_ok,
  "缺少文件浏览器功能时应该拒绝启动"
)

assert(
  not missing_git_feature_ok,
  "缺少 Git 功能时应该拒绝启动"
)
assert(
  tostring(missing_git_feature_error):find(
    "git.feature.setup",
    1,
    true
  ),
  "错误应该指出缺少 git.feature.setup"
)

assert(
  not missing_git_adapter_ok,
  "缺少 Git 适配器时应该拒绝启动"
)
assert(
  tostring(missing_git_adapter_error):find(
    "git.adapter",
    1,
    true
  ),
  "错误应该指出缺少 git.adapter"
)
assert(
  tostring(missing_explorer_feature_error):find(
    "file_explorer.feature.setup",
    1,
    true
  ),
  "错误应该指出缺少 file_explorer.feature.setup"
)

assert(
  not missing_explorer_adapter_ok,
  "缺少文件浏览器适配器时应该拒绝启动"
)
assert(
  tostring(missing_explorer_adapter_error):find(
    "file_explorer.adapter",
    1,
    true
  ),
  "错误应该指出缺少 file_explorer.adapter"
)

print("init_validation_test: OK")
