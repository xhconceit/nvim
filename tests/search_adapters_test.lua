local SearchPort = require("nvi.ports.search")

local adapters = {
  mini_pick = require("nvi.adapters.mini_pick"),
  native_picker = require("nvi.adapters.native_picker"),
}

for name, adapter in pairs(adapters) do
  local ok, error_message = pcall(SearchPort.validate, adapter)
  assert(ok, name .. " 不符合 SearchPort:\n" .. tostring(error_message))
end

print("search_adapters_test: OK")
