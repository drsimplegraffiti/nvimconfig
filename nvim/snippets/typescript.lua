local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

return {
  -- Function
  s("fn", fmt("function {}({}) {{\n  {}\n}}", {
    i(1, "name"),
    i(2, "params"),
    i(3, "// body"),
  })),

  -- Arrow function
  s("afn", fmt("const {} = ({}) => {{\n  {}\n}};", {
    i(1, "name"),
    i(2, "params"),
    i(3, "// body"),
  })),

  -- Console log autosnippet
  autosnippet("clg", fmt("console.log({});", { i(1, "value") })),

  -- Import statement
  s("imp", fmt("import {{ {} }} from '{}';", { i(1, "something"), i(2, "module") })),
}
