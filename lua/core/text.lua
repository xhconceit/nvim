local M = {}

function M.get_selected_text()
  local start = vim.fn.getpos("v")
  local ends = vim.fn.getpos(".")
  local s_row, s_col = start[2], start[3]
  local e_row, e_col = ends[2], ends[3]

  -- 保证 start <= end
  if s_row > e_row or (s_row == e_row and s_col > e_col) then
    s_row, e_row = e_row, s_row
    s_col, e_col = e_col, s_col
  end

  local lines = vim.api.nvim_buf_get_text(0, s_row - 1, s_col - 1, e_row - 1, e_col, {})
  return table.concat(lines, "\n")
end

return M
