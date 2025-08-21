-- hyprlang
vim.filetype.add({pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },})

-- ansible
vim.filetype.add({pattern = { [".*%.playbook.yml"] = "ansible" },})
vim.filetype.add({pattern = { [".*%.playbook.yaml"] = "ansible" },})
vim.filetype.add({pattern = { [".*/playbooks/.*%.yml"] = "ansible" },})
vim.filetype.add({pattern = { [".*/playbooks/.*%.yaml"] = "ansible" },})
vim.filetype.add({pattern = { [".*/roles/.*%.yml"] = "ansible" },})
vim.filetype.add({pattern = { [".*/roles/.*%.yaml"] = "ansible" },})

-- docker compose
vim.filetype.add({pattern = { [".*/docker%-compose%.yaml"] = "docker-compose" },})
vim.filetype.add({pattern = { [".*/docker%-compose%.yml"] = "docker-compose" },})
vim.filetype.add({pattern = { ["docker%-compose%.yaml"] = "docker-compose" },})
vim.filetype.add({pattern = { ["docker%-compose%.yml"] = "docker-compose" },})
vim.filetype.add({pattern = { [".*/compose/.*%.yml"] = "docker-compose" },})
vim.filetype.add({pattern = { [".*/compose/.*%.yaml"] = "docker-compose" },})


-- treesitter language configurations
vim.treesitter.language.register("yaml",{"docker-compose","ansible"})
