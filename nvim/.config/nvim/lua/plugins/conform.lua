return {
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
}
