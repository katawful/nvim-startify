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
local file, render, _, _0, _1 = autoload("nvim-startify.utils.file"), autoload("nvim-startify.render.init"), nil, nil, nil
_2amodule_locals_2a["file"] = file
_2amodule_locals_2a["render"] = render
_2amodule_locals_2a["_"] = _1
_2amodule_locals_2a["_"] = _1
_2amodule_locals_2a["_"] = _1
local startify_aug = vim.api.nvim_create_augroup("startify", {clear = true})
do end (_2amodule_2a)["startify-aug"] = startify_aug
local function get_arglist()
  return vim.fn.argc()
end
_2amodule_locals_2a["get-arglist"] = get_arglist
local function is_buf_empty_3f(buf)
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
_2amodule_locals_2a["is-buf-empty?"] = is_buf_empty_3f
local function on_empty_session()
  if ((get_arglist() == 0) and is_buf_empty_3f(0)) then
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
_2amodule_locals_2a["on-empty-session"] = on_empty_session
local function update_oldfiles()
  if (vim.g.startify_update_oldfiles == 1) then
    local function _8_(args)
      return file["update-oldfiles"](vim.fn.expand(("<afile>" .. ":p")))
    end
    return {vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufFilePre"}, {callback = _8_, group = startify_aug, pattern = "*"})}
  else
    return nil
  end
end
_2amodule_locals_2a["update-oldfiles"] = update_oldfiles
local function on_vimenter()
  on_empty_session()
  return update_oldfiles()
end
_2amodule_2a["on-vimenter"] = on_vimenter
local function init()
  local function _10_()
    return on_vimenter()
  end
  return {vim.api.nvim_create_autocmd("VimEnter", {nested = true, callback = _10_, pattern = "*", group = startify_aug})}
end
_2amodule_2a["init"] = init
return _2amodule_2a