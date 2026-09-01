local original_mini_pick =
  package.loaded["mini.pick"]

local calls = {
  files = 0,
  grep_live = 0,
}

package.loaded["mini.pick"] = {
  builtin = {
    files = function()
      calls.files = calls.files + 1
    end,

    grep_live = function()
      calls.grep_live =
        calls.grep_live + 1
    end,
  },
}

local MiniPickAdapter =
  require("nvi.adapters.mini_pick")

local ok, error_message = xpcall(function()
  MiniPickAdapter.find_files()
  MiniPickAdapter.search_text()

  assert(
    calls.files == 1,
    "find_files 应该调用一次 builtin.files"
  )

  assert(
    calls.grep_live == 1,
    "search_text 应该调用一次 builtin.grep_live"
  )
end, debug.traceback)

package.loaded["mini.pick"] =
  original_mini_pick

assert(ok, error_message)

print("mini_pick_adapter_test: OK")
