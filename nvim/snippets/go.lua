local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

return {
	-- Function
	s(
		"fn",
		fmt("func {}({}) {} {{\n\t{}\n}}", {
			i(1, "name"),
			i(2, "params"),
			i(3, "returnType"),
			i(4, "// body"),
		})
	),

	-- Main function
	s("main", t({ "func main() {", "\t", "}" })),

	-- Print autosnippet
	autosnippet("pf", fmt('fmt.Printf("{}\\n", {})', { i(1, "message"), i(2, "vars") })),

	-- Error handling
	autosnippet(
		"iferr",
		fmt(
			[[
        if err != nil {{
            {}
        }}
        ]],
			{
				i(1, "return err"),
			}
		)
	),

	-- Struct
	s("struct", fmt("type {} struct {{\n\t{}\n}}", { i(1, "Name"), i(2, "Fields") })),
}
