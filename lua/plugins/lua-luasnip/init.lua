local M = {}
function M.setup()
  local ls = require 'luasnip'
  local s = ls.snippet
  local t = ls.text_node
  local i = ls.insert_node

  ls.add_snippets("lua", {
    s("table-class", {
      t({
        "local M = {}",
        ""
      }),
      t({
        "function M.",
      }),
      i(1, "whatever"),
      t({
        "()",
        "end",
        ""
      }),
      t({
        "return M"
      }),
    })
  })
end

return M


