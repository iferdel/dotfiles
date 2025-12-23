return {
  'akinsho/git-conflict.nvim',
  version = '*',
  config = function()
    -- Tokyonight-inspired conflict colors
    vim.api.nvim_set_hl(0, 'GitConflictCurrent', { bg = '#1a3a5c' })          -- Dark blue for ours
    vim.api.nvim_set_hl(0, 'GitConflictIncoming', { bg = '#3d2a3d' })         -- Dark purple for theirs
    vim.api.nvim_set_hl(0, 'GitConflictAncestor', { bg = '#2d3a2d' })         -- Dark green for ancestor
    vim.api.nvim_set_hl(0, 'GitConflictCurrentLabel', { bg = '#2a5a8c', fg = '#c0caf5', bold = true })
    vim.api.nvim_set_hl(0, 'GitConflictIncomingLabel', { bg = '#5a3a5a', fg = '#c0caf5', bold = true })
    vim.api.nvim_set_hl(0, 'GitConflictAncestorLabel', { bg = '#3a5a3a', fg = '#c0caf5', bold = true })

    require('git-conflict').setup({
      default_mappings = false,
    })
  end,
}
