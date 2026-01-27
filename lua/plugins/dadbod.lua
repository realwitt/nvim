return {
  "kristijanhusak/vim-dadbod-ui",
  init = function()
    vim.g.db_ui_table_helpers = {
      postgresql = {
        List = "select * from {table} limit 1000",
      },
      mysql = {
        List = "select * from {table} limit 1000",
      },
      sqlite = {
        List = "select * from {table} limit 1000",
      },
    }
  end,
}
