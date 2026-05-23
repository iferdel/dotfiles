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
  {
    'echasnovski/mini.indentscope',
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local indentscope = require("mini.indentscope")
      indentscope.setup({
        symbol = "│",
        draw = {
          animation = indentscope.gen_animation.none(), -- no animation: calmer look
        },
        options = {
          try_as_border = true,
        },
      })

      -- Disable in special buffers where an indent line is just noise
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help", "oil", "dbee", "lazy", "mason",
          "TelescopePrompt", "noice", "notify",
          "checkhealth", "qf",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      vim.api.nvim_create_autocmd("TermOpen", {
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
