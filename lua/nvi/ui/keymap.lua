local M = {}

local function normalize_options(options)
  if type(options) == "string" then
    options = {
      desc = options,
    }
  end

  assert(
    type(options) == "table",
    "options 必须是 desc 字符串或 table"
  )

  options = vim.tbl_extend(
    "force",
    {
      silent = true,
    },
    options
  )

  assert(
    type(options.desc) == "string"
    and options.desc ~= "",
    "快捷键必须提供非空 desc"
  )

  return options
end

function M.set(mode, lhs, rhs, options)
  vim.keymap.set(
    mode,
    lhs,
    rhs,
    normalize_options(options)
  )
end

function M.del(mode, lhs, options)
  vim.keymap.del(
    mode,
    lhs,
    options or {}
  )
end

local mode_helpers = {
  map = "",
  nmap = "n",
  vmap = "v",
  xmap = "x",
  smap = "s",
  omap = "o",
  map_bang = "!",
  imap = "i",
  lmap = "l",
  cmap = "c",
  tmap = "t",
}

for name, mode in pairs(mode_helpers) do
  M[name] = function(lhs, rhs, options)
    M.set(mode, lhs, rhs, options)
  end
end

function M.buffer(bufnr, mode, lhs, rhs, options)
  assert(
    type(bufnr) == "number"
    and vim.api.nvim_buf_is_valid(bufnr),
    "Buffer 快捷键需要有效的 Buffer"
  )

  options = vim.tbl_extend(
    "force",
    normalize_options(options),
    {
      buffer = bufnr,
    }
  )

  M.set(mode, lhs, rhs, options)
end

function M.list(mode)
  local items = {}
  local mappings = vim.api.nvim_get_keymap(mode)

  vim.list_extend(
    mappings,
    vim.api.nvim_buf_get_keymap(
      vim.api.nvim_get_current_buf(),
      mode
    )
  )

  local mapping_by_lhs = {}
  local lhs_order = {}

  for _, mapping in ipairs(mappings) do
    if mapping_by_lhs[mapping.lhs] == nil then
      table.insert(lhs_order, mapping.lhs)
    end

    mapping_by_lhs[mapping.lhs] = mapping
  end

  for _, lhs in ipairs(lhs_order) do
    local mapping = mapping_by_lhs[lhs]

    if mapping.desc and mapping.desc ~= "" then
      table.insert(items, {
        lhs = mapping.lhs,
        desc = mapping.desc,
        text = mapping.lhs .. "  " .. mapping.desc,
      })
    end
  end

  return items
end

function M.execute(lhs)
  local keys = vim.api.nvim_replace_termcodes(
    lhs,
    true,
    false,
    true
  )

  vim.api.nvim_feedkeys(keys, "m", false)
end

return M
