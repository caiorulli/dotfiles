return {
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      colors = {
        up_to_date = "#3C4048",
        outdated = "#d19a66",
      },
      icons = {
        enable = true,
        style = {
          up_to_date = "|  ",
          outdated = "|  ",
        },
      },
      autostart = true,
      hide_up_to_date = false,
      hide_unstable_versions = false,
      package_manager = "pnpm",
    },
    keys = {
      { "<leader>ns", function() require("package-info").show() end, desc = "Show package versions" },
      { "<leader>nc", function() require("package-info").hide() end, desc = "Hide package versions" },
      { "<leader>nt", function() require("package-info").toggle() end, desc = "Toggle package versions" },
      { "<leader>nu", function() require("package-info").update() end, desc = "Update package on line" },
      { "<leader>nd", function() require("package-info").delete() end, desc = "Delete package on line" },
      { "<leader>ni", function() require("package-info").install() end, desc = "Install new package" },
      { "<leader>np", function() require("package-info").change_version() end, desc = "Install different package version" },
    },
  },
}