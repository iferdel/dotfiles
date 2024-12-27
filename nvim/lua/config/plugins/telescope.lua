return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } -- recommendation from source repo, it makes telescope search faster
    },
    config = function()
      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
    end
  }
}
