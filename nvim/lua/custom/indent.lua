local M = {}

local indent_char = "│" -- VSCode-like thin bar

vim.api.nvim_set_hl(0, "CustomIndent", { fg = "#303030", nocombine = true })

local function add_indent_guides(bufnr)
	vim.api.nvim_buf_clear_namespace(bufnr, M.ns, 0, -1)

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	for lnum, line in ipairs(lines) do
		local indent = line:match("^%s+")
		if indent then
			local count = math.floor(#indent / vim.bo.shiftwidth)
			for i = 1, count do
				vim.api.nvim_buf_set_extmark(bufnr, M.ns, lnum - 1, (i - 1) * vim.bo.shiftwidth, {
					virt_text = { { indent_char, "CustomIndent" } },
					virt_text_pos = "overlay",
					hl_mode = "blend", -- blend into background (fainter)
				})
			end
		end
	end
end

function M.setup()
	M.ns = vim.api.nvim_create_namespace("custom_indent")

	vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
		callback = function(args)
			add_indent_guides(args.buf)
		end,
	})
end

return M
