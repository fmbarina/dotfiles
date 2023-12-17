return {
  setup = function(dap)
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

    dap.adapters.nlua = function(callback, config)
      callback({
        type = 'server',
        host = config.host or "127.0.0.1",
        port = config.port or 8086
      })
    end
  end
}
