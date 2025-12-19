-- BASH
local lsps = {

    { "bashls" },
    { "html" },
    { "terraformls" },
    { "gopls" },
    { "eslint" },
    { "dockerls" },
    {
      "yamlls",{
        filetypes ={"yaml","ansible","docker-compose"};
      }
    },
    {
      "docker_compose_language_service",{
        filetypes ={"docker-compose"}
      }
    },
    {
      "lua_ls",{
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
    },
    {
      "ansiblels",{
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
    },
  {
    "pyright",{
      settings = {
        python = {
          pythonpath  = vim.fn.getcwd() .. "/env/bin/python3"
        }
      }
    }
  },
}

for _, lsp in pairs(lsps) do

    local name, config = lsp[1], lsp[2]

    vim.lsp.enable(name)

    if config then

        vim.lsp.config(name, config)

    end

end
