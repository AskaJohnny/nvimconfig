local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.snippets = {
  lua = {
    s("ssn", {
      t("function "), i(1, "name"), t("("), i(2, "params"), t(")"),
      t({"", "\t"}), i(0),
      t({"", "end"})
    }),
  },
}

