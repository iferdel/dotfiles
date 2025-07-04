return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files since lazydev is intended to be used only for lua to configure lsp for lua with vim
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities() -- capabilities is a way to set communication between lsp and autocompletion from blink.cmp
      require("lspconfig").lua_ls.setup { capabilities = capabilities }
      if not require("lspconfig.configs").dockerls then
        require("lspconfig.configs").dockerls = {
          default_config = {
            cmd = { "docker-langserver", "--stdio" }, -- https://github.com/docker/docker-language-server
            filetypes = { "dockerfile" },
            root_dir = require("lspconfig").util.root_pattern("Dockerfile", ".git"),
            single_file_support = true,
          },
        }
      end
      require("lspconfig").gopls.setup {
        capabilities = capabilities,
      }
      require("lspconfig").pylsp.setup { capabilities = capabilities }
      require("lspconfig").ccls.setup {
        -- https://github.com/MaskRay/ccls/wiki/Project-Setup
        init_options = {
          compilationDatabaseDirectory = "build",
        },
        capabilities = capabilities
      }
      -- require("lspconfig").helm_ls.setup { capabilities = capabilities }
      -- require("lspconfig").postgres_lsp.setup { capabilities = capabilities }
      -- require("lspconfig").sqlls.setup { capabilities = capabilities }
      -- require("lspconfig").sqls.setup { capabilities = capabilities }
      -- require("lspconfig").terraform_lsp.setup { capabilities = capabilities }
      -- require("lspconfig").terraformls.setup { capabilities = capabilities }
      -- require("lspconfig").bashls.setup { capabilities = capabilities }
      -- require("lspconfig").dockerls.setup { capabilities = capabilities }
      -- require("lspconfig").yamlls.setup { capabilities = capabilities }

      vim.keymap.set("i", "<C-o>", vim.lsp.buf.signature_help)

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
              end,
            })
          end
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
        update_in_insert = false,

        float = {
          show_header = true,
          border = "rounded",
          source = "always",
        },
      })
    end,
  }
}
