local M = {}

function M.list(paths)
  paths = paths or vim.v.oldfiles or {}
  local items = {}
  local seen = {}

  for _, path in ipairs(paths) do
    if path ~= "" and not seen[path] then
      seen[path] = true

      table.insert(items, {
        path = path,
        text = path,
      })
    end
  end

  return items
end

function M.open(path)
  vim.cmd.edit(vim.fn.fnameescape(path))
end

return M
