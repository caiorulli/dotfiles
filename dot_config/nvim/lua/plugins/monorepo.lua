return {
  {
    "imNel/monorepo.nvim",
    config = function()
      require("monorepo").setup({
        -- Automatically cd to the selected project
        auto_cd = true,
        -- Show the full path in the telescope prompt
        full_path = true,
        silent = true,
      })
    end,
    keys = {
      { "<leader>mp", function() require("monorepo").toggle() end, desc = "Switch monorepo project" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Custom keymaps for Nx monorepo navigation
      { "<leader>fp", function() require("telescope.builtin").find_files({ search_dirs = {"packages/"} }) end, desc = "Find files in packages" },
      { "<leader>sp", function() require("telescope.builtin").live_grep({ search_dirs = {"packages/"} }) end, desc = "Grep in packages" },
      { "<leader>fa", function() require("telescope.builtin").find_files({ search_dirs = {"packages/apps/"} }) end, desc = "Find files in apps" },
      { "<leader>fl", function() require("telescope.builtin").find_files({ search_dirs = {"packages/libs/"} }) end, desc = "Find files in libs" },
      { "<leader>fs", function() require("telescope.builtin").find_files({ search_dirs = {"packages/services/"} }) end, desc = "Find files in services" },
    },
  },
}