local M = {}

local function production_dependencies()
  local uv = vim.uv or vim.loop

  return {
    exists = function(path)
      return uv.fs_stat(path) ~= nil
    end,

    clone = function(repository, path)
      local output = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        repository,
        path,
      })

      return vim.v.shell_error, output
    end,
    prepend_runtimepath = function(path)
      vim.opt.runtimepath:prepend(path)
    end,
    setup_lazy = function(options)
      require("lazy").setup(options)
    end,
  }
end

local function validate(dependencies)
  assert(type(dependencies) == "table", "lazy infrastructure 需要依赖")

  local required_methods = {
    "exists",
    "clone",
    "prepend_runtimepath",
    "setup_lazy",
  }

  for _, method in ipairs(required_methods) do
    assert(
      type(dependencies[method]) == "function",
      string.format("lazy infrastructure 缺少方法：%s", method)
    )
  end

  return dependencies
end

function M.setup(dependencies)
  dependencies = validate(dependencies or production_dependencies())

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  local repository = "https://github.com/folke/lazy.nvim"

  if not dependencies.exists(lazypath) then
    local exit_code, output = dependencies.clone(repository, lazypath)

    if exit_code ~= 0 then
      error("无法安装 lazy.nvim:\n" .. tostring(output))
    end
  end

  dependencies.prepend_runtimepath(lazypath)

  dependencies.setup_lazy({
    spec = {
      {
        import = "nvi.infrastructure.plugins",
      },
    },

    install = {
      colorscheme = {
        "habamax",
      },
    },

    checker = {
      enabled = false,
    },

    change_detection = {
      notify = false,
    },
  })
end

return M
