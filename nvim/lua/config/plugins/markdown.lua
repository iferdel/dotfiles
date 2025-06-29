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
    },
  },
}
