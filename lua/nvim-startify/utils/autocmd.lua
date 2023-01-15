local _2afile_2a = "fnl/nvim-startify/utils/autocmd.fnl"
local _2amodule_name_2a = "nvim-startify.utils.autocmd"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("nvim-startify.aniseed.autoload")).autoload
local render, _, _0, _1 = autoload("nvim-startify.render.init"), nil, nil, nil
_2amodule_locals_2a["render"] = render
_2amodule_locals_2a["_"] = _1
_2amodule_locals_2a["_"] = _1
_2amodule_locals_2a["_"] = _1
local function get_arglist()
  return vim.fn.argc()
end
_2amodule_locals_2a["get-arglist"] = get_arglist
local function is_buf_empty(buf)
  local buf_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local buf_length = #buf_lines
  if (buf_length > 0) then
    if ((buf_length == 1) and (#buf_lines[1] == 0)) then
      return true
    else
      return false
    end
  else
    return true
  end
end
_2amodule_locals_2a["is-buf-empty"] = is_buf_empty
local function on_vimenter()
  if ((get_arglist() == 0) and is_buf_empty(0)) then
    local function _3_()
      return vim.g.startify_session_autoload
    end
    local function _4_()
      local result_2_auto = vim.fn.filereadable("Session.vim")
      if (result_2_auto == 0) then
        return false
      else
        return true
      end
    end
    if (_3_() and _4_()) then
      return vim.cmd.source("Session.vim")
    elseif ((vim.g.startify_disable_at_vimenter == 0) or (vim.g.startify_disable_at_vimenter == nil)) then
      return render.init()
    else
      return nil
    end
  else
    return nil
  end
end
_2amodule_2a["on-vimenter"] = on_vimenter
return _2amodule_2a