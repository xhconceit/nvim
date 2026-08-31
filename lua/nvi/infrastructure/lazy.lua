local M  = {}

function M.setup()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local repository = "https://github.com/folke/lazy.nvim"

    local output = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      repository,
      lazypath
    })

    if vim.v.shell_error ~= 0 then
      error("无法安装 lazy.nvim:\n" .. output)
    end
  end

  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    spec = {
      { import = "nvi.infrastructure.plugins" }
    },
    install = {
      colorscheme = { "habamax" }
    },
    checker = {
      enabled = false
    },
    change_detection = {
      notify = false
    }
  })

end

return M
