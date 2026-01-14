
vim.opt.statusline = table.concat({
  '%#StatusLine#',
  ' %{mode()} ',        -- current mode (n, i, v, etc.)
  '%m',                 -- modified flag [+] if changed
  '%r',                 -- readonly flag [RO]
  '%=',
  'Ln %l, Col %c ',     -- line and column
})






