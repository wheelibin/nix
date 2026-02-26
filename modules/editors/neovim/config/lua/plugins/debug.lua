return {
  {
    'igorlfs/nvim-dap-view',
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
      -- "nvim-neotest/nvim-nio"
    },
    keys = {
      { '<Leader>b', function() require('dap').toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { '<F5>',      function() require('dap').continue() end,          desc = "DAP continue" },
      { '<F10>',     function() require('dap').step_over() end,         desc = "DAP step over" },
      { '<F11>',     function() require('dap').step_into() end,         desc = "DAP step into" },
      { '<F12>',     function() require('dap').step_out() end,          desc = "DAP step out" },
    },

    config = function()
      local dap, dapView = require("dap"), require("dap-view")
      dapView.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapView.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapView.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapView.close()
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
        {
          type = "go",
          name = "Debug single test (file)",
          request = "launch",
          mode = "test",
          program = "${file}",
          args = function()
            local test = vim.fn.input("Test name (regex): ")
            return { "-test.run", test }
          end,
        },

      }
    end
  }
}
