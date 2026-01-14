for _, p in ipairs({ "perl", "ruby", "node", "python" }) do
	vim.g["loaded_" .. p .. "_provider"] = 0
end

if vim.loader then vim.loader.enable() end


vim.opt.shadafile = "NONE"  -- disables shada (special keyword)

vim.g.mapleader = " "
vim.g.maplocalleader = ""

local opts = { noremap = true, silent = true }


vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\s'?'<1':1"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"
vim.opt.fillchars = { fold = "" }

vim.opt.path = { ".", "**" }
vim.opt.winborder = "rounded"

vim.opt.clipboard = "unnamedplus"
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autoread = true
vim.opt.lazyredraw = true
vim.opt.redrawtime = 100
vim.opt.updatetime = 200
vim.opt.timeoutlen = 250
vim.opt.modeline = false
vim.opt.modelines = 0
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.pumheight = 10
vim.o.cmdwinheight = 10
vim.opt.wildmenu = true
vim.opt.background = "dark"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "auto"
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

vim.opt.termguicolors = true
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])


vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.showbreak = "↪ "
vim.wo.cursorline = true

vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-cursor/lcursor,sm:block"

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true

vim.opt.completeopt = { "menuone", "noselect", "preview" }

vim.opt.wildmode = "list:longest,full"
vim.opt.sessionoptions:remove("options")
vim.opt.viewoptions:remove("curdir")

vim.opt.wildignore:append({
	"*/node_modules/*", "*/.git/*", "*/dist/*", "*/build/*",
	"*/target/*", "*/bin/*", "*/obj/*", "*/vendor/*",
	"*/.cache/*", "*/.venv/*", "*/venv/*", "*/__pycache__/*",
	"*/.next/*", "*/.hg/*", "*/.svn/*", "*/.idea/*",
	"*/.vscode/*", "*.o", "*.obj", "*.exe", "*.dll",
	"*.so", "*.a", "*.lib", "*.pyc", "*.class", "*.jar",
	"*.war", "*.wasm", "*.png", "*.jpg", "*.jpeg", "*.gif",
	"*.ico", "*.pdf", "*.mp4", "*.mov", "*.swp", "*.tmp",
	"*.bak", "*.log", "thumbs.db",
})

vim.api.nvim_set_hl(0, "linenr", { fg = "#ffa500" })
vim.api.nvim_set_hl(0, "cursorlinenr", { fg = "#ffa500", bold = true })


for _, k in ipairs({ "jk", "jj", "kj", "jk", "kj" }) do
	vim.keymap.set("i", k, "<esc>", opts)
end

for _, k in ipairs({ "jk", "<esc>" }) do
	vim.keymap.set("t", k, [[<c-\><c-n>]], opts)
end

vim.keymap.set("n", "j", "v:count == 0 ? 'gjzz' : 'jzz'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gkzz' : 'kzz'", { expr = true, silent = true })

vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "<c-d>", "<c-d>zz", opts)
vim.keymap.set("n", "<c-u>", "<c-u>zz", opts)

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set("x", "<leader>p", [["_dp]])
vim.keymap.set("v", "p", '"_dp', opts)


vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)


vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })


