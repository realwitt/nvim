return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] = {
        args = { "--config", vim.fn.expand("~/.config/nvim/.markdownlint.json") },
      }
      opts.linters["sqlfluff"] = {
        args = { "lint", "--format=json", "--ignore=templating", "-" },
        -- Use nvim config directory which has .sqlfluff
        -- sqlfluff will find the config file automatically
        cwd = vim.fn.expand("~/.config/nvim"),
      }
      
      -- Add SQL linting for dadbod filetypes
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.dbout = opts.linters_by_ft.dbout or {}
      opts.linters_by_ft.dbui = opts.linters_by_ft.dbui or {}
      table.insert(opts.linters_by_ft.dbout, "sqlfluff")
      table.insert(opts.linters_by_ft.dbui, "sqlfluff")
    end,
  },
}
