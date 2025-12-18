return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ':TSUpdate',
  opts = {
    require'nvim-treesitter'.install { "rust", "bash", "terraform", "python", "dockerfile", "yaml", "jinja","jinja_inline","c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "javascript", "html" },
  }
}
