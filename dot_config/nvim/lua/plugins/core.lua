-- Refer for examples here: https://www.lazyvim.org/configuration/examples

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "bash",
        "html",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "yaml",
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- YAML for configs
        "yaml-language-server",
        -- Web development
        "html-lsp",
        "css-lsp",
        "emmet-ls",
        -- Docker for your containerized services
        "docker-compose-language-service",
        "dockerfile-language-server",
      },
    },
  },

{
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fu",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "Find usages",
      },
      {
        "<leader>bi",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Pick buffer",
      },
    },
  },
}
