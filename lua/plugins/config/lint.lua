local eslint_config_files = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
  ".eslintrc.yml",
  ".eslintrc.yaml",
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  "eslint.config.mts",
  "eslint.config.cts",
}

local js_filetypes = {
  javascript = true,
  typescript = true,
  javascriptreact = true,
  typescriptreact = true,
  vue = true,
  svelte = true,
}

local function has_eslint_config(bufnr)
  return vim.fs.find(eslint_config_files, {
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    upward = true,
    stop = vim.uv.os_homedir(),
  })[1] ~= nil
end


local lint = require("lint")

-- brew install checkstyle pmd
lint.linters_by_ft = {
  java = { "checkstyle", "pmd" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if js_filetypes[ft] then
      if has_eslint_config(args.buf) then
        lint.try_lint("eslint")
      else
        lint.try_lint("oxlint")
      end
    else
      lint.try_lint()
    end
  end,
})
