return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "CodeCompanionChat",
      "CodeCompanionActions",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI chat (toggle)" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI action palette" },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to AI chat" },
    },
    opts = {
      -- Drive OpenCode (already configured via Home Manager `programs.opencode`)
      -- through the Agent Client Protocol. The built-in `opencode` adapter
      -- spawns `opencode acp`, inheriting OpenCode's provider/model/auth
      -- (Bedrock via the AI gateway, creds from ~/.env.ai). No API keys here.
      --
      -- NOTE: ACP adapters only power the *chat* interaction. The inline
      -- assistant (`:CodeCompanion`) requires an HTTP adapter and is therefore
      -- not wired up here.
      interactions = {
        chat = {
          adapter = "opencode",
        },
      },
    },
  },
}
