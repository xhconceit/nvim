local config = require("nvi.infrastructure.lsp.servers.dartls")

assert(
  vim.deep_equal(config.cmd, {
    "fvm",
    "dart",
    "language-server",
    "--protocol=lsp",
  }),
  "dartls 应该通过 FVM 管理的 Dart SDK 启动语言服务器"
)

assert(
  vim.tbl_contains(config.filetypes, "dart"),
  "dartls 应该支持 Dart 文件"
)

assert(
  vim.tbl_contains(config.root_markers, "pubspec.yaml"),
  "dartls 应该使用 pubspec.yaml 识别 Flutter 项目根目录"
)

assert(
  config.workspace_required == true,
  "dartls 应该只在 Dart 或 Flutter 项目中启动"
)

print("dartls_config_test: OK")
