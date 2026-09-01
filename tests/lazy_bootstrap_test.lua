local LazyInfrastructure =
  require("nvi.infrastructure.lazy")

local expected_path =
  vim.fn.stdpath("data")
  .. "/lazy/lazy.nvim"
local expected_repository =
  "https://github.com/folke/lazy.nvim"

local function create_dependencies(result)
  local calls = {
    clone = {},
    prepend_runtimepath = {},
    setup_lazy = {},
  }

  local dependencies = {
    exists = function(path)
      calls.exists_path = path
      return false
    end,
    clone = function(repository, path)
      table.insert(calls.clone, {
        repository = repository,
        path = path,
      })

      return result.exit_code, result.output
    end,
    prepend_runtimepath = function(path)
      table.insert(calls.prepend_runtimepath, path)
    end,
    setup_lazy = function(options)
      table.insert(calls.setup_lazy, options)
    end,
  }

  return dependencies, calls
end

do
  local dependencies, calls =
    create_dependencies({
      exit_code = 0,
      output = "",
    })

  LazyInfrastructure.setup(dependencies)

  assert(
    calls.exists_path == expected_path,
    "bootstrap 检查了错误的安装路径"
  )
  assert(
    #calls.clone == 1,
    "lazy.nvim 不存在时应该克隆一次"
  )
  assert(
    calls.clone[1].repository
      == expected_repository,
    "bootstrap 使用了错误的仓库"
  )
  assert(
    calls.clone[1].path == expected_path,
    "bootstrap 克隆到了错误的路径"
  )
  assert(
    calls.prepend_runtimepath[1]
      == expected_path,
    "克隆成功后没有加入 runtimepath"
  )
  assert(
    #calls.setup_lazy == 1,
    "克隆成功后没有调用 lazy.setup"
  )
end

do
  local dependencies, calls =
    create_dependencies({
      exit_code = 1,
      output = "simulated clone failure",
    })

  local ok, error_message = pcall(
    LazyInfrastructure.setup,
    dependencies
  )

  assert(
    not ok,
    "克隆失败时 setup 应该失败"
  )
  assert(
    tostring(error_message):find(
      "simulated clone failure",
      1,
      true
    ),
    "错误信息应该保留 Git 的失败输出"
  )
  assert(
    #calls.clone == 1,
    "克隆失败场景应该只尝试一次"
  )
  assert(
    #calls.prepend_runtimepath == 0,
    "克隆失败后不应该修改 runtimepath"
  )
  assert(
    #calls.setup_lazy == 0,
    "克隆失败后不应该调用 lazy.setup"
  )
end

print("lazy_bootstrap_test: OK")
