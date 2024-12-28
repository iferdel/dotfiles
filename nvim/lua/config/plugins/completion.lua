return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',

    opts = {
      keymap = { preset = 'default' }, -- keep on defaults <C-p> <C-n> for previous/next and <C-y> for accept

      -- Disable for some filetypes
      enabled = function()
        return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
            and vim.bo.buftype ~= "prompt"
            and vim.b.completion ~= false
      end,

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      signature = {
        enabled = true,
        window = {
          border = "single",
        },
      },

      completion = {
        menu = {
          enabled = true,
          max_height = 5,
          border = 'single',
          scrolloff = 1,
          scrollbar = true,

          -- Don't show completion menu automatically in cmdline mode
          auto_show = function(ctx)
            return ctx.mode ~= "cmdline" or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
          end,

          -- nvim-cmp style menu (edits the way recommendations are shown, in this case shows description if the option is a function, parameter, etc.)
          draw = {
            columns = {
              {
                "label",
                "label_description",
                gap = 1,
              },
              {
                "kind_icon",
                "kind"
              }
            },
          },
        },

        -- Show documentation when selecting a completion item (useful for usage of new libraries or new type of projects)
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 1000,
          update_delay_ms = 100,
          window = {
            min_width = 8,
            max_width = 50,
            max_height = 15,
            border = 'single',
          },
        },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = false },

        trigger = {
          show_on_keyword = true,
          show_on_trigger_character = true
        },

        list = {
          selection = 'preselect'
        },

      },
    },
  },
}
