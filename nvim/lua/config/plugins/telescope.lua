return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } -- recommendation from source repo, it makes telescope search faster
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_config = {
            preview_width = 0.6, -- portion of width devoted to preview
          },
        },
        pickers = {
          find_files = {
            theme = "ivy" -- overrides default theme
          },
        },
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')

      vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags, { desc = "Find help tags" })
      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files, { desc = "Find files" })
      vim.keymap.set("n", "<space>en",                                          -- en: edit neovim config 'dotfiles'
        function()                                                              -- scope it into a function to add more customization
          local opts = require('telescope.themes').get_ivy({                    -- define a local variable cwd wrapped with a telescope theme
            cwd = vim.fn.stdpath("config"),
            hidden = true,
          })
          require('telescope.builtin').find_files(opts)
        end, { desc = "Browse neovim config files" })
      vim.keymap.set("n", "<space>ep",                       -- ep: edit packages
        function()
          local opts = require('telescope.themes').get_ivy({ -- define a local variable cwd wrapped with a telescope theme
            cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
          })
          require('telescope.builtin').find_files(opts)
        end, { desc = "Browse plugin source files" })

      require('config.telescope.multigrep').setup()
    end
  }
}
