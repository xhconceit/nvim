local M = {}

local default_opts = { noremap = true, silent = true }

function M.map(mode, lhs, rhs, opts)
    opts = vim.tbl_deep_extend("force", default_opts, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.nmap(lhs, rhs, opts) M.map("n", lhs, rhs, opts) end

function M.imap(lhs, rhs, opts) M.map("i", lhs, rhs, opts) end

function M.vmap(lhs, rhs, opts) M.map("v", lhs, rhs, opts) end

function M.tmap(lhs, rhs, opts) M.map("t", lhs, rhs, opts) end

function M.xmap(lhs, rhs, opts) M.map("x", lhs, rhs, opts) end

function M.cmap(lhs, rhs, opts) M.map("c", lhs, rhs, opts) end

--- 批量注册快捷键
--- @param mappings table[] { mode, lhs, rhs, opts }
function M.batch(mappings)
    for _, m in ipairs(mappings) do
        M.map(m[1], m[2], m[3], m[4])
    end
end

--- 删除快捷键
function M.unmap(mode, lhs)
    pcall(vim.keymap.del, mode, lhs)
end

return M
