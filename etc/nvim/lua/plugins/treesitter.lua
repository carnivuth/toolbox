return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,

  main = "nvim-treesitter.configs",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    indent = {
      enable = true
    },
    ensure_installed = { "rust", "bash", "terraform", "python", "dockerfile", "yaml", "jinja","jinja_inline","c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "javascript", "html" },
  }
}
