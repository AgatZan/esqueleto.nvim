local utils = require("esqueleto.utils")

local M = {}

--- Create autocommands for `esqueleto.nvim`
---@param opts table Plugin configuration table
M.createautocmd = function(opts)
  -- create autocommands for skeleton insertion
  local group = vim.api.nvim_create_augroup("esqueleto", { clear = true })

  local function getpatterns()
    if type(opts.patterns) == "function" then
      if type(opts.directories) == "table" then
        return vim.tbl_map(opts.patterns, opts.directories)
      else
        return opts.patterns(opts.directories)
      end
    else
      return opts.patterns
    end
  end

  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPost", "BufNewFile" }, {
    group = group,
    desc = "esqueleto.nvim :: Insert template",
    pattern = getpatterns(),
    callback = function()
      if vim.bo.buftype == "nofile" then return nil end
      local filepath = vim.fn.expand("%")
      local emptyfile = vim.fn.getfsize(filepath) < 4
      if emptyfile then utils.inserttemplate(opts) end
    end,
  })
end

return M
