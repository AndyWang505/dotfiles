return {
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        sources = {
          explorer = {
            hidden = true,
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      prefer_local = "node_modules/.bin",
      formatters_by_ft = {
        typescript = { "prettier", "oxlint" },
        typescriptreact = { "prettier", "oxlint" },
        javascript = { "prettier", "oxlint" },
        javascriptreact = { "prettier", "oxlint" },
      },
      formatters = {
        oxlint = {
          command = "pnpm",
          args = { "exec", "oxlint", "--fix", "$FILENAME" },
          stdin = false,
          cwd = require("conform.util").root_file({ ".oxlintrc.json" }),
          condition = function(_, ctx)
            return vim.fs.find(".oxlintrc.json", { upward = true, path = ctx.dirname })[1] ~= nil
          end,
        },
      },
    },
  },
}