return {
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    dependencies = {
      { 'leoluz/nvim-dap-go' },
      {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
          require('nvim-dap-virtual-text').setup()
        end
      },
      {
        'mfussenegger/nvim-dap',
        config = function()
          require('dap-go').setup()
        end
      },
      "nvim-neotest/nvim-nio"
    },
    keys = {
      { '<Leader>b',  function() require('dap').toggle_breakpoint() end, desc = "DAP continue" },
      { '<Leader>dr', function() require('dap').repl.open() end,         desc = "DAP repl open" },
      { '<F5>',       function() require('dap').continue() end,          desc = "DAP continue" },
      { '<F10>',      function() require('dap').step_over() end,         desc = "DAP step over" },
      { '<F11>',      function() require('dap').step_into() end,         desc = "DAP step into" },
      { '<F12>',      function() require('dap').step_out() end,          desc = "DAP step out" },
    },

    config = function()
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- 1) Adapter definition for Go using delve
      dap.adapters.go = function(callback, _)
        -- Use delve's DAP mode
        callback({
          type = "server",
          host = "127.0.0.1",
          port = "${port}",
          executable = {
            command = "dlv",
            args = { "dap", "-l", "127.0.0.1:${port}" },
          },
        })
      end

      -- 2) Configurations for Go
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug file",
          request = "launch",
          program = "${file}", -- current file
        },
        {
          type = "go",
          name = "Debug package (cwd)",
          request = "launch",
          program = ".", -- current directory/package
        },
        {
          type = "go",
          name = "Debug test (file)",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug test (package)",
          request = "launch",
          mode = "test",
          program = "./...",
        },
      }
    end
  }
}
