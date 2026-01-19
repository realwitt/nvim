return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sqlfluff" },
      -- Dadbod filetypes
      dbout = { "sqlfluff" },
      dbui = { "sqlfluff" },
    },
    formatters = {
      sqlfluff = {
        args = { "fix", "--ignore=templating", "-" },
        -- Find the directory containing .sqlfluff by walking up from the file
        -- Fallback to nvim config directory which has .sqlfluff
        cwd = function(_, ctx)
          local root = vim.fs.root(ctx.dirname, ".sqlfluff")
          if root then
            return root
          end
          -- Fallback: use nvim config directory which has .sqlfluff
          return vim.fn.expand("~/.config/nvim")
        end,
        -- Exit code 1 means there were unfixable violations, but formatting still worked
        exit_codes = { 0, 1 },
      },
    },
  },
}
