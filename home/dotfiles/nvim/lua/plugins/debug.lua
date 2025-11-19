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

      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = { "/Users/khck244/.local/share/js-debug/src/dapDebugServer.js", "${port}" },
        }
      }
      require("dap").configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }
      dap.adapters.go = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'dlv',
          args = { 'dap', '-l', '127.0.0.1:${port}' },
        },
      }

      dap.configurations.go = {
        {
          type = 'go',
          name = 'Debug',
          request = 'launch',
          program = '${file}',
        },
      }


      dap.configurations.go = {
        {
          type = 'go',
          name = 'Debug with env',
          request = 'launch',
          program = '${file}',
          env = {
          }
        }
      }
    end
  }
}
