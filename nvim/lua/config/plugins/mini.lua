-- lua/config/plugins/mini.lua
return {
  {
    'echasnovski/mini.statusline',
    version = false,
    enabled = true,
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup {
        use_icons = true,
      }
    end
  },
  {
    'echasnovski/mini.icons',
    version = false,
    enabled = true,
    config = function()
      require("mini.icons").setup({

      })
    end,
  },
  {
    'echasnovski/mini-git',
    version = false,
    main = "mini.git",
    enabled = true,
    config = function()
      require("mini.git").setup({

      })
    end,
  },
}
