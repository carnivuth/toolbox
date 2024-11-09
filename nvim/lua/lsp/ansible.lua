require('lspconfig').ansiblels.setup{
  filetypes ={"yaml","yml"};
  settings ={
    ansible = {
      ansible = {
        --path = "./env/bin/ansible"
      },
      executionEnvironment = {
        enabled = false
      },
      python = {
        --interpreterPath = "./env/bin/python"
      },
      validation = {
        enabled = true,
        lint = {
          enabled = true,
          --path = "./env/bin/ansible-lint"
        }
      }
    }
  }
}
