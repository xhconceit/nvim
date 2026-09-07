local Project = require("nvi.core.project")
local M = {}

local float_terminal = {
  buffer = nil,
  window = nil,
}

local function open(split_command)
  local root = vim.fn.fnameescape(Project.root())

  vim.cmd(split_command .. " | lcd " .. root .. " | terminal")
  vim.cmd("startinsert")
end

function M.open_horizontal()
  open("botright 12split")
end

function M.open_vertical()
  open("botright vsplit")
end

local function float_config()
  local width = math.max(1, math.floor(vim.o.columns * 0.8))
  local height = math.max(1, math.floor(vim.o.lines * 0.75))

  return {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    title = " Terminal ",
    title_pos = "center",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
  }
end

local function create_float_buffer()
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[buffer].bufhidden = "hide"

  vim.api.nvim_buf_call(buffer, function()
    vim.fn.termopen(vim.o.shell, {
      cwd = Project.root(),
    })
  end)

  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
    buffer = buffer,
    desc = "退出终端输入模式",
  })

  vim.keymap.set("n", "<Esc>", function()
    M.toggle_float()
  end, {
    buffer = buffer,
    desc = "隐藏浮动终端",
  })

  return buffer
end

function M.toggle_float()
  if
    float_terminal.window
    and vim.api.nvim_win_is_valid(float_terminal.window)
  then
    vim.api.nvim_win_hide(float_terminal.window)
    float_terminal.window = nil
    return
  end

  if
    not float_terminal.buffer
    or not vim.api.nvim_buf_is_valid(float_terminal.buffer)
  then
    float_terminal.buffer = create_float_buffer()
  end

  float_terminal.window =
    vim.api.nvim_open_win(float_terminal.buffer, true, float_config())
  vim.cmd("startinsert")
end

return M
