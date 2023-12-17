-- Big thanks to: github.com/harrisoncramer/nvim
return {
  'rcarriga/nvim-dap-ui',
  event = {'BufReadPost', 'BufNewFile'},
  dependencies = {
    'mfussenegger/nvim-dap',
    -- nvim-dap-virtual-text
    'theHamsta/nvim-dap-virtual-text',
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    -- mason-nvim-dap
    'jay-babu/mason-nvim-dap.nvim',
    'williamboman/mason.nvim',
    -- lua-json5 (for launch.json reading)
    {'Joakker/lua-json5', build = './install.sh'},
    -- languages
    {'jbyuki/one-small-step-for-vimkind'},
  },
  config = function ()
    local dap = require'dap'
    local dap_ui = require'dapui'
    local virt_text = require'nvim-dap-virtual-text'
    local mason_dap = require'mason-nvim-dap'

    local adapters = require'plugins.dap.adapters'
    local configurations = require'plugins.dap.configurations'

    dap.set_log_level('INFO') -- see logs with :DapShowLog

    -- Install debuggers
    mason_dap.setup({
      ensure_installed = {
        'cppdbg', 'python',
      },
      automatic_installation = true
    })

    -- Adapters
    adapters.setup(dap)

    -- Configurations
    configurations.setup(dap)

    -- Keys and ui

    local dap_signs = {
      breakpoint = {
        text = '◉',
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      },
      breakpointCond = {
        text = 'Ⓒ',
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      },
      logPoint = {
        text = '⚑',
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      },
      stopped = {
        text = '≫',
        texthl = 'DiagnosticSignInfo',
        linehl = 'DiagnosticUnderlineInfo',
        numhl = 'DiagnosticSignInfo',
      },
      rejected = {
        text = '',
        texthl = 'DiagnosticSignHint',
        linehl = '',
        numhl = '',
      },
    }

    vim.fn.sign_define("DapBreakpoint", dap_signs.breakpoint)
    vim.fn.sign_define("DapBreakpointCondition", dap_signs.breakpointCond)
    vim.fn.sign_define("DapLogPoint", dap_signs.logPoint)
    vim.fn.sign_define("DapStopped", dap_signs.stopped)
    vim.fn.sign_define("DapBreakpointRejected", dap_signs.rejected)

    local function start_debug()
      dap.continue({})
      vim.cmd("tabedit %")
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<C-o>", false, true, true), "n", false
      )
      dap_ui.toggle({})
    end

    local function end_debug()
      dap_ui.toggle({})
      dap.terminate({}, { terminateDebuggee = true }, function()
        vim.cmd.tabclose()
      end)
    end

    vim.keymap.set("n", "<leader>ds", start_debug,
      {desc = 'Start debugging in new tab'})
    vim.keymap.set("n", "<leader>de", end_debug,
      {desc = 'Close debugging tab'})
    vim.keymap.set("n", "<leader>dr", dap.restart,
      {desc = "Dap restart session"})
    vim.keymap.set("n", "<leader>dh", require('dap.ui.widgets').hover,
      {desc = 'Dap UI hover'})
    vim.keymap.set("n", "<leader>dc", dap.continue,
      {desc = 'Dap continue to next breakpoint'})
    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint,
      {desc = 'Dap toggle breakpoint'})
    vim.keymap.set("n", "<leader>dC", dap.clear_breakpoints,
      {desc = 'Dap clear breakpoints'})
    vim.keymap.set("n", "<leader>dl", function()
      dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end,
      {desc = 'Dap set logpoint'})
    vim.keymap.set("n", "<leader>dn", dap.step_over, {desc = 'Dap step over'})
    vim.keymap.set("n", "<leader>di", dap.step_into, {desc = 'Dap step into'})
    vim.keymap.set("n", "<leader>do", dap.step_out, {desc = 'Dap step out'})
    vim.keymap.set("n", "<leader>db", dap.step_out, {desc = 'Dap step back'})
    -- vim.keymap.set("n", "<leader>dsc", dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')))
    -- vim.keymap.set("n", "<leader>dsl", dap.set_breakpoint({ nil, nil, vim.fn.input('Log point message: ')}))

    dap_ui.setup()

    virt_text.setup()

    -- launch.json
    -- TODO: literally check if this works at all. Might be useful:
    -- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
    require('dap.ext.vscode').json_decode = require('json5').parse
    vim.keymap.set('n', '<leader>djs', function ()
      require('dap.ext.vscode').load_launchjs(nil, {})
    end,
      {desc = 'Load launch.js'})
  end
}
