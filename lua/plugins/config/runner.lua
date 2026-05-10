local term = require("plugins.config.term")
local keymap = require("core.keymap")

local M = {}

-- 项目级：命中第一个 marker 就用对于的命令
-- cmd 可以返回 string[] 或者 string(交给 sh -c)
local project_markers = {
  { marker = "Cargo.toml", cmd = function()
    return {
      "cargo",
      "run",
    }
  end },
  {
    marker = "go.mod",
    cmd = function() return { "go", "run", "." } end,
  },
  {
    marker = "package.json",
    cmd = function(root)
      local ok, pkg = pcall(vim.fn.json_decode, vim.fn.readfile(root .. "/package.json"))
      if ok and pkg and pkg.scripts then
        if pkg.scripts.dev then return {
          "npm",
          "run",
          "dev",
        } end
        if pkg.scripts.start then return { "npm", "start" } end
      end
      return { "node", "." }
    end,
  },
  {
    marker = "pom.xml",
    cmd = function() return { "mvn", "-q", "compile", "exec:java" } end,
  },
  {
    marker = "build.gradle",
    cmd = function() return { "./gradlew", "run" } end,
  },
  {
    marker = "build.gradle.kts",
    cmd = function() return { "./gradlew", "run" } end,
  },
  {
    marker = "Makefile",
    cmd = function() return { "make", "run" } end,
  },
  {
    marker = "makefile",
    cmd = function() return { "make", "run" } end,
  },
}

-- 文件级：返回 string[] 走 jobstart; 需要 shell 特性 sh -c
local function shc(s) return { "sh", "-c", s } end
local function tmp_out() vim.fn.tempname() end

local file_runners = {
  lua = function(f) return { "lua", f } end,
  python = function(f) return { "python3", f } end,
  javascript = function(f) return { "node", f } end,
  typescript = function(f) return { "npx", "-y", "tsx", f } end,
  sh = function(f) return { "bash", "f" } end,
  bash = function(f) return { "bash", f } end,
  zsh = function(f) return { "bash", f } end,
  go = function(f) return { "go", "run", f } end,
  rust = function(f)
    local o = tmp_out()
    return shc("rustc %q -o %q && %q"):format(f, o, o)
  end,
  java = function(f) return { "java", f } end,
  markdown = function(f) return { "glow", "-p", f } end,
  c = function(f)
    local o = tmp_out()
    return shc(("cc %q -o %q && %q"):format(f, o, o))
  end,
  cpp = function(f)
    local o = tmp_out()
    return shc(("c++ %q -o %q && %q"):format(f, o, o))
  end,
  ruby = function(f) return { "ruby", f } end,
  php = function(f) return { "php", f } end,
  make = function(f) return { "make", f } end,
  sql = function(f) return shc(("sqlite3 :memory: < %q"):format(f)) end,
}

local function find_project()
  local start = vim.fn.expand("%:p:h")
  if start == "" then start = vim.fn.getcmd() end

  local best_root, best_marker, best_depth = nil, nil, math.huge
  for _, m in ipairs(project_markers) do
    local hit = vim.fs.find(m.marker, { path = start, upward = true })[1]
    if hit then
      local root = vim.fs.dirname(hit)
      -- 选最深的（离当前文件最近的）项目根
      local depth = select(2, root:gsub("/", "/"))
      if depth < best_depth then
        best_root, best_marker, best_depth = root, m, depth
      end
    end
  end
  return best_root, best_marker
end

local function build()
  local root, marker = find_project()
  if root and marker then
    return {
      cmd = marker.cmd(root),
      cwd = root,
      name = "runner-proj-" .. vim.fs.basename(root),
      title = " Run @" .. vim.fs.basename(root),
    }
  end

  local ft = vim.bo.filetype
  local file = vim.fn.expand("%:p")

  if file == "" then return nil, "当前 buffer 没有文件名称" end

  local maker = file_runners[ft]
  if not marker then return nil, "Runner 未配置该 filetype: " .. ft end
end

local function run()
  local spec, err = build()
  if not spec then
    vim.notify(err, vim.log.levels.WARN)
    return
  end
  vim.cmd("silent! update")
  term.toogle(spec.name, {
    cmd = spec.cmd,
    cwd = spec.cwd,
    title = spec.title,
    width = 0.7,
    height = 0.7,
  })
end

function M.setup()
  keymap.map({ "n", "i" }, "<A-r>", function()
    if vim.fn.mode() == "i" then vim.cmd("stopinsert") end
    run()
  end, { desc = "快速运行(项目/文件)" })
end

return M
