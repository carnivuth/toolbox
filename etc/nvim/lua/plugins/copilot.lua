return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  opts = {
    suggestion = {
      enabled = not vim.g.ai_cmp,
      trigger_on_accept = true,

      auto_trigger = true,
      hide_during_completion = vim.g.ai_cmp,

      keymap = {
        accept = false, -- handled by nvim-cmp / blink.cmp
        next = "<M-]>",

        prev = "<M-[>",
      },
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,

      help = true,
      sh = function ()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
          -- disable for .env files
          return false
        end
        return true
      end,
    },
  },
}
