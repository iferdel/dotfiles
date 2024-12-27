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
      vim.keymap.set("n", "<space>en",                       -- en: edit neovim config 'dotfiles'
        function()                                           -- scope it into a function to add more customization
          local opts = require('telescope.themes').get_ivy({ -- define a local variable cwd wrapped with a telescope theme
            cwd = vim.fn.stdpath("config")
          })
          require('telescope.builtin').find_files(opts)
        end)
    end
  }
}
