return {
  "frankroeder/parrot.nvim",
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
  -- optionally include "folke/noice.nvim" or "rcarriga/nvim-notify" for beautiful notifications
  config = function()
    require("parrot").setup {
      -- Providers must be explicitly set up to make them available.
      enable_preview_mode = false,
      providers = {
        ollama = {
          name = "ollama",
          endpoint = "http://localhost:11434/api/chat",
          api_key = '',
          params = {
            chat = { temperature = 1.5, top_p = 1, num_ctx = 8192, min_p = 0.05 },
            command = { temperature = 1.5, top_p = 1, num_ctx = 8192, min_p = 0.05 },
          },
          topic_prompt = [[
            Summarize the chat above and only provide a short headline of 2 to 3
            words without any opening phrase like "Sure, here is the summary",
            "Sure! Here's a shortheadline summarizing the chat" or anything similar.
          ]],
          topic = {
            model = "deepseek-coder:1.3b",
            params = { max_tokens = 32 },
          },
          headers = {
            ["Content-Type"] = "application/json",
          },
          models = {
            "deepseek-coder:1.3b",
            "deepseek-coder-v2:16b",
          },
          resolve_api_key = function()
            return true
          end,
          process_stdout = function(response)
            if response:match "message" and response:match "content" then
              local ok, data = pcall(vim.json.decode, response)
              if ok and data.message and data.message.content then
                return data.message.content
              end
            end
          end,
          get_available_models = function(self)
            local url = self.endpoint:gsub("chat", "")
            local logger = require "parrot.logger"
            local job = Job:new({
              command = "curl",
              args = { "-H", "Content-Type: application/json", url .. "tags" },
            }):sync()
            local parsed_response = require("parrot.utils").parse_raw_response(job)
            self:process_onexit(parsed_response)
            if parsed_response == "" then
              logger.debug("Ollama server not running on " .. endpoint_api)
              return {}
            end

            local success, parsed_data = pcall(vim.json.decode, parsed_response)
            if not success then
              logger.error("Ollama - Error parsing JSON: " .. vim.inspect(parsed_data))
              return {}
            end

            if not parsed_data.models then
              logger.error "Ollama - No models found. Please use 'ollama pull' to download one."
              return {}
            end

            local names = {}
            for _, model in ipairs(parsed_data.models) do
              table.insert(names, model.name)
            end

            return names
          end,
        },
      },
    }
  end,
}
