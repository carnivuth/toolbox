return {
  "tkancf/telescope-markdown-frontmatter.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("markdown_frontmatter")
  end,
}
