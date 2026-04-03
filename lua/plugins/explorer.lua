return {
    {
      "echasnovski/mini.files",
      version = "*",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = {
        { "<leader>e", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "文件树(当前文件)" },
        { "<leader>E", function() require("mini.files").open(vim.uv.cwd(), true) end, desc = "文件树(根目录)" },
      },
      opts = {
        mappings = {
          go_in       = "l",
          go_in_plus  = "<CR>",
          go_out      = "h",
          go_out_plus = "H",
        },
        windows = {
          preview = true,
          width_focus = 30,
          width_nofocus = 20,
          width_preview = 45,
        },
        options = {
          use_as_default_explorer = true,
        },
        content = {
            prefix = function(fs_entry)
              if fs_entry.fs_type == "directory" then
                return " ", "Directory"
              end
              local ok, devicons = pcall(require, "nvim-web-devicons")
              if ok then
                local icon, hl = devicons.get_icon(fs_entry.name, nil, { default = true })
                if icon then
                  return icon .. " ", hl
                end
              end
              return require("mini.files").default_prefix(fs_entry)
            end,
          },
      },
      config = function(_, opts)
        require("mini.files").setup(opts)
  
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniFilesWindowOpen",
          callback = function(args)
            vim.api.nvim_win_set_config(args.data.win_id, { border = "rounded" })
          end,
        })
      end,
    },
  }