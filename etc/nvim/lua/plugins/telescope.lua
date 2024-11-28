return {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    pcall(require('telescope').load_extension, 'fzf')
    require("telescope").setup{
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          --preview_width = 0.65,
          horizontal = {
            size = {
              width = "95%",
              height = "95%",
            },
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
        }
      },
      mappings = {
      },
    }
  end
}
