-- =============================================
--  SQL FILETYPE PLUGIN (ftplugin/sql.lua)
--  Modern Lua version of Vim’s SQL ftplugin
-- =============================================

-- Ensure we’re in SQL
if vim.bo.filetype ~= "sql" then
  return
end

-- Set indentation and folding
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.foldmethod = "syntax"

-- ---------------------------------------------
--  NAVIGATION AND MATCHING
-- ---------------------------------------------
-- Define matchit-like pairs for SQL keywords
vim.b.match_words = table.concat({
  [[if:\<\(elseif\|elsif\|else\)\>:\<end\s\+if\>]],
  [[\<while\s\+.*\s\+loop\>:\<end\s\+loop\>]],
  [[\<for\s\+.*\s\+loop\>:\<end\s\+loop\>]],
  [[\<do\>:\<doend\>]],
  [[\<case\>:\<end\s\+case\>]],
  [[\<merge\>:\<when\s\+matched\>:\<when\s\+not\s\+matched\>]],
  [[\<create\s\+\(or\s\+replace\s\+\)\?\(procedure\|function\|event\)\>:\<end\>]],
}, ",")

-- Movement shortcuts (like [[, ]], [{, ]})
vim.keymap.set("n", "]]", "/\\<begin\\><CR>", { buffer = true, silent = true })
vim.keymap.set("n", "[[", "?\\<begin\\><CR>", { buffer = true, silent = true })
vim.keymap.set("n", "][", "/\\<end\\><CR>", { buffer = true, silent = true })
vim.keymap.set("n", "[]", "?\\<end\\><CR>", { buffer = true, silent = true })

-- ---------------------------------------------
--  SQL DIALECT DETECTION
-- ---------------------------------------------
vim.g.sql_type_default = vim.g.sql_type_default or "mysql"

vim.api.nvim_create_user_command("SQLSetType", function(opts)
  local dialect = opts.args ~= "" and opts.args or vim.g.sql_type_default
  vim.b.sql_type = dialect
  vim.cmd("runtime! syntax/" .. dialect .. ".vim")
  vim.cmd("runtime! indent/sql.vim")
  print("SQL dialect set to:", dialect)
end, { nargs = "?" })

vim.api.nvim_create_user_command("SQLGetType", function()
  print("Current SQL dialect in use:", vim.b.sql_type or vim.g.sql_type_default)
end, {})

-- ---------------------------------------------
--  OMNI COMPLETION
-- ---------------------------------------------
-- Enable SQL omni completion if available
vim.opt_local.omnifunc = "sqlcomplete#Complete"

-- Default mappings (if not disabled)
if not vim.g.omni_sql_no_default_maps then
  local key = vim.g.ftplugin_sql_omni_key or "<C-c>"

  local maps = {
    a = "syntax",
    k = "sqlKeyword",
    f = "sqlFunction",
    o = "sqlOption",
    T = "sqlType",
    s = "sqlStatement",
    t = "Table",
    p = "Procedure",
    v = "View",
    c = "Column",
    l = "ColumnList",
    R = "ResetCache",
  }

  for k, v in pairs(maps) do
    vim.keymap.set("i", key .. k, string.format(
      [[<C-\><C-O>:call sqlcomplete#Map('%s')<CR><C-X><C-O>]],
      v
    ), { buffer = true, silent = true })
  end
end

-- ---------------------------------------------
--  COMMENTS
-- ---------------------------------------------
vim.bo.commentstring = "-- %s"
vim.bo.comments = "s1:/*,mb:*,ex:*/,://,:--"

-- ---------------------------------------------
--  HIGHLIGHTING AND OPTIONS
-- ---------------------------------------------
vim.opt_local.iskeyword:append("_")
vim.opt_local.smartindent = true

-- ---------------------------------------------
--  OPTIONAL DBEXT INTEGRATION
-- ---------------------------------------------
-- If dbext.vim or similar is available, enable dynamic completion
if vim.fn.exists("*dbext#DBListTable") == 1 then
  vim.b.sql_dynamic_completion = true
  vim.notify("SQL dynamic completion enabled (via dbext.vim)")
end

