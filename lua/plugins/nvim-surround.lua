return {
  -- nvim-surround: Lua port of tpope's vim-surround
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    opts = {
      keymaps = {
        -- Use 's' in visual mode like classic vim-surround
        visual = "s",
        visual_line = "S",
      },
    },
  },

  -- Disable flash.nvim's 's' mapping in visual mode to avoid conflict
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T", [";"] = "L", [","] = "H" },
        },
      },
    },
    keys = {
      -- Remove the 's' visual mode mapping from flash
      { "s", mode = { "n", "x", "o" }, false },
    },
  },
}
