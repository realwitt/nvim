return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sqlfluff" },
    },
    formatters = {
      sqlfluff = {
        args = { "fix", "--ignore=templating", "-" },
        -- Find the directory containing .sqlfluff by walking up from the file
        cwd = function(_, ctx)
          local root = vim.fs.root(ctx.dirname, ".sqlfluff")
          return root or ctx.dirname
        end,
        -- Exit code 1 means there were unfixable violations, but formatting still worked
        exit_codes = { 0, 1 },
      },
    },
  },
}
