-- BASH
require("lspconfig").bashls.setup{}
require("lspconfig").yamlls.setup{
  filetypes ={"yaml","ansible","docker-compose"};
}

-- DOCKER COMPOSE
require("lspconfig").docker_compose_language_service.setup{
  filetypes ={"docker-compose"};
}

-- DOCKER
require("lspconfig").dockerls.setup{}

-- TERRAFORM
require("lspconfig").terraformls.setup{}

-- ANSIBLE
require('lspconfig').ansiblels.setup{
  filetypes ={"ansible"};
  settings ={
    ansible = {
      ansible = {
        path = vim.fn.getcwd() .. "/env/bin/ansible"
      },
      executionEnvironment = {
        enabled = false
      },
      python = {
        interpreterPath = vim.fn.getcwd() .. "/env/bin/python3"
      },
      validation = {
        enabled = true,
        lint = {
          enabled = true,
          path = vim.fn.getcwd() .. "/env/bin/ansible-lint",
        }
      }
    }
  }
}

-- PYTHON
require("lspconfig").pyright.setup{
  settings = {
    python = {
      pythonPath  = vim.fn.getcwd() .. "/env/bin/python3"
    }
  }
}

-- GO
require("lspconfig").gopls.setup{}

-- JAVASCRIPT
require("lspconfig").eslint.setup{}

-- HTML
require("lspconfig").html.setup{}

-- LATEX
require("lspconfig").ltex.setup{}

-- LUA
require'lspconfig'.lua_ls.setup{
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  }
}

