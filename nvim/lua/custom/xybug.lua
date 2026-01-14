local M = {}

local function hex_to_rgb(hex)
	local r = tonumber(hex:sub(2, 3), 16) / 255
	local g = tonumber(hex:sub(4, 5), 16) / 255
	local b = tonumber(hex:sub(6, 7), 16) / 255
	return r, g, b
end

local function rgb_to_hex(r, g, b)
	return string.format(
		"#%02x%02x%02x",
		math.floor(math.min(1, r) * 255),
		math.floor(math.min(1, g) * 255),
		math.floor(math.min(1, b) * 255)
	)
end

local function apply_gamma(hex, gamma)
	local r, g, b = hex_to_rgb(hex)
	return rgb_to_hex(
		math.pow(r, 1 / gamma),
		math.pow(g, 1 / gamma),
		math.pow(b, 1 / gamma)
	)
end

local function brighten(hex, gamma, mix)
	local r, g, b = hex_to_rgb(hex)

	r = math.pow(r, 1 / gamma)
	g = math.pow(g, 1 / gamma)
	b = math.pow(b, 1 / gamma)

	r = r + (1 - r) * mix
	g = g + (1 - g) * mix
	b = b + (1 - b) * mix

	return rgb_to_hex(r, g, b)
end

local colors = {
	bg = "#001427",
	fg = "#eae2b7",
	gray = "#585B70",

	red = "#F38BA8",
	green = "#A6E3A1",
	yellow = "#F9E2AF",
	blue = "#89B4FA",
	magenta = "#CBA6F7",
	cyan = "#00afb9",
	orange = "#FF7F11",

	bright_white = "#e9ecef",
}

function M.colorscheme()
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")

	vim.o.background = "dark"
	vim.g.colors_name = "xybug"

	local set = vim.api.nvim_set_hl

	local soft   = function(hex) return apply_gamma(hex, 0.8) end
	local bright = function(hex) return brighten(hex, 0.65, 0.15) end
	local neon   = function(hex) return brighten(hex, 0.55, 0.30) end

	set(0, "Normal",       { bg = colors.bg, fg = soft(colors.fg) })
	set(0, "NormalNC",     { bg = colors.bg, fg = soft(colors.fg) })
	set(0, "NormalFloat",  { bg = colors.bg, fg = soft(colors.fg) })
	set(0, "CursorLine",   { bg = "#071c2f" })
	set(0, "Visual",       { bg = "#103a52", bold = true })

	set(0, "CursorLineNr", { fg = neon(colors.orange), bold = true })
	set(0, "LineNr",       { fg = soft(colors.gray) })
	set(0, "VertSplit",    { fg = colors.gray })
	set(0, "StatusLine",   { bg = colors.bg, fg = colors.bright_white })

	set(0, "Comment",    { fg = brighten("#A6A6A6", 0.7, 0.2), italic = true })
	set(0, "String",     { fg = bright(colors.green) })
	set(0, "Constant",   { fg = bright(colors.orange) })
	set(0, "Number",     { fg = bright(colors.orange) })
	set(0, "Function",   { fg = neon(colors.blue) })
	set(0, "Keyword",    { fg = neon(colors.magenta), bold = true })
	set(0, "Identifier", { fg = bright(colors.yellow) })
	set(0, "Type",       { fg = bright(colors.cyan) })
	set(0, "Boolean",    { fg = neon(colors.red), bold = true })
	set(0, "Operator",   { fg = soft(colors.fg) })
	set(0, "PreProc",    { fg = neon(colors.magenta) })

	set(0, "DiagnosticError", { fg = neon(colors.red), bold = true })
	set(0, "DiagnosticWarn",  { fg = neon(colors.yellow), bold = true })
	set(0, "DiagnosticInfo",  { fg = bright(colors.blue) })
	set(0, "DiagnosticHint",  { fg = bright(colors.cyan) })

	set(0, "DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
	set(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = colors.yellow })
	set(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = colors.blue })
	set(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = colors.cyan })

	set(0, "LspReferenceText",  { bg = "#12324a", fg = neon(colors.orange), bold = true })
	set(0, "LspReferenceRead",  { bg = "#12324a", fg = bright(colors.green), bold = true })
	set(0, "LspReferenceWrite", { bg = "#12324a", fg = neon(colors.red), bold = true })

	set(0, "LspSignatureActiveParameter", { fg = neon(colors.magenta), bold = true })
	set(0, "LspInlayHint", { fg = soft(colors.gray), italic = true })
end

return M

