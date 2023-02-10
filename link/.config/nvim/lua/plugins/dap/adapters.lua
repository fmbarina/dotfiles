return {
  setup = function (dap)
    dap.adapters.python = {
      type = 'executable',
      command = vim.fn.stdpath('data') .. '/mason/bin/debugpy-adapter',
      -- args = {'--wait-for-client'},
    }

    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7',
    }
  end
}
