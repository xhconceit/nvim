local M = {}

-- 清除自己的模块依赖
local function clear_nvi_modules()
  local modules = {}
  -- 循环要加加载的模块
  for name in pairs(package.loaded) do
    -- 自己的配置
    if name == "nvi" or name:match("^nvi%.") then
      table.insert(modules, name)
    end
  end

  -- 清除刚刚收集的模块
  for _, name in ipairs(modules) do
    package.loaded[name] = nil
  end
end

-- 重新加载
local function reload_config()
  -- 
  local ok, error_message = xpcall(function()
    -- 清空模块依赖
    clear_nvi_modules()
    -- 重新加载
    require("nvi").setup()
  end, debug.traceback)

  if not ok then
    vim.notify(error_message, vim.log.levels.ERROR, {
      title = "NVI 重载失败"
    })
    return
  end

  vim.notify("配置重新加载成功", vim.log.levels.INFO, {
    title = "NVI",
  })
end

function M.setup()
  -- 打开配置命令
  vim.api.nvim_create_user_command("NviConfig", function()
    local config_file = vim.fn.stdpath("config") .. "/init.lua"
    vim.cmd.edit(vim.fn.fnameescape(config_file))
  end, {
    desc = "打开 NVI 配置入口",
    force = true,
  })

  -- 重新加载配置命令
  vim.api.nvim_create_user_command("NviReload", reload_config, {
    desc = "重新加载 NVI 配置",
    force = true
  })
end

return M
