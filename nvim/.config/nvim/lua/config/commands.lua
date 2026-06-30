--- Commands ---

-- :Build [cmd]  async build into the quickfix list (default: make).
-- Opens quickfix on failure, closes it, and notifies on success.
local function build(opts)
  local cmd = opts.args ~= '' and opts.args or 'make'
  local efm = vim.o.errorformat
  local lines = {}
  local function collect(_, data)
    if data then
      for _, l in ipairs(data) do
        if l ~= '' then lines[#lines + 1] = l end
      end
    end
  end

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = collect,
    on_stderr = collect,
    on_exit = function (_, code)
      vim.fn.setqflist({}, ' ', { title = cmd, lines = lines, efm = efm })
      if code == 0 then
        vim.cmd('cclose')
        vim.notify(cmd .. ' ✓')
      else
        vim.cmd('copen')
        vim.notify(cmd .. ' ✗', vim.log.levels.ERROR)
      end
    end,
  })
end
vim.api.nvim_create_user_command('Build', build, { nargs = '*', desc = 'Async build into quickfix'})

-- :Run {cmd}  run in a terminal split.
-- The terminal follows output, closes on success, or stays on failure.
local function run(opts)
  local origin = vim.api.nvim_get_current_win()

  vim.cmd('botright 10new')
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()

  local prev = 0
  vim.api.nvim_buf_attach(buf, false, {
    on_lines = function ()
      if not vim.api.nvim_win_is_valid(win) then return true end

      vim.schedule(function ()
        if not vim.api.nvim_win_is_valid(win) then return end
        local last = vim.api.nvim_buf_line_count(buf)
        if vim.api.nvim_win_get_cursor(win)[1] >= prev then
          pcall(vim.api.nvim_win_set_cursor, win, { last, 0 })
        end
        prev = last
      end)
    end,
  })

  vim.fn.jobstart(opts.args, {
    term = true,
    on_exit = function (_, code)
      if code == 0 then
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
        vim.notify(opts.args .. ' ✓')
      else
        vim.notify(opts.args .. ' ✗', vim.log.levels.ERROR)
      end
    end
  })

  vim.api.nvim_set_current_win(origin)
end
vim.api.nvim_create_user_command('Run', run, { nargs = '+', desc = 'Run a command in an auto-closing terminal' })
