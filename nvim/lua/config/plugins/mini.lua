-- lua/config/plugins/mini.lua
return {
  {
    'echasnovski/mini.statusline',
    version = false,
    enabled = true,
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }
    end
  },
}
