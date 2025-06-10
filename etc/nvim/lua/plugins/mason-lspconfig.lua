return {
  "williamboman/mason-lspconfig.nvim",
  opts={
    ensure_installed= {
      "vimls",
      "ansiblels",
      "gopls",
      "pyright",
      "bashls",
      "terraformls",
      "docker_compose_language_service",
      "dockerls",
      "eslint",
      "html",
      "lua_ls",
      "yamlls",
      "rust_analyzer",
    },
  }
}
