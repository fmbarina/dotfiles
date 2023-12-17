local python = {
  {
    name = 'Launch python file with debugpy',
    type = 'python',
    request = 'launch',
    program = '${file}',
    pythonPath = function ()
      return '/usr/bin/python'
    end,
  },
}

local cppdbg = {
  {
    name = 'Launch file',
    type = 'cppdbg',
    request = 'launch',
    program = function ()
      return vim.fn.input('Executable path: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false,
      },
    },
  },
}

local lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
  }
}

return {
  setup = function (dap)
    dap.configurations = {
      python = python,
      c = cppdbg,
      cpp = cppdbg,
      rust = cppdbg,
      lua = lua,
    }
  end
}
