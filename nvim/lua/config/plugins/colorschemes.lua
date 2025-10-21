-- Additional colorschemes for theme switching
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
      flavour = "mocha", -- latte, frappe, macchiato, mocha
    },
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = true,
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      disable_background = true,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        transparent = true,
      },
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    -- Already configured in lazy.lua as default, but this ensures
    -- all variants (storm, night, day, moon) are available
  },
}
