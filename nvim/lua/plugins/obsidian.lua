return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    -- completion
    "hrsh7th/nvim-cmp",

  },
  main= "obsidian",
  attachments = {
    img_folder = "assets",
  },
  opts = {
    workspaces = {
      {
        name = "computer_vision",
        path = "~/vaults/computer_vision",
      },
    },
    notes_subdir = "pages",
    completion = {
      nvim_cmp = true,
      min_chars = 1,
    },
    picker = {
    name = "telescope.nvim",
    mappings = {
      -- Create a new note from your query.
      new = "<C-x>",
      -- Insert a link to the selected note.
      insert_link = "<C-l>",
    },
  },

  },
}
