local M = {}

function M.setup()
  vim.api.nvim_create_user_command("NviConfig", function()
    local config_file = vim.fn.stdpath("config") .. "/init.lua"

    vim.cmd.edit(vim.fn.fnameescape(config_file))
  end, {
    desc = "打开 NVI 配置入口",
    force = true,
  })
end

return M
