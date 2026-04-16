-- lua/plugins/ai.lua - Claude AIコーディング統合

return {
  -- メインのClaude統合プラグイン
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
          slash_commands = {
            adapter = "anthropic",
          },
        },
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "ANTHROPIC_API_KEY",
              },
              schema = {
                model = {
                  default = "claude-3-5-sonnet-20241022",
                },
                max_tokens = {
                  default = 4096,
                },
              },
            })
          end,
        },
        display = {
          diff = {
            provider = "mini_diff",
          },
        },
      })

      -- キーマップ設定
      local keymap = vim.keymap.set
      
      -- チャット機能
      keymap("n", "<leader>ac", "<cmd>CodeCompanionChat<CR>", 
        { desc = "Claude Chat を開く" })
      keymap("v", "<leader>ac", "<cmd>CodeCompanionChat<CR>", 
        { desc = "選択範囲でClaude Chat" })
      
      -- インライン編集
      keymap("v", "<leader>ae", "<cmd>CodeCompanionInline<CR>", 
        { desc = "選択範囲をClaudeで編集" })
      
      -- アクションメニュー
      keymap({"n", "v"}, "<C-a>", "<cmd>CodeCompanionActions<CR>", 
        { desc = "Claude アクション一覧" })
      
      -- 選択範囲をチャットに追加
      keymap("v", "ga", "<cmd>CodeCompanionChat Add<CR>", 
        { desc = "選択範囲をチャットに追加" })
    end,
  },

  -- シンタックスハイライトと構文解析
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "markdown", "markdown_inline",
          "python", "javascript", "typescript", "bash", "json",
          "yaml", "html", "css", "rust", "go", "c", "cpp"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },

  -- UI改善プラグイン
  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  -- ファジーファインダー（オプション）
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-h>"] = "which_key"
            }
          }
        }
      })
    end,
  },
}
