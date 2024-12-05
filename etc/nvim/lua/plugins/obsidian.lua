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
     ui = { enable = false },
    workspaces = {
      {
        name = "linguaggi_modelli_computazionali",
        path = "~/vaults/linguaggi_modelli_computazionali",
      },
      {
        name = "sicurezza_informazione",
        path = "~/vaults/sicurezza_informazione",
      },
      {
        name = "datamining",
        path = "~/vaults/datamining",
      },
      {
        name = "TIL",
        path = "~/vaults/TIL",
      },
      {
        name = "mobile_systems",
        path = "~/vaults/mobile_systems",
      },
      {
        name = "computer_graphics",
        path = "~/vaults/computer_graphics",
      },
      {
        name = "computer_vision",
        path = "~/vaults/computer_vision",
      },
      {
        name = "notes",
        path = "~/standard/notes",
      }
    },
    templates = {
        folder = "templates",
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
