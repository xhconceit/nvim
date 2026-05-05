require("image").setup({
  backend = "kitty",
  processor = "magick_cli",
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      filetypes = { "markdown", "vimwiki" },
    },
  },
  max_width = 100,
  max_height = 40,
  max_height_window_percentage = 50,
  hijack_file_patterns = {},
})

local img_exts = { "jpg", "jpeg", "png", "gif", "webp", "bmp", "avif" }
local img_pattern = vim.tbl_map(function(ext) return "*." .. ext end, img_exts)

local function render_image_in_buf(image_path, target_buf)
  local cur_win = vim.api.nvim_get_current_win()
  local ok, image_api = pcall(require, "image")
  if not ok or not vim.api.nvim_buf_is_valid(target_buf) then return end

  vim.bo[target_buf].modifiable = true
  local height = vim.api.nvim_win_get_height(cur_win)
  local blank = {}
  for i = 1, height do
    blank[i] = ""
  end
  vim.api.nvim_buf_set_lines(target_buf, 0, -1, false, blank)
  vim.bo[target_buf].modifiable = false

  local img = image_api.from_file(image_path, {
    buffer = target_buf,
    window = cur_win,
    with_virtual_padding = true,
    x = 0,
    y = 0,
  })
  img:render()
end

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = img_pattern,
  callback = function(ev)
    local buf = ev.buf
    local path = vim.api.nvim_buf_get_name(buf)
    local win = vim.api.nvim_get_current_win()

    vim.bo[buf].modifiable = true
    local win_height = vim.api.nvim_win_get_height(win)
    local lines = { "Loading..." }
    for i = 2, win_height do
      lines[i] = ""
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].buftype = "nofile"

    local cache_dir = vim.fn.stdpath("cache") .. "/image_preview"
    vim.fn.mkdir(cache_dir, "p")
    local hash = vim.fn.sha256(path):sub(1, 16)
    local out_path = cache_dir .. "/" .. hash .. ".png"

    vim.system(
      { "magick", path, "-scale", "1920x1080>", out_path },
      {},
      vim.schedule_wrap(function(result)
        if result.code ~= 0 then
          vim.notify("图片转换失败", vim.log.levels.ERROR)
          return
        end
        if not vim.api.nvim_buf_is_valid(buf) then return end

        render_image_in_buf(out_path, buf)

        vim.api.nvim_create_autocmd("BufWinEnter", {
          buffer = buf,
          callback = function()
            vim.schedule(function() render_image_in_buf(out_path, buf) end)
          end,
        })
      end)
    )
  end,
})
