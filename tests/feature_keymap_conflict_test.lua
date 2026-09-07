local keymap_module = "nvi.ui.keymap"
local modules = {
  "nvi.core.keymaps",
  "nvi.features.search",
  "nvi.features.buffer",
  "nvi.features.terminal",
  "nvi.features.window",
  "nvi.features.tab",
  "nvi.features.session",
  "nvi.features.file_explorer",
  "nvi.features.git",
  "nvi.features.formatting",
  "nvi.features.quickfix",
}

local original_keymap = package.loaded[keymap_module]
local registered = {}

local function register(mode, lhs, _, description)
  local modes = type(mode) == "table" and mode or { mode }

  for _, current_mode in ipairs(modes) do
    local key = current_mode .. "\0" .. lhs

    assert(
      registered[key] == nil,
      string.format(
        "快捷键 %s 在模式 %s 冲突：%s / %s",
        lhs,
        current_mode,
        registered[key] or "",
        description
      )
    )
    registered[key] = description
  end
end

local fake_keymap = {
  set = register,
  del = function() end,
}

for name, mode in pairs({
  nmap = "n",
  vmap = "v",
  cmap = "c",
  imap = "i",
  tmap = "t",
}) do
  fake_keymap[name] = function(lhs, rhs, description)
    register(mode, lhs, rhs, description)
  end
end

package.loaded[keymap_module] = fake_keymap
for _, module_name in ipairs(modules) do
  package.loaded[module_name] = nil
end

local adapter = setmetatable({}, {
  __index = function()
    return function() end
  end,
})

local ok, error_message = xpcall(function()
  require("nvi.core.keymaps").setup()

  for _, module_name in ipairs(modules) do
    if module_name ~= "nvi.core.keymaps" then
      require(module_name).setup(adapter)
    end
  end
end, debug.traceback)

package.loaded[keymap_module] = original_keymap
for _, module_name in ipairs(modules) do
  package.loaded[module_name] = nil
end

assert(ok, error_message)

print("feature_keymap_conflict_test: OK")
