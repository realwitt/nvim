-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Format SQL strings in Go code
vim.api.nvim_create_user_command("FormatSQLString", function(opts)
  local sql = table.concat(vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false), "\n")
  if #sql == 0 then return end

  local dir = vim.fn.expand("~/.config/nvim")
  local wrap = vim.trim(sql):match("^CASE") and not sql:match("^SELECT") and not sql:match("^WITH")
  if wrap then sql = "SELECT " .. sql .. " AS result" end

  -- Replace Go placeholders with temp identifiers
  local ph = {}
  local n = 0
  local function r(m) n = n + 1; local p = "X" .. n .. "X"; ph[p] = m; return p end
  sql = sql:gsub("%%%[%d]+s", r):gsub("%%%d+", r):gsub("%%[vsd]", r)

  -- Format with sqlfluff
  local cmd = vim.fn.executable(vim.fn.expand("~/.local/share/nvim/mason/bin/sqlfluff")) == 1
    and vim.fn.expand("~/.local/share/nvim/mason/bin/sqlfluff") or "sqlfluff"
  if vim.fn.executable(cmd) == 0 then vim.notify("sqlfluff not found", vim.log.levels.ERROR); return end

  local tmp = dir .. "/" .. vim.fn.fnamemodify(vim.fn.tempname(), ":t") .. ".sql"
  vim.fn.writefile(vim.split(sql, "\n"), tmp)
  vim.fn.system(string.format("cd %s && %s format --ignore parsing --ignore templating %s 2>&1",
    vim.fn.shellescape(dir), vim.fn.shellescape(cmd), vim.fn.shellescape(vim.fn.fnamemodify(tmp, ":t"))))
  
  local res = table.concat(vim.fn.readfile(tmp), "\n")
  vim.fn.delete(tmp)
  if vim.v.shell_error ~= 0 and vim.v.shell_error ~= 1 then vim.notify("sqlfluff failed", vim.log.levels.ERROR); return end

  -- Restore
  if wrap then res = res:gsub("^%s*select%s+", ""):gsub("%s+as%s+result%s*$", "") end
  for p, o in pairs(ph) do
    local num = p:match("X(%d+)X")
    if num then res = res:gsub("[Xx]" .. num .. "[Xx]", o:gsub("%%", "%%%%")) end
  end

  vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, vim.split(vim.trim(res), "\n"))
  vim.notify("SQL formatted", vim.log.levels.INFO)
end, { range = true, desc = "Format selected SQL string" })
