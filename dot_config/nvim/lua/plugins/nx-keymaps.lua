return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>n", group = "Nx/Package Management" },
        { "<leader>nx", group = "Nx Commands" },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Nx workflow keymaps
      { "<leader>nxa", ":!pnpm build-all<CR>", desc = "Build all projects" },
      { "<leader>nxA", ":!pnpm build-affected<CR>", desc = "Build affected projects" },
      { "<leader>nxt", ":!pnpm test-all<CR>", desc = "Test all projects" },
      { "<leader>nxT", ":!pnpm test-affected<CR>", desc = "Test affected projects" },
      { "<leader>nxl", ":!pnpm lint-all<CR>", desc = "Lint all projects" },
      { "<leader>nxL", ":!pnpm lint-affected<CR>", desc = "Lint affected projects" },
      { "<leader>nxd", ":!pnpm ldev<CR>", desc = "Local development tool" },
      { "<leader>nxs", ":!pnpm sync<CR>", desc = "Sync (pull, install, ci)" },
    },
  },
}