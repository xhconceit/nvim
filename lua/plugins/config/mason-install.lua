local masonToolInstaller = require("mason-tool-installer")

masonToolInstaller.setup({
  ensure_installed = {
    "lua-language-server",
    "jdtls",
    "java-debug-adapter", -- 可选，调试用
    "java-test", -- 可选，<leader>jt/jT 测试用
    "stylua",
    "google-java-format",
  },
  auto_update = false,
  run_on_start = true,
})
