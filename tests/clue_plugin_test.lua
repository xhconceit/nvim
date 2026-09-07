local specs = dofile("lua/nvi/infrastructure/plugins/clue.lua")
local plugin = specs[1]

assert(plugin[1] == "nvim-mini/mini.clue")
assert(plugin.version == false)
assert(plugin.event == "VeryLazy")
assert(type(plugin.opts) == "function")

local original_require = require

require = function(name)
  if name == "mini.clue" then
    return {
      gen_clues = {
        builtin_completion = function()
          return { name = "completion" }
        end,
        g = function()
          return { name = "g" }
        end,
        marks = function()
          return { name = "marks" }
        end,
        registers = function()
          return { name = "registers" }
        end,
        windows = function()
          return { name = "windows" }
        end,
        z = function()
          return { name = "z" }
        end,
      },
    }
  end

  return original_require(name)
end

local ok, opts = pcall(plugin.opts)
require = original_require

assert(ok, opts)
assert(type(opts.triggers) == "table")
assert(type(opts.clues) == "table")
assert(opts.window.delay == 300)
assert(opts.window.config.border == "rounded")

print("clue_plugin_test: OK")
