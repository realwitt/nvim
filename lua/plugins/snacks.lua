return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        scratch = {
          win = {
            input = {
              keys = {
                ["<C-d>"] = { "scratch_delete", mode = { "i", "n" }, desc = "Delete scratch" },
              },
            },
            list = {
              keys = {
                ["<C-d>"] = { "scratch_delete", mode = "n", desc = "Delete scratch" },
              },
            },
          },
        },
      },
      win = {
        input = {
          keys = {
            ["<C-h>"] = { "focus_list", mode = { "i", "n" }, desc = "Focus list" },
            ["<C-l>"] = { "focus_preview", mode = { "i", "n" }, desc = "Focus preview" },
          },
        },
        list = {
          keys = {
            ["<C-h>"] = { "focus_input", mode = "n", desc = "Focus input" },
            ["<C-l>"] = { "focus_preview", mode = "n", desc = "Focus preview" },
          },
        },
        preview = {
          keys = {
            ["<C-h>"] = { "focus_list", mode = "n", desc = "Focus list" },
            ["<C-l>"] = { "focus_input", mode = "n", desc = "Focus input" },
          },
        },
      },
    },
  },
}

