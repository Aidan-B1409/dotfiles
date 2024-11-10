return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_organize_imports" },
    },
    formatters = {
      ruff_organize_imports = {
        command = "ruff",
        args = {
          "check",
          "--force-exclude",
          "--select=I001",
          "--fix",
          "--exit-zero",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
        stdin = true,
        cwd = require("conform.util").root_file({
          "pyproject.toml",
          "ruff.toml",
          ".ruff.toml",
        }),
      },
    },
  },
}
