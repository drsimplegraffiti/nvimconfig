return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    default = {
      use_absolute_path = false, ---@type boolean
      relative_to_current_file = true, ---@type boolean
      dir_path = vim.g.neovim_mode == "skitty" and "img" or function()
        return vim.fn.expand("%:t:r") .. "-img"
      end,
      prompt_for_file_name = false, ---@type boolean
      file_name = "%y%m%d-%H%M%S", ---@type string
      extension = "avif", ---@type string
      process_cmd = "convert - -quality 75 avif:-", ---@type string
    },
    filetypes = {
      markdown = {
        url_encode_path = true, ---@type boolean
        template = vim.g.neovim_mode == "skitty" and "![ ](./$FILE_PATH)" or "![Image](./$FILE_PATH)",
      },
    },
  },
}


-- install
-- sudo apt install imagemagick
-- sudo apt install libheif1
