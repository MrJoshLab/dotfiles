local vim = vim
local api = vim.api
local utils = require "telescope.utils"
local themes = require 'telescope.themes'
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local conf = require "telescope.config".values
local action_state = require "telescope.actions.state"

local M = {}

function M.setup(opts)
  opts = opts or {}
  M.config = {
    boundary_addr = opts.boundary_addr or "",
    boundary_telescope_script_path = opts.boundary_telescope_script_path or
    vim.fn.stdpath('config') .. "/plugged/boundary.nvim/scripts/boundary_telescope_cmd.sh",
  }
end

local function run_command(command)
    local on_stdout = function(_, data, _)
        print(vim.inspect(data)) -- Print the output to NeoVim's command line
    end
    local on_stderr = function(_, data, _)
        print("Error: " .. vim.inspect(data)) -- Print errors to the command line
    end
    local on_exit = function(_, data, _)
        print("Process exited with code: " .. data) -- Print exit code
    end
    local opts = {
        on_stdout = on_stdout,
        on_stderr = on_stderr,
        on_exit = on_exit,
    }
    vim.fn.jobstart(command, opts)
end

local function open_terminal(target_id, port)
  -- Run Boundary connect command
  run_command('boundary connect -target-id=' .. target_id .. ' -format json')
  -- Open the target's URL in the browser
  run_command("open http://127.0.0.1:".. port)
end

local function open_target(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  local tmp_table = vim.split(selection.value, "\t")
  if vim.tbl_isempty(tmp_table) then
    return
  end
  local target_id = tmp_table[1]
  local port = tmp_table[2]
  open_terminal(target_id, port)
end

M.targets = function (opts)

  opts = opts or {}
  opts.limit = opts.limit or 100

  vim.env.BOUNDARY_ADDR = M.config.boundary_addr
  local cmd = {
    M.config.boundary_telescope_script_path,
  }
  local output = utils.get_os_command_output(cmd)

  if not output or #output == 0 then
    api.nvim_err_writeln("No targets found")
    return
  end

  pickers.new(
    opts,
    themes.get_dropdown({
      prompt_prefix = "Targets > ",
      sorter = conf.generic_sorter(opts),
      border = true,
      finder = finders.new_table {
        results = output,
      },
      prompt_title = "< Buffers >",
      attach_mappings = function(_, map)
        map("i", "<CR>", open_target)
        return true
      end
    })
  ):find()

end

return M
