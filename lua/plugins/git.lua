local keymap = require("core.keymap")

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc) keymap.map(mode, l, r, { buffer = bufnr, desc = desc }) end

        -- 导航
        map("n", "]h", gs.next_hunk, "下一个 hunk")
        map("n", "[h", gs.prev_hunk, "上一个 hunk")

        -- 操作
        map("n", "<leader>gs", gs.stage_hunk, "暂存 hunk")
        map("n", "<leader>gr", gs.reset_hunk, "还原 hunk")
        map("n", "<leader>gS", gs.stage_buffer, "暂存整个文件")
        map("n", "<leader>gR", gs.reset_buffer, "还原整个文件")
        map("n", "<leader>gu", gs.undo_stage_hunk, "撤销暂存 hunk")
        map("n", "<leader>gp", gs.preview_hunk, "预览 hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "blame 当前行")
        map("n", "<leader>gd", gs.diffthis, "diff 当前文件")
        map("n", "<leader>gt", gs.toggle_deleted, "显示/隐藏已删除行")

        -- 可视模式暂存/还原
        map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "暂存选中")
        map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "还原选中")
      end,
    },
  },
}

