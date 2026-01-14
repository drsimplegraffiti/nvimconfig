return {
  {
    "folke/snacks.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    priority = 1000,
    lazy = false,
    			styles = { snacks_image = { relative = "editor", col = -1 } },
			image = {
				enabled = true,
				doc = {
					inline = vim.g.neovim_mode == "skitty",
					float = true,
					max_width = vim.g.neovim_mode == "skitty" and 5 or 60,
					max_height = vim.g.neovim_mode == "skitty" and 2.5 or 30,
				},
			},

    keys = {
      { "<leader>e", false },

      {
        "<leader>fg",
        function()
          require("snacks").picker.grep({
            exclude = { "node_modules/**", "dist/**", "dictionaries/words.txt" },
          })
        end,
        desc = "grep",
      },

      {
        "<leader>n",
        function()
          require("snacks").picker.notifications()
        end,
        desc = "notification history",
      },

      {
        "<leader>ff",
        function()
          require("snacks").picker.files({ hidden = true, ignored = false })
        end,
        desc = "find files",
      },

      {
        "<leader>u",
        function()
          require("snacks").explorer()
        end,
        desc = "file explorer",
      },

      {
        "<c-/>",
        function()
          require("snacks").terminal()
        end,
        desc = "toggle terminal",
      },

      {
        "<leader>fr",
        function()
          require("snacks").picker.recent()
        end,
        desc = "recent",
      },

      {
        "<leader>sh",
        function()
          require("snacks").picker.highlights()
        end,
        desc = "highlights",
      },

      {
        "<leader>gl",
        function()
          require("snacks").picker.git_log({
            finder = "git_log",
            format = "git_log",
            preview = "git_show",
            confirm = "git_checkout",
            layout = "vertical",
            exclude = { "node_modules/**", "dist/**" },
          })
        end,
        desc = "git log",
      },

      {
        "<leader>fc",
        function()
          require("snacks").picker.grep({
            prompt = " ",
            search = "^\\s*- \\[ \\]",
            regex = true,
            live = false,
            dirs = { vim.fn.getcwd() },
            args = { "--no-ignore" },
            exclude = { "node_modules/**", "dist/**" },
            on_show = function()
              vim.cmd.stopinsert()
            end,
            finder = "grep",
            format = "file",
            show_empty = true,
            supports_live = false,
            layout = "ivy",
          })
        end,
        desc = "search for incomplete tasks",
      },

      {
        '<leader>s"',
        function()
          require("snacks").picker.registers()
        end,
        desc = "registers",
      },

      {
        "<leader>s/",
        function()
          require("snacks").picker.search_history()
        end,
        desc = "search history",
      },

      {
        "<leader>sa",
        function()
          require("snacks").picker.autocmds()
        end,
        desc = "autocmds",
      },

      {
        "<leader>sb",
        function()
          require("snacks").picker.lines()
        end,
        desc = "buffer lines",
      },

      {
        "<leader>sc",
        function()
          require("snacks").picker.commands()
        end,
        desc = "commands",
      },

      {
        "<leader>sd",
        function()
          require("snacks").picker.diagnostics_buffer()
        end,
        desc = "buffer diagnostics",
      },

      {
        "<leader>si",
        function()
          require("snacks").picker.icons()
        end,
        desc = "icons",
      },

      {
        "<leader>sj",
        function()
          require("snacks").picker.jumps()
        end,
        desc = "jumps",
      },

      {
        "<leader>sk",
        function()
          require("snacks").picker.keymaps()
        end,
        desc = "keymaps",
      },

      {
        "<leader>sl",
        function()
          require("snacks").picker.loclist()
        end,
        desc = "location list",
      },

      {
        "<leader>sm",
        function()
          require("snacks").picker.marks()
        end,
        desc = "marks",
      },

      {
        "<leader>sp",
        function()
          require("snacks").picker.lazy()
        end,
        desc = "search for plugin spec",
      },

      {
        "<leader>sq",
        function()
          require("snacks").picker.qflist()
        end,
        desc = "quickfix list",
      },

      {
        "<leader>sr",
        function()
          require("snacks").picker.resume()
        end,
        desc = "resume",
      },

      {
        "<leader>su",
        function()
          require("snacks").picker.undo()
        end,
        desc = "undo history",
      },

      {
        "<leader>ss",
        function()
          require("snacks").picker.lsp_workspace_symbols()
        end,
        desc = "lsp workspace symbols",
      },

      {
        "<c-p>",
        function()
          require("snacks").picker.files({
            finder = "files",
            format = "file",
            ignored = true,
            show_empty = true,
            supports_live = true,
            hidden = true,
            no_ignore = true,
            exclude = { "node_modules/**", "dist/**" },
             preview = false,
          })
        end,
        desc = "find files",
      },
    },

    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      terminal = { enabled = true },
      win = { enabled = true },
      words = { enabled = true },
      dim = { enabled = true },
      statuscolumn = { enabled = true },
      toggle = { enabled = true, which_key = true },
      dashboard = { enabled = false },

        -- 🔹 FIX: avoid Treesitter yield error
      redraw = {
        safe_for_treesitter = true, -- ensure redraw does not yield across C-call boundary
      },

    },
  },
}