vim.api.nvim_set_keymap("i", "(", "()<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "[", "[]<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "{", "{}<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", '"', '""<Left>', { noremap = true })
vim.api.nvim_set_keymap("i", "'", "''<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "`", "``<Left>", { noremap = true })

vim.api.nvim_set_keymap("i", "{<CR>", "{<CR>}<Esc>O", { noremap = true })
vim.api.nvim_set_keymap(
	"i",
	")",
	[[pumvisible() ? ')' : (getline('.')[col('.')-1] == ')' ? '<Right>' : ')')]],
	{ expr = true, noremap = true }
)
vim.api.nvim_set_keymap(
	"i",
	"]",
	[[pumvisible() ? ']' : (getline('.')[col('.')-1] == ']' ? '<Right>' : ']')]],
	{ expr = true, noremap = true }
)
vim.api.nvim_set_keymap(
	"i",
	"}",
	[[pumvisible() ? '}' : (getline('.')[col('.')-1] == '}' ? '<Right>' : '}')]],
	{ expr = true, noremap = true }
)



vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", opts)
vim.keymap.set("n", "<leader>sh", "<cmd>split<cr>", opts)
vim.keymap.set("n", "<leader>sc", "<cmd>close<cr>", opts)
vim.keymap.set("n", "<c-h>", "<c-w>h", opts)
vim.keymap.set("n", "<c-l>", "<c-w>l", opts)
vim.keymap.set("n", "<c-j>", "<c-w>j", opts)
vim.keymap.set("n", "<c-k>", "<c-w>k", opts)

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", opts)
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", opts)
vim.keymap.set("n", "<leader>bd", "<cmd>bd!<cr>", opts)


vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format buffer" })
vim.keymap.set("n", "<leader>i", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
end, { desc = "toggle inlay hints" })


vim.api.nvim_create_autocmd("textyankpost", {
	group = vim.api.nvim_create_augroup("highlightyank", { clear = true }),
	callback = function() vim.hl.on_yank() end,
})

vim.keymap.set("n", "<leader>ds", [[:%g/^\s*$/d<CR>]], { desc = "Delete blank lines in current file" })


vim.keymap.set(
	"n",
	"<leader>dc",
	[[:%g/^\s*\(--\|\/\/\).*/d<cr>]],
	{ desc = "delete all comment lines in current file" }
)

vim.keymap.set("n", "<leader>da", [[:%s,/\*\_.\{-}\*/\n,,g]], { desc = "Delete all multi lines in current file" })

vim.keymap.set("n", "<C-n>", ":Lexplore<CR>", { noremap = true, silent = true, desc = "Open Netrw" })

vim.keymap.set("n", "<leader>a", function()
	require("img-clip").paste_image()
end, { desc = "Paste image from clipboard" })


vim.keymap.set("n", "<leader>qf", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { desc = "Send diagnostics to Quickfix and open it" })

vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close Quickfix list", silent = true })
vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open Quickfix list", silent = true })
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>zz", { desc = "Next Quickfix item", silent = true })
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<CR>zz", { desc = "Previous Quickfix item", silent = true })
vim.keymap.set("n", "<leader>ql", "<cmd>clist<CR>", { desc = "List all Quickfix entries", silent = true })
vim.keymap.set("n", "<leader>qq", "<cmd>cfirst<CR>", { desc = "Jump to first Quickfix item", silent = true })
vim.keymap.set("n", "<leader>qe", "<cmd>clast<CR>", { desc = "Jump to last Quickfix item", silent = true })

vim.api.nvim_create_user_command("Vgrep", function(cmd_args)
  local pattern = cmd_args.args
  if pattern == "" then
    print("Usage: :Vgrep <pattern>")
    return
  end

  local ok, _ = pcall(vim.cmd, "vimgrep /" .. pattern .. "/ **/*")
  if not ok then
    print("Vgrep: No matches found for '" .. pattern .. "'")
    return
  end

  vim.cmd("copen")
end, { nargs = 1, desc = "Vimgrep search for any pattern in all files recursively" })

vim.keymap.set("n", "gw", function()
  local word = vim.fn.expand("<cword>")
  vim.cmd("silent grep! " .. word)
  vim.cmd("copen")
end, { desc = "Grep word under cursor" })


vim.keymap.set("n", "<leader>vg", ":Vgrep ", { desc = "Vimgrep search", noremap = true })
-- vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { desc = "Auto complete" })
vim.keymap.set("n", "<C-e>", ":e **/", { noremap = true, silent = false })
--


-- Better window navigation
vim.keymap.set("n", "<C-h>", ":wincmd h<cr>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", ":wincmd l<cr>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", ":wincmd j<cr>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", ":wincmd k<cr>", { desc = "Move focus to the upper window" })


-- vim.api.nvim_create_autocmd({ "BufReadPost", "TextChanged", "TextChangedI" }, {
--   callback = function()
--     local seen = {}
--     local ns = vim.api.nvim_create_namespace("dup_lines")
--     vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
--
--     local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--     for i, line in ipairs(lines) do
--       if line ~= "" then
--         if seen[line] then
--           vim.api.nvim_buf_add_highlight(0, ns, "ErrorMsg", i - 1, 0, -1)
--         else
--           seen[line] = true
--         end
--       end
--     end
--   end,
-- })
--
