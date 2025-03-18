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
        "go",
        "java",
        "python",
        "javascript",
        "lua",
        "bash",
        "html",
        "json",
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
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
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

  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      -- require("dap.ext.vscode").load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.adapters.delve = {
        type = "server",
        port = 2345,
      }
      dap.configurations.go = {
        {
          type = "delve",
          request = "attach",
          name = "Attach to Go",
          mode = "remote",
          substitutePath = {
            {
              from = "${env:GOPATH}/src",
              to = "src",
            },
            {
              from = "${env:GOPATH}/bazel-go-code/external/",
              to = "external/",
            },
            {
              from = "${env:GOPATH}/bazel-out/",
              to = "bazel-out/",
            },
            {
              from = "${env:GOPATH}/bazel-go-code/external/go_sdk",
              to = "GOROOT/",
            },
          },
        },
      }

      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
}
