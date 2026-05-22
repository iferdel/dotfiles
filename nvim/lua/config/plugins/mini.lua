-- lua/config/plugins/mini.lua
return {
  {
    'echasnovski/mini.icons',
    version = false,
    enabled = true,
    config = function()
      local MiniIcons = require("mini.icons")
      MiniIcons.setup({})
      -- Drop-in replacement so plugins that require('nvim-web-devicons') resolve here
      MiniIcons.mock_nvim_web_devicons()
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
