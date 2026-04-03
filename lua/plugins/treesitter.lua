return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- 想要本地安装 treesitter
      require("nvim-treesitter").setup({})

      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "query",
        "javascript", "typescript", "tsx",
        "html", "css", "json", "yaml", "toml",
        "markdown", "markdown_inline",
        "bash", "regex", "python", "go", "rust",
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- incremental selection（新版已移除该模块，用 treesitter API 手动实现）
      local inc_nodes = {}

      local function select_node(node)
        local sr, sc, er, ec = node:range()
        vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
        vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
        vim.cmd("normal! gv")
      end

      vim.keymap.set("n", "<CR>", function()
        local node = vim.treesitter.get_node()
        if not node then return end
        inc_nodes = { node }
        select_node(node)
      end, { desc = "Start incremental selection" })

      vim.keymap.set("x", "<CR>", function()
        local current = inc_nodes[#inc_nodes]
        if not current then return end
        local parent = current:parent()
        if not parent then return end
        table.insert(inc_nodes, parent)
        select_node(parent)
      end, { desc = "Expand selection to parent node" })

      vim.keymap.set("x", "<BS>", function()
        if #inc_nodes <= 1 then return end
        table.remove(inc_nodes)
        select_node(inc_nodes[#inc_nodes])
      end, { desc = "Shrink selection to child node" })

      vim.keymap.set("x", "<TAB>", function()
        local current = inc_nodes[#inc_nodes]
        if not current then return end
        local root = current
        while root:parent() do
          root = root:parent()
        end
        if root ~= current then
          table.insert(inc_nodes, root)
          select_node(root)
        end
      end, { desc = "Expand selection to scope" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local sel = require("nvim-treesitter-textobjects.select")
      local select_maps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
      }
      for key, query in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, key, function()
          sel.select_textobject(query, "textobjects")
        end)
      end

      local move = require("nvim-treesitter-textobjects.move")
      for _, m in ipairs({
        { "]f", "goto_next_start",     "@function.outer" },
        { "]c", "goto_next_start",     "@class.outer" },
        { "]a", "goto_next_start",     "@parameter.inner" },
        { "]F", "goto_next_end",       "@function.outer" },
        { "]C", "goto_next_end",       "@class.outer" },
        { "[f", "goto_previous_start", "@function.outer" },
        { "[c", "goto_previous_start", "@class.outer" },
        { "[a", "goto_previous_start", "@parameter.inner" },
        { "[F", "goto_previous_end",   "@function.outer" },
        { "[C", "goto_previous_end",   "@class.outer" },
      }) do
        vim.keymap.set({ "n", "x", "o" }, m[1], function()
          move[m[2]](m[3], "textobjects")
        end)
      end

      local swap = require("nvim-treesitter-textobjects.swap")
      vim.keymap.set("n", "<leader>sn", function()
        swap.swap_next("@parameter.inner")
      end, { desc = "Swap with next parameter" })
      vim.keymap.set("n", "<leader>sp", function()
        swap.swap_previous("@parameter.inner")
      end, { desc = "Swap with previous parameter" })
    end,
  },
}
