return {
  {
    'meanderingprogrammer/render-markdown.nvim',
    enabled = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    ---@module 'render-markdown'
    ---@type render.md.userconfig
    opts = {
      latex = { enabled = false },
      completions = { blink = { enabled = true } },
      heading = {
        backgrounds = { 'RenderMarkdownH1Bg', 'RenderMarkdownH2Bg', 'RenderMarkdownH3Bg', 'RenderMarkdownH4Bg', 'RenderMarkdownH5Bg', 'RenderMarkdownH6Bg' },
        -- Increasing left padding to create staircase effect
        left_pad = { 0, 1, 3, 4, 5, 6 },
      },
      code = {
        enabled = true,
        style = 'full',           -- Shows language, background, and border
        width = 'block',          -- Limits to content width instead of full window
        min_width = 40,           -- Minimum width for code blocks
        left_pad = 2,
        right_pad = 2,
        border = 'thin',          -- Adds a thin border around the block
        highlight = 'RenderMarkdownCode',
      },
    },
    config = function(_, opts)
      -- Code block background (tokyonight-inspired darker shade)
      vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#1a1b26' }) -- Dark background from tokyonight

      -- Distinct background colors for each heading level (tokyonight-inspired)
      vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = '#394b70' }) -- Blue
      vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = '#3d4f3d' }) -- Green
      vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = '#4d3d50' }) -- Purple
      vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = '#4d4030' }) -- Yellow/Orange
      vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = '#3d4550' }) -- Cyan
      vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = '#453535' }) -- Red

      require('render-markdown').setup(opts)
    end,
  },
}
