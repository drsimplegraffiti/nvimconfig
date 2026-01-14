return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true, -- Close Neo-tree if it's the last window
			popup_border_style = "rounded",
			enable_git_status =true, -- disable git decorations
			enable_diagnostics = false, -- disable LSP diagnostics
			default_component_configs = {
				indent = {
					with_markers = false, -- no indent markers
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "",
				},
				git_status = {
                    symbols = {
						added     = "✚",  -- new file
						modified  = "",  -- modified file
						deleted   = "✖",  -- deleted file
						renamed   = "➜",  -- renamed file
						untracked = "★",  -- untracked file
						ignored   = "◌",  -- ignored file
						unstaged  = "✗",  -- unstaged changes
						staged    = "✔",  -- staged changes
						conflict  = "",  -- merge conflict
					},
				},
			},
			window = {
				width = 25,
				position = "left",
				mappings = {}, -- no extra key mappings for less clutter
			},
			filesystem = {
				filtered_items = {
					visible = true, -- always show all files
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = { ".git", "node_modules" }, -- still hide noisy folders
				},
				follow_current_file = {
					enabled = true, -- auto-focus current file
				},
				use_libuv_file_watcher = true, -- auto refresh on file changes
			},
		})

		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
	end,
}


