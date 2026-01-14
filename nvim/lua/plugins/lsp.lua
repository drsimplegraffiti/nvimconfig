return { -- Mason: Install and manage LSP servers
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"gopls",
					"clangd",
					"jdtls",
					"pyright",
					"bashls",
					"solidity_ls_nomicfoundation",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local function organize_and_clean_imports()
				local buf = 0
				local filename = vim.api.nvim_buf_get_name(buf)

				pcall(vim.lsp.buf_request(0, "workspace/executeCommand", {
					command = "_typescript.organizeImports",
					arguments = { filename },
				}, function(err, _, _)
					if err then
						vim.notify("OrganizeImports failed: " .. err.message, vim.log.levels.WARN)
					end
				end))

				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.removeUnusedImports" },
						diagnostics = {},
					},
				})
			end

			local on_attach = function(client, bufnr)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show Hover", buffer = bufnr })
				vim.keymap.set("i", "<C-z>", function()
					vim.lsp.buf.signature_help()
				end, { desc = "Signature Help", buffer = bufnr })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", buffer = bufnr })
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Type Definition", buffer = bufnr })
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation", buffer = bufnr })
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "List References", buffer = bufnr })
				vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, { desc = "Rename Symbol", buffer = bufnr })
				vim.keymap.set(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ desc = "Code Action", buffer = bufnr }
				)

				vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Error", buffer = bufnr })
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic", buffer = bufnr })
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic", buffer = bufnr })

				vim.api.nvim_create_autocmd("TextChangedI", {
					buffer = bufnr,
					callback = function()
						local col = vim.fn.col(".") - 1
						local line = vim.fn.getline(".")
						local char = line:sub(col, col)
						if char == "(" or char == "," then
							vim.lsp.buf.signature_help()
						end
					end,
				})

				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
				end
			end

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "always" },
			})

			vim.lsp.config("bashls", { capabilities = capabilities, on_attach = on_attach })
			vim.lsp.enable("bashls")

			vim.lsp.config("pyright", {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "python" },
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoImportCompletions = true,
							diagnosticMode = "workspace",
						},
					},
				},
			})
			vim.lsp.enable("pyright")

			vim.lsp.config("jdtls", {
				capabilities = capabilities,
				on_attach = on_attach,
				cmd = { "jdtls" },
				filetypes = { "java" },
				root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
				settings = { java = { format = { enabled = true } } },
			})
			vim.lsp.enable("jdtls")

			vim.lsp.config("clangd", {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
			})
			vim.lsp.enable("clangd")

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
					},
				},
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)

					vim.api.nvim_create_user_command("OrganizeImports", function()
						organize_and_clean_imports()
					end, {})

					vim.keymap.set(
						"n",
						"<leader>oi",
						organize_and_clean_imports,
						{ buffer = bufnr, desc = "Organize Imports" }
					)
				end,

				commands = {
					OrganizeImports = {
						organize_and_clean_imports,
						description = "Organize Imports via tsserver",
					},
				},

				root_dir = vim.fs.root(0, { "tsconfig.json", "package.json", ".git" }),
				single_file_support = false,

				settings = {
					typescript = {
						tsserver = { maxTsServerMemory = 4096 },
						preferences = { importModuleSpecifier = "non-relative" },
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						suggest = { completeFunctionCalls = true },
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},

				init_options = {
					preferences = { disableSuggestions = true },
				},
			})

			vim.lsp.enable("ts_ls")

			vim.lsp.config("gopls", {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
				settings = {
					gopls = {
						staticcheck = true,
						gofumpt = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			})
			vim.lsp.enable("gopls")

			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						check = { command = "clippy" },
					},
				},
			})
			vim.lsp.enable("rust_analyzer")

			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, { focusable = false })
				end,
			})

			vim.keymap.set("n", "<leader>rs", function()
				for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
					client.stop()
				end
				vim.cmd("edit")
			end, { desc = "Restart LSP for current buffer" })
		end,
	},
}


