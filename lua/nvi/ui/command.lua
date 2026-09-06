local M = {}

local function to_item(name, command)
  local desc = command.desc or ""
  local text = name

  if desc ~= "" then
    text = name .. "  " .. desc
  end

  return {
    name = name,
    desc = desc,
    text = text,
  }
end

function M.list()
  local commands = vim.api.nvim_get_commands({
    builtin = false,
  })

  local buffer_commands = vim.api.nvim_buf_get_commands(
    vim.api.nvim_get_current_buf(),
    {}
  )

  for name, command in pairs(buffer_commands) do
    commands[name] = command
  end

  local names = vim.tbl_keys(commands)
  table.sort(names)

  local items = {}

  for _, name in ipairs(names) do
    table.insert(
      items,
      to_item(name, commands[name])
    )
  end

  return items
end

function M.execute(name)
  vim.cmd(name)
end

return M
