return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      -- Surround keymaps (normal mode)
      { "ys", desc = "Surround: Add" },
      { "ds", desc = "Surround: Delete" },
      { "cs", desc = "Surround: Change" },

      -- Surround keymaps (visual mode)
      { "s", desc = "Surround selection", mode = "v" },
      { "S", desc = "Surround lines", mode = "v" },

      -- Picker window navigation
      { "<C-h>", desc = "Window left / Focus list", mode = { "n", "i" } },
      { "<C-l>", desc = "Window right / Focus preview", mode = { "n", "i" } },
      { "<C-d>", desc = "Delete scratch buffer", mode = { "n", "i" } },
    },
  },
}

