local nvim_dap = {
    "mfussenegger/nvim-dap",
    -- Load the other two along with this
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
    },
    lazy = true,
    ft = {"java"},
    config = function()
      local dap = require("dap")
      vim.keymap.set("n", "<space>db", dap.toggle_breakpoint, nil)
      vim.keymap.set("n", "<space>dc", dap.continue, nil)
      vim.keymap.set("n", "<space>di", dap.step_into, nil)
      vim.keymap.set("n", "<space>dl", dap.run_last, nil)
      vim.keymap.set("n", "<space>do", dap.step_out, nil)
      vim.keymap.set("n", "<space>dr", dap.repl.open, nil)
      vim.keymap.set("n", "<space>dv", dap.step_over, nil)
    end
}

local dap_ui = {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    lazy = true,
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      vim.keymap.set("n", "<space>dt", dapui.toggle, nil)

      -- dap.listeners.after.event_initialized.dapui_config = dapui.open
      -- dap.listeners.before.attach.dapui_config = dapui.open
      -- dap.listeners.before.launch.dapui_config = dapui.open
      -- dap.listeners.before.event_terminated.dapui_config = dapui.close
      -- dap.listeners.before.event_exited.dapui_config = dapui.close
    end
}

local dap_virtual_text = {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    lazy = true,
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = false,
      highlight_new_as_changed = false,
      show_stop_reason = false,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
      virt_text_pos = "inline",
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    }
}

return {
    nvim_dap,
    dap_ui,
    dap_virtual_text
}

-- vim: ts=2
