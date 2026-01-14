local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

return {
  -- Normal snippet (manual trigger)
  s("fn", {
    t("function "), i(1, "name"), t("()"),
    t({ "", "  " }), i(2, "-- body"),
    t({ "", "end" }),
  }),


  -- Autosnippet example: expand immediately
  -- autosnippet("todo", fmt("// TODO: {}", { i(1, "write something...") })),

  -- Another autosnippet example
  -- autosnippet("sig", fmt("Best regards,\n{}", { i(1, "Your Name") })),
}
