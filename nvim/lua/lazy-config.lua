local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"                                                -- Path where lazy.nvim will be installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then                                                          -- Check if lazy.nvim is not installed
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"                                                 -- Lazy.nvim GitHub repo
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }) -- Clone repo
  if vim.v.shell_error ~= 0 then                                                                            -- If git clone failed
    vim.api.nvim_echo({                                                                                     -- Show error in Neovim
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar() -- Wait for user to press a key
    os.exit(1)     -- Exit Neovim
  end
end
vim.opt.rtp:prepend(lazypath) -- Add lazy.nvim to Neovim runtime path



require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Import your plugin list from lua/plugins/
  },

  ui = {
    backdrop = 100,            -- How dark the background is when Lazy UI is open (higher = darker)
    border = "rounded",        -- Rounded borders for the Lazy UI window
    browser = "chrome",        -- Browser used when opening links (plugin repos, docs, etc.)
    throttle = 40,             -- Refresh rate for the Lazy UI (ms)
    custom_keys = {
      ["<localleader>l"] = false, -- Disable <localleader>l inside Lazy UI
    },
  },

  change_detection = {
    enabled = true, -- Disable automatic reloading when Lua files change
    notify = false, -- Don’t show notifications when changes are detected
  },

  checker = {
    enabled = true, -- Periodically check for plugin updates in the background
  },

  performance = {
    rtp = {
      disabled_plugins = { -- Disable some built-in Vim plugins to speed up startup
      "gzip",
      "zip",
      "zipPlugin",
      "tar",
      "tarPlugin",

      "matchit",
      "matchparen",


      "tohtml",
      "tutor",
      "rplugin",        -- old remote plugin loader
      "spellfile_plugin", -- spell check support (disable if you don’t use `:set spell`)
      "man",            -- built-in man page viewer
      "shada_plugin",   -- session/history persistence (disable only if you don’t use it)

      "logiPat",
      "getscript",
      "getscriptPlugin",
      "vimball",
      "vimballPlugin",
      "rrhelper",       -- remote repl helper

      },
    },
  },
})

